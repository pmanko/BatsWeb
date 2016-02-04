<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="gameSummary.aspx.cbl" Inherits="batsweb.gameSummary" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link type="text/css" href="/Styles/gamesummary.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/gamesummary.js"></script> 
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
    <script type="text/javascript" src="Scripts/summarycallatbat.js"></script> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div class="panel panel-default" id="gamesPanel">
                <div class="panel-heading">
                    <div class="panel-title">List of Games</div>
                </div>

                <asp:Table id="gamesTable" runat="server" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                data-index-field="#MainContent_gamesIndexField" 
                                data-value-field="#MainContent_gamesValueField" 
                                data-postback="double" 
                                data-multiple="false"
                    >
                    <asp:TableHeaderRow TableSection="TableHeader">
                        <asp:TableHeaderCell>Date      Vis                      Home                   Time Video</asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                                
                </asp:Table>
                <asp:HiddenField ID="gamesValueField" runat="server" onvaluechanged="gameSelected" />
                <asp:HiddenField ID="gamesIndexField" runat="server"   />
                <br />
                <div class="panel-footer">

                    <div class="row">
                    <div class="col-md-3">
                        <div class='radio radio-primary'>
                            <asp:RadioButton ID="allRadioButton" runat="server" GroupName="Games" Text="All Games" AutoPostBack="True" OnCheckedChanged="allRadioButton_CheckedChanged" />
                        </div>
                                                    
                        <div class='form-group'>
                        <label>Year:</label>
                        <asp:DropDownList ID="yearDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="yearDropDownList_SelectedIndexChanged" class="form-control">
                            <asp:ListItem>2020</asp:ListItem>
                            <asp:ListItem>2019</asp:ListItem>
                            <asp:ListItem>2018</asp:ListItem>
                            <asp:ListItem>2017</asp:ListItem>
                            <asp:ListItem>2016</asp:ListItem>
                            <asp:ListItem>2015</asp:ListItem>
                            <asp:ListItem>2014</asp:ListItem>
                            <asp:ListItem>2013</asp:ListItem>
                            <asp:ListItem>2012</asp:ListItem>
                            <asp:ListItem>2011</asp:ListItem>
                            <asp:ListItem>2010</asp:ListItem>
                            <asp:ListItem>2009</asp:ListItem>
                            <asp:ListItem>2008</asp:ListItem>
                            <asp:ListItem>2007</asp:ListItem>
                            <asp:ListItem>2006</asp:ListItem>
                            <asp:ListItem>2005</asp:ListItem>
                            <asp:ListItem>2004</asp:ListItem>
                            <asp:ListItem>2003</asp:ListItem>
                            <asp:ListItem>2002</asp:ListItem>
                            <asp:ListItem>2001</asp:ListItem>
                            <asp:ListItem>2000</asp:ListItem>
                            <asp:ListItem>1999</asp:ListItem>
                            <asp:ListItem>1998</asp:ListItem>
                            <asp:ListItem>1997</asp:ListItem>
                            <asp:ListItem>1996</asp:ListItem>
                            <asp:ListItem>1995</asp:ListItem>
                            <asp:ListItem>1994</asp:ListItem>
                            <asp:ListItem>1993</asp:ListItem>
                            <asp:ListItem>1992</asp:ListItem>
                            <asp:ListItem>1991</asp:ListItem>
                        </asp:DropDownList></div>

                    </div>
                    <div class="col-md-3 col-md-offset-1">

                        <div class='radio radio-primary'><asp:RadioButton ID="teamRadioButton" runat="server" GroupName="Games" Text="Team:" AutoPostBack="True" OnCheckedChanged="teamRadioButton_CheckedChanged" /></div>
                        <asp:DropDownList ID="teamDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="teamDropDownList_SelectedIndexChanged" class="form-control">
                        </asp:DropDownList>
                        
                        <div class='radio radio-primary'>
                            <asp:RadioButton ID="nlRadioButton" runat="server" GroupName="Games" Text="National League" AutoPostBack="True" OnCheckedChanged="nlRadioButton_CheckedChanged"
                            />
                        </div>
                        <div class='radio radio-primary'>
                            <asp:RadioButton ID="alRadioButton" runat="server" GroupName="Games" Text="American League" AutoPostBack="True" OnCheckedChanged="alRadioButton_CheckedChanged"
                            />
                        </div>
                        
                    </div>
                    <div class="col-md-3 col-md-offset-1">
                        <div class='checkbox checkbox-primary'>
                            <asp:CheckBox ID="pitchersCheckBox" runat="server" Text="Show Starting Pitchers" AutoPostBack="True" OnCheckedChanged="pitchersCheckBox_CheckedChanged"
                            />
                        </div>
                        
                        <asp:Button ID="inningsButton" runat="server" Text="Show Innings" OnClick="inningsButton_Click" class="btn btn-primary btn-block" />
                    </div>
                </div>
                </div>

            </div>

            <br />

            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-title">Inning Summary</div>
                </div>
                    
                <asp:Table id="inningSummaryTable" runat="server" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                    data-value-field="#MainContent_inningSummaryValueField" 
                    data-index-field="#MainContent_inningSummaryIndexField" 
                    data-postback="false" 
                    data-multiple="false"
                    data-on-select="inningRowSelected"
                    data-on-dblclick="openBatsTube"
                >
                                                                     
                </asp:Table>
                <asp:HiddenField ID="inningSummaryValueField" runat="server" />
                <asp:HiddenField ID="inningSummaryIndexField" runat="server"  />
                                    
                <div class="panel-footer">
                    <a href="#" class="btn btn-block btn-default" id="atBatDetail" data-action-flag="show-detail">At Bat Detail</a>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class='panel-body'>
                    <div class='row'>
                        <div class="col-md-3">
                            <a href="#" class="btn btn-block btn-default btn-async-request" data-action-flag="play-vis">Play Visitors</a>
                        </div>
                        <div class="col-md-3">
                            <a href="#" class="btn btn-block btn-default btn-async-request" data-action-flag="play-home">Play Home</a>
                        </div>
                        <div class="col-md-3">
                            <a href="#" class="btn btn-block btn-default btn-async-request" data-action-flag="from-selected">From Selected</a>
                        </div>
                        <div class="col-md-3">
                            <a href="#" class="btn btn-block btn-default btn-async-request" data-action-flag="play-full">Play full</a>
                        </div>
                    </div>
                    <br />
                    <div class='row'>
                        <div class="col-md-3">
                            <asp:Button ID="visButton" runat="server" Text="Select Visiting Player" OnClick="visButton_Click" class="btn btn-default btn-block" />
                            <cc1:ModalPopupExtender ID="HiddenField1Vis_ModalPopupExtender" runat="server" BehaviorID="HiddenField1Vis_ModalPopupExtender" TargetControlID="HiddenField1" PopupControlID="visPanel" BackgroundCssClass="ModalPopupBackgroundCssClass">
                            </cc1:ModalPopupExtender>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                        </div>
                        <div class="col-md-3">
                            <a href="#" class="btn btn-default btn-block" data-toggle="modal" data-target="#statsModal">View Game Stats</a>
                        </div>
                        <div class="col-md-3">
                            <asp:Button ID="replaysButton" runat="server" Text="Replays" class="btn btn-default btn-block" />
                        </div>
                        <div class="col-md-3">
                            <a href="#" id="selectHomePlayer" class="btn btn-default btn-block">Select Home Player</a>
                        </div>
                    </div>
                </div>
                    
            </div>

            <asp:Panel ID="visPanel" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-10">
                            View All Clips for Visiting Player
                        </div>
                        <div class="col-lg-2">
                            <asp:Button ID="backButton" Text="Back" runat="server" class="btn btn-danger"/>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button1" runat="server" Text="Button" Visible="False" OnClick="Button1_Click" width="155px" class="btn btn-default" />
                            <asp:Button ID="Button2" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button2_Click" class="btn btn-default" />
                            <asp:Button ID="Button3" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button3_Click" class="btn btn-default" />
                            <asp:Button ID="Button4" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button4_Click" class="btn btn-default" />
                            <asp:Button ID="Button5" runat="server" Text="Button" Visible="False" Width="155px" OnClick="Button5_Click" class="btn btn-default" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button6" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button6_Click" class="btn btn-default" />
                            <asp:Button ID="Button7" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button7_Click" class="btn btn-default" />
                            <asp:Button ID="Button8" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button8_Click" class="btn btn-default" />
                            <asp:Button ID="Button9" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button9_Click" class="btn btn-default" />
                            <asp:Button ID="Button10" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button10_Click" class="btn btn-default" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button11" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button11_Click" class="btn btn-default" />
                            <asp:Button ID="Button12" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button12_Click" class="btn btn-default" />
                            <asp:Button ID="Button13" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button13_Click" class="btn btn-default" />
                            <asp:Button ID="Button14" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button14_Click" class="btn btn-default" />
                            <asp:Button ID="Button15" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button15_Click" class="btn btn-default" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button16" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button16_Click" class="btn btn-default" />
                            <asp:Button ID="Button17" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button17_Click" class="btn btn-default" />
                            <asp:Button ID="Button18" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button18_Click" class="btn btn-default" />
                            <asp:Button ID="Button19" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button19_Click" class="btn btn-default" />
                            <asp:Button ID="Button20" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button20_Click" class="btn btn-default" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button21" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button21_Click" class="btn btn-default" />
                            <asp:Button ID="Button22" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button22_Click" class="btn btn-default" />
                            <asp:Button ID="Button23" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button23_Click" class="btn btn-default" />
                            <asp:Button ID="Button24" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button24_Click" class="btn btn-default" />
                            <asp:Button ID="Button25" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button25_Click" class="btn btn-default" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button26" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button26_Click" class="btn btn-default" />
                            <asp:Button ID="Button27" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button27_Click" class="btn btn-default" />
                            <asp:Button ID="Button28" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button28_Click" class="btn btn-default" />
                            <asp:Button ID="Button29" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button29_Click" class="btn btn-default" />
                            <asp:Button ID="Button30" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button30_Click" class="btn btn-default" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>


        <asp:Panel ID="homePanel" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-10">
                            View All Clips for Home Player
                        </div>
                        <div class="col-lg-2">
                            <asp:Button ID="backButton2" Text="Back" runat="server" class="btn btn-danger"/>
                        </div>
                    </div>
                </div>

<%--                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button31" runat="server" Text="Button" Visible="False" OnClick="Button31_Click" width="155px" class="btn btn-default" />
                            <asp:Button ID="Button32" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button32_Click" class="btn btn-default" />
                            <asp:Button ID="Button33" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button33_Click" class="btn btn-default" />
                            <asp:Button ID="Button34" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button34_Click" class="btn btn-default" />
                            <asp:Button ID="Button35" runat="server" Text="Button" Visible="False" Width="155px" OnClick="Button35_Click" class="btn btn-default" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button36" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button36_Click" class="btn btn-default" />
                            <asp:Button ID="Button37" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button37_Click" class="btn btn-default" />
                            <asp:Button ID="Button38" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button38_Click" class="btn btn-default" />
                            <asp:Button ID="Button39" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button39_Click" class="btn btn-default" />
                            <asp:Button ID="Button40" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button40_Click" class="btn btn-default" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button41" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button41_Click" class="btn btn-default" />
                            <asp:Button ID="Button42" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button42_Click" class="btn btn-default" />
                            <asp:Button ID="Button43" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button43_Click" class="btn btn-default" />
                            <asp:Button ID="Button44" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button44_Click" class="btn btn-default" />
                            <asp:Button ID="Button45" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button45_Click" class="btn btn-default" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button46" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button46_Click" class="btn btn-default" />
                            <asp:Button ID="Button47" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button47_Click" class="btn btn-default" />
                            <asp:Button ID="Button48" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button48_Click" class="btn btn-default" />
                            <asp:Button ID="Button49" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button49_Click" class="btn btn-default" />
                            <asp:Button ID="Button50" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button50_Click" class="btn btn-default" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button51" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button51_Click" class="btn btn-default" />
                            <asp:Button ID="Button52" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button52_Click" class="btn btn-default" />
                            <asp:Button ID="Button53" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button53_Click" class="btn btn-default" />
                            <asp:Button ID="Button54" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button54_Click" class="btn btn-default" />
                            <asp:Button ID="Button55" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button55_Click" class="btn btn-default" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="Button56" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button56_Click" class="btn btn-default" />
                            <asp:Button ID="Button57" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button57_Click" class="btn btn-default" />
                            <asp:Button ID="Button58" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button58_Click" class="btn btn-default" />
                            <asp:Button ID="Button59" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button59_Click" class="btn btn-default" />
                            <asp:Button ID="Button60" runat="server" Text="Button" Visible="False" width="155px" OnClick="Button60_Click" class="btn btn-default" />
                        </div>
                    </div>
                </div>--%>
            </div>
        </asp:Panel>

        <!-- Stats Modal -->

        <div class="modal fade" id="statsModal" tabindex="-1" role="dialog" aria-labelledby="statsModalLabel">
          <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="statsModalLabel">Current Game Stats</h4>
              </div>
              <div class="modal-body">
                 <asp:Table id="statsTable" runat="server" class="table table-condensed table-bordered table-hover listbox-replacement"></asp:Table>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div>
          </div>
        </div>

        <!-- Select Player Modal -->

        <div class="modal fade" id="selectPlayerModal" tabindex="-1" role="dialog" aria-labelledby="selectPlayerModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">View all clips for <span id="playerType"></span> Player</h4>
              </div>
              <div class="modal-body">
                

              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div>
          </div>
        </div>

    </form>
    </div>
</asp:Content>
