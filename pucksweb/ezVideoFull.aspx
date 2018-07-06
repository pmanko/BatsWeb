<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" Language="C#" CodeBehind="ezVideoFull.aspx.cbl" Inherits="batsweb.ezVideoFull" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Styles/ezvideofull.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
    <script type="text/javascript" src="Scripts/ezvideofull.js"></script> 
    <script type="text/javascript">
       $(document).ready(function () {
           var names = "<%= Session["nameArray"] %>".split(";");
              $("#MainContent_locatePlayerTextBox").autocomplete({
                  autoFocus: true,
                  source: function (request, response) {
                      var matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex(request.term), "i");
                      response($.grep(names, function (item) {
                          return matcher.test(item);
                      }));
                  }
              });
          });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Panel ID="Panel1" runat="server" GroupingText="Report Settings">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                               Select Player
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <label>Team:</label>
                                                <asp:DropDownList ID="TeamDropDownList" runat="server" OnSelectedIndexChanged="teamDropDownList_SelectedIndexChanged" AutoPostBack="True" class="form-control" >
                                                </asp:DropDownList> 
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <label>End Date:</label>
                                                <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTime" class="form-control"></asp:TextBox>
                                                <cc1:MaskedEditExtender ID="TextBox1_MaskedEditExtender" runat="server" BehaviorID="TextBox1_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" TargetControlID="TextBox1" />
                                                <cc1:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox1_CalendarExtender" TargetControlID="TextBox1" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-8">
                                        <div class="listbox-replacement-wrapper">
                                        <asp:Table 
                                            id="playerTable" runat="server" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                            data-index-field="#MainContent_playerIndexField" 
                                            data-value-field="#MainContent_playerValueField" 
                                            data-postback="double" 
                                            data-multiple="false">
                                        </asp:Table>
                                        <asp:HiddenField ID="playerIndexField" runat="server" onvaluechanged="player_Selected"/>
                                        <asp:HiddenField ID="playerValueField" runat="server"  />  
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>Locate Player:</label>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="ui-widget">
                                            <asp:TextBox ID="locatePlayerTextBox" runat="server" class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-2">
                                    </div>
                                    <div class="col-lg-4">
                                        <asp:Button ID="showButton" runat="server" Text="Show List of Videos" OnClick="showButton_Click" class="btn btn-primary btn-block" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                <div class="panel-heading">
                <div class="row">
                    <div class="col-lg-3">
                           <asp:TextBox ID="nameValue" runat="server" class="form-control"></asp:TextBox>
                    </div>
                    <div class="col-lg-3">
                        <dl class="dl-horizontal">
                            <dt>Bats:</dt>
                            <dd><asp:Literal ID="batsValue" runat="server" ></asp:Literal></dd>
                        </dl>
                    </div>
                    <div class="col-lg-3">
                        <dl class="dl-horizontal">
                            <dt>Throws:</dt>
                            <dd><asp:Literal ID="throwsValue" runat="server" ></asp:Literal></dd>
                        </dl>
                    </div>
                    <div class="col-lg-3">
                        <dl class="dl-horizontal">
                            <dt>Positions:</dt>
                            <dd><span><asp:Literal ID="posValue1" runat="server" ></asp:Literal>&vert;<asp:Literal ID="posValue2" runat="server" ></asp:Literal>&vert;<asp:Literal ID="posValue3" runat="server" ></asp:Literal></span></dd>
                        </dl>
                    </div>
                </div>
                </div>
                            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-2">
                        <div class="row">
                            <div class="col-lg-12">
                                <label>Select Videos:</label>
                                <asp:DropDownList ID="videosDropDownList" runat="server" OnSelectedIndexChanged="videosDropDownList_SelectedIndexChanged" AutoPostBack="True" class="form-control" >
                                    <asp:ListItem>All</asp:ListItem>
                                    <asp:ListItem>Block</asp:ListItem>
                                    <asp:ListItem>Throw</asp:ListItem>
                                    <asp:ListItem>Pickoff - 1st Base</asp:ListItem>
                                    <asp:ListItem>Pickoff - 2nd Base</asp:ListItem>
                                    <asp:ListItem>Pickoff - 3rd Base</asp:ListItem>
                                    <asp:ListItem>Batting</asp:ListItem>
                                    <asp:ListItem>Pitching</asp:ListItem>
                                    <asp:ListItem>Fielding</asp:ListItem>
                                    <asp:ListItem>Running</asp:ListItem>
                                    <asp:ListItem>Home Run</asp:ListItem>
                                    <asp:ListItem>Strike out</asp:ListItem>
                                    <asp:ListItem>Error</asp:ListItem>
                                    <asp:ListItem>Triple</asp:ListItem>
                                    <asp:ListItem>Double</asp:ListItem>
                                    <asp:ListItem>Single</asp:ListItem>
                                    <asp:ListItem>Replay</asp:ListItem>
                                </asp:DropDownList> 
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <label>Search:</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:TextBox ID="search1TextBox" runat="server" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <label>And</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:TextBox ID="search2TextBox" runat="server" class="form-control"></asp:TextBox>
                                <label>(optional)</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button ID="searchButton" runat="server" Text="Search" OnClick="searchButton_Click" class="btn btn-primary btn-block" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button ID="resetButton" runat="server" Text="Reset" OnClick="resetButton_Click" class="btn btn-danger btn-block" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-10">
                        <div class="listbox-replacement-wrapper">
                            <asp:Table id="videoTable" runat="server" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                            data-index-field="#MainContent_videoIndexField" 
                            data-value-field="#MainContent_videoValueField" 
                            data-postback="false" 
                            data-multiple="true"
                            data-on-select="videoUpdate"
                            data-on-dblclick="openBatsTube"
                             >
                            <asp:TableHeaderRow TableSection="TableHeader">
                                <asp:TableHeaderCell> Date          Clip               Description</asp:TableHeaderCell>
                            </asp:TableHeaderRow>
                            </asp:Table>
                        </div>
                        <asp:HiddenField ID="videoValueField" runat="server"  />
                        <asp:HiddenField ID="videoIndexField" runat="server"  />      
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                    </div>
                    <div class="col-lg-6">
                        <a href="#" id="showVideosButton" class="btn btn-lg btn-primary btn-block">Play Selected</a>
                    </div>
                </div>
                </div>
                </div>
            </asp:Panel>
    </div>

</asp:Content>