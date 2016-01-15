<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" Language="C#" CodeBehind="breakdown.aspx.cbl" Inherits="batsweb.breakdown" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
    <script type="text/javascript" src="Scripts/breakdowncallpark.js"></script> 
    <script type="text/javascript" src="Scripts/breakdown.js"></script> 
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


            <!----------------------->
            <!-- Modals and Popups -->
            <!----------------------->
            <div class="modal-container"></div>


            <!-- Change Report Selection Modal -->  
            <div class="modal fade" id="changeSelectionModal" tabindex="-1" role="dialog" aria-labelledby="changeSelectionModal">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Report Data Selection</h4>
                        </div>                                                      
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            Date Range
                                        </div>
                                        <div class="list-group">
                                            <div class="list-group-item">
                                                <h4>Start Date</h4>
                                                <div class='radio radio-primary'><asp:RadioButton ID="allStartRadioButton" runat="server" GroupName="startDate" text="All Games"  OnCheckedChanged="allStartRadioButton_CheckedChanged"/></div>
                                                <div class='radio radio-primary'><asp:RadioButton ID="startDateRadioButton" runat="server" GroupName="startDate" Text="Start Date:"  OnCheckedChanged="startDateRadioButton_CheckedChanged"/></div>
                                                <asp:TextBox ID="startDateTextBox" runat="server" TextMode="DateTime" class="form-control"></asp:TextBox>
                                                <cc1:MaskedEditExtender ID="startDateTextBox_MaskedEditExtender" runat="server" BehaviorID="startDateTextBox_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="startDateTextBox" />
                                                <cc1:CalendarExtender ID="startDateTextBox_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="startDateTextBox_CalendarExtender" TargetControlID="startDateTextBox" />
                                            </div>
                                            <div class="list-group-item">
                                                <h4>End Date</h4>
                                                <div class='radio radio-primary'><asp:RadioButton ID="allEndRadioButton" runat="server" GroupName="endDate" Text="All Games" OnCheckedChanged="allEndRadioButton_CheckedChanged"/></div>
                                                <div class='radio radio-primary'><asp:RadioButton ID="endDateRadioButton" runat="server" GroupName="endDate" Text="End Date:" OnCheckedChanged="endDateRadioButton_CheckedChanged"/></div>
                                                <asp:TextBox ID="endDateTextBox" runat="server" TextMode="DateTime"  class="form-control"></asp:TextBox>
                                                <cc1:MaskedEditExtender ID="endDateTextBox_MaskedEditExtender" runat="server" BehaviorID="endDateTextBox_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="endDateTextBox" />
                                                <cc1:CalendarExtender ID="endDateTextBox_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="endDateTextBox_CalendarExtender" DefaultView="Days" PopupPosition="BottomLeft" TargetControlID="endDateTextBox" />

                                            </div>
                                        </div>
                                        <a class="btn btn-md btn-info btn-block" data-toggle="modal" data-target="#oneClickDateModal">One-Click Dates</a>
                                    </div>
                                </div>                            
                                <div class="col-lg-4">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            Pitcher Choices
                                        </div> 
                                        <div class="panel-body">
                                            <h5>Current Pitcher Selection</h5>
                                            <asp:TextBox ID="pitcherSelectionTextBox" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                            <br />
                                            <div class="btn-toolbar" role="toolbar">
                                                <div class="btn-group"><asp:Button ID="pitcherallButton" runat="server" Text="All" OnClick="pitcherallButton_Click" CssClass="btn btn-default" /></div>
                                                <div class="btn-group">
                                                    <asp:Button ID="pitcherteamButton" runat="server" Text="Team" OnClick="pitcherteamButton_Click" CssClass="btn btn-default" />
                                                    <asp:HiddenField ID="pHiddenField" runat="server" />
                                                    <cc1:ModalPopupExtender ID="pHiddenFieldTeam_ModalPopupExtender" runat="server" BehaviorID="pHiddenFieldTeam_ModalPopupExtender" DynamicServicePath="" PopupControlID="pTeamPanel" TargetControlID="pHiddenField">
                                                    </cc1:ModalPopupExtender>
                                                </div>
                                                <div class="btn-group">
                                                    <asp:Button ID="selectpitcherButton" runat="server" Text="Select Player" OnClick="selectpitcherButton_Click"  CssClass="btn btn-default" />
                                                    <asp:HiddenField ID="ipHiddenField" runat="server" />
                                                    <cc1:ModalPopupExtender ID="ipHiddenField_ModalPopupExtender" runat="server" BehaviorID="ipHiddenField_ModalPopupExtender" DynamicServicePath="" PopupControlID="playerPanel" TargetControlID="ipHiddenField">
                                                    </cc1:ModalPopupExtender>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="list-group">
                                            <div class="list-group-item">
                                                <h5>Throw Selection</h5>
                                                <div class='radio radio-primary radio-inline'><asp:RadioButton ID="throwsleftRadioButton" runat="server" GroupName="throws" text="Left"  /></div>
                                                <div class='radio radio-primary radio-inline'><asp:RadioButton ID="throwseitherRadioButton" runat="server" GroupName="throws" text="Either"  /></div>
                                                <div class='radio radio-primary radio-inline'><asp:RadioButton ID="throwsrightRadioButton" runat="server" GroupName="throws" text="Right"  /></div>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="additionalOptionsPanel">
                                            <h4 class="panel-title">
                                                <a class="collapsed" role="button" data-toggle="collapse" href="#additionalPitcherOptions" aria-expanded="false" aria-controls="additionalPitcherOptions">
                                                    <i class="fa fa-caret-right pull-left"></i>
                                                    Additional Pitcher Options                                                
                                                </a>
                                            </h4>
                                        </div>
                                        <div class="panel-collapse collapse" id="additionalPitcherOptions">
                                            <div class="panel-body">
                                                
                                                <div class="row">
                                                    <div class="col-lg-2">
                                                        <asp:TextBox ID="pitcheroptionsTextBox" runat="server" style="text-align: left" class="form-control"></asp:TextBox>
                                                    </div> 
                                                    <div class="col-lg-5">
                                                        <div class='radio radio-primary'><asp:RadioButton ID="pitcheranyRadioButton" runat="server" GroupName="pitchertype" text="Any Type"  /></div>
                                                    </div> 
                                                    <div class="col-lg-5">
                                                        <div class='radio radio-primary'><asp:RadioButton ID="pitcherbreakingRadioButton" runat="server" GroupName="pitchertype" text="Breaking Ball"  /></div>
                                                    </div> 
                                                </div> 
                                                <div class="row">
                                                    <div class="col-lg-2">
                                                    </div> 
                                                    <div class="col-lg-5">
                                                        <div class='radio radio-primary'><asp:RadioButton ID="pitcherpowerRadioButton" runat="server" GroupName="pitchertype" text="Power"  /></div>
                                                    </div> 
                                                    <div class="col-lg-5">
                                                        <div class='radio radio-primary'><asp:RadioButton ID="pitchercustomRadioButton" runat="server" GroupName="pitchertype" text="Custom"  /></div>
                                                    </div> 
                                                </div> 
                                                <div class="row">
                                                    <div class="col-lg-2">
                                                    </div> 
                                                    <div class="col-lg-5">
                                                        <div class='radio radio-primary'><asp:RadioButton ID="pitchercontrolRadioButton" runat="server" GroupName="pitchertype" text="Control"  /></div>
                                                    </div> 
                                                    <div class="col-lg-5">
                                                    </div> 
                                                </div> 
                                            </div>

                                        </div>
                                    </div>
                                    
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="indivPitchers">
                                            <h4 class="panel-title">
                                                <a class="collapsed" role="button" data-toggle="collapse" href="#indivPitcherOptions" aria-expanded="false" aria-controls="indivPitcherOptions">
                                                    <i class="fa fa-caret-right pull-left"></i>
                                                    For Individual Pitchers Only                                             
                                                </a>
                                            </h4>                                        
                                        </div>
                                        <div class="panel-collapse collapse" id="indivPitcherOptions">
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-lg-2">
                                                    </div> 
                                                    <div class="col-lg-5">
                                                        <div class='radio radio-primary'><asp:RadioButton ID="allinningsRadioButton" runat="server" GroupName="innings" text="All Innings"  /></div>
                                                    </div> 
                                                    <div class="col-lg-5">
                                                        <div class='radio radio-primary'><asp:RadioButton ID="reliefRadioButton" runat="server" GroupName="innings" text="Relief Only"  /></div>
                                                    </div> 
                                                </div> 
                                                <div class="row">
                                                    <div class="col-lg-2">
                                                    </div> 
                                                    <div class="col-lg-5">
                                                        <div class='radio radio-primary'><asp:RadioButton ID="startinningsRadioButton" runat="server" GroupName="innings" text="Start Only"  /></div>
                                                    </div> 
                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                        
                                                  
                                </div>
                                <div class="col-lg-4">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    Batter Choices
                                                </div> 
                                                <div class="panel-body">
                                                    <h5>Current Batter Selection</h5>
                                                    <asp:TextBox ID="batterSelectionTextBox" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                                    <br />

                                                    <div class="btn-toolbar">
                                                        <asp:Button ID="batterallButton" runat="server" Text="All" OnClick="batterallButton_Click" CssClass="btn btn-default" />
                                                        <asp:Button ID="batterteamButton" runat="server" Text="Team" OnClick="batterteamButton_Click" CssClass="btn btn-default" />
                                                        <asp:HiddenField ID="bHiddenField" runat="server" />
                                                        <cc1:ModalPopupExtender ID="bHiddenFieldTeam_ModalPopupExtender" runat="server" BehaviorID="bHiddenFieldTeam_ModalPopupExtender" DynamicServicePath="" PopupControlID="bTeamPanel" TargetControlID="bHiddenField" >
                                                        </cc1:ModalPopupExtender>
                                                        <asp:Button ID="selectbatterButton" runat="server" Text="Select Player" OnClick="selectbatterButton_Click" CssClass="btn btn-default" />

                                                    </div> 
                                                        
                                                </div> 



                                                <div class="list-group">

                                                    <div class="list-group-item">                                                        
                                                        <h5>Bats</h5>                                                        
                                                        <div class='radio radio-primary radio-inline'><asp:RadioButton ID="batsleftRadioButton" runat="server" GroupName="bats" text="Left"  /></div>
                                                        <div class='radio radio-primary radio-inline'><asp:RadioButton ID="batseitherRadioButton" runat="server" GroupName="bats" text="Either"  /></div>
                                                        <div class='radio radio-primary radio-inline'><asp:RadioButton ID="batsrightRadioButton" runat="server" GroupName="bats" text="Right"  /></div>
                                                    </div> 
                                                </div> 
                                            </div>
                                            <div class="panel panel-default">
                                                <div class="panel-heading" role="tab" id="batterOptionsPanel">
                                                    <h4 class="panel-title">
                                                        <a class="collapsed" role="button" data-toggle="collapse" href="#additionalBatterOptions" aria-expanded="false" aria-controls="additionalBatterOptions">
                                                            <i class="fa fa-caret-right pull-left"></i>
                                                            Additional Batter Options                                                
                                                        </a>
                                                    </h4>
                                                </div>
                                                <div class="panel-collapse collapse" id="additionalBatterOptions">
                                                    <div class="panel-body">
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <asp:TextBox ID="batteroptionsTextBox" runat="server" style="text-align: left" class="form-control"></asp:TextBox>
                                                            </div> 
                                                            <div class="col-lg-5">
                                                                <div class='radio radio-primary'><asp:RadioButton ID="batteranyRadioButton" runat="server" GroupName="battertype" text="Any Type"  /></div>
                                                            </div> 
                                                            <div class="col-lg-5">
                                                                <div class='radio radio-primary'><asp:RadioButton ID="battercustomRadioButton" runat="server" GroupName="battertype" text="Custom"  /></div>
                                                            </div> 
                                                        </div> 
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                            </div> 
                                                            <div class="col-lg-5">
                                                                <div class='radio radio-primary'><asp:RadioButton ID="batterpowerRadioButton" runat="server" GroupName="battertype" text="Power"  /></div>
                                                            </div> 
                                                            <div class="col-lg-5">
                                                            </div> 
                                                        </div> 
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                            </div> 
                                                            <div class="col-lg-5">
                                                                <div class='radio radio-primary'><asp:RadioButton ID="battersingleRadioButton" runat="server" GroupName="battertype" text="Single"  /></div>
                                                            </div> 
                                                            <div class="col-lg-5">
                                                            </div> 
                                                        </div> 
                                                    </div> 
                                                </div> 
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            Location
                                        </div>
                                        <div class="panel-body">
                                            <div class='radio radio-primary'><asp:RadioButton ID="allLocRadioButton" runat="server" GroupName="location" text="All Locations" OnCheckedChanged="allLocRadioButton_CheckedChanged" /></div>
                                            <div class='radio radio-primary'><asp:RadioButton ID="pitchHomeRadioButton" runat="server" GroupName="location" text="Pitcher Home/Batter Away" OnCheckedChanged="pitchHomeRadioButton_CheckedChanged" /></div>
                                            <div class='radio radio-primary'><asp:RadioButton ID="pitchAwayRadioButton" runat="server" GroupName="location" text="Pitcher Away/Batter Home" OnCheckedChanged="pitchAwayRadioButton_CheckedChanged" /></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            Game Time
                                        </div>
                                        <div class="panel-body">
                                            <div class='radio radio-primary radio-inline'><asp:RadioButton ID="allTimeRadioButton" runat="server" GroupName="time" text="All" OnCheckedChanged="allTimeRadioButton_CheckedChanged"/></div>
                                            <div class='radio radio-primary radio-inline'><asp:RadioButton ID="dayRadioButton" runat="server" GroupName="time" text="Day" OnCheckedChanged="dayRadioButton_CheckedChanged"/></div>
                                            <div class='radio radio-primary radio-inline'><asp:RadioButton ID="nightRadioButton" runat="server" GroupName="time" text="Night" OnCheckedChanged="nightRadioButton_CheckedChanged"/></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-4">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            Other Options
                                        </div>
                                        <div class="panel-body">

                                            <div class='form-group'>
                                                <div class='checkbox checkbox-primary'><asp:CheckBox ID="maxAtBatsCheckBox" runat="server" AutoPostBack="True" Text="Maximum At Bats:" OnCheckedChanged="maxAtBatsCheckBox_CheckedChanged"/></div>
                                                <asp:TextBox ID="maxABTextBox" runat="server" class="form-control" MaxLength="3"></asp:TextBox>
                                                <cc1:MaskedEditExtender ID="maxABTextBox_MaskedEditExtender" runat="server" AutoComplete="False" BehaviorID="maxABTextBox_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="999" MaskType="Number" PromptCharacter=" " TargetControlID="maxABTextBox" />
                                            </div>
                                            <div class='checkbox checkbox-primary'><asp:CheckBox ID="myCheckBox" runat="server" AutoPostBack="True" Text="My Team's Games Only" OnCheckedChanged="myCheckBox_CheckedChanged"/></div>
                                
                                        </div>
                                    </div>
                                </div>
                                                
                                                
                                                
                                                
                            </div>

                            <div class="row">
                                <div class="col-md-3 col-md-offset-1">
                                    <asp:Button ID="resetselectionButton" runat="server" OnClick="resetselectionButton_Click" Text="Reset All Selections" CssClass="btn btn-danger btn-lg btn-block" />
                                </div>
                                <div class="col-md-5 col-md-offset-1">
                                    <asp:Button ID="goButton" runat="server" OnClick="goButton_Click" Text="Go-Read These Games!" class="btn btn-lg btn-block btn-primary"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!----------------------->

            <!-- Date One Click Modal -->
            <div class="modal fade" id="oneClickDateModal" tabindex="-1" role="dialog" aria-labelledby="oneClickDateModal">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Dates</h4>
                  </div>
                  <div class="modal-body">
                    <div class="list-group" id="oneClickDate">
                      <button type="button" class="list-group-item" data-date-flag="A">All Games</button>
                      <button type="button" class="list-group-item" data-date-flag="C">Current Year</button>
                      <button type="button" class="list-group-item" data-date-flag="P">Past Year</button>
                      <button type="button" class="list-group-item" data-date-flag="W">Last 2 Weeks</button>
                      <button type="button" class="list-group-item" data-date-flag="M">Current Month</button>
                      <button type="button" class="list-group-item" data-date-flag="2">Last 2 Months</button>
                      <button type="button" class="list-group-item" data-date-flag="3">Last 3 Months</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!----------------------->

        <!-- More Click Modal -->
            <div class="modal fade" id="moreModal" tabindex="-1" role="dialog" aria-labelledby="moreModal">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Additional Options</h4>
                        </div>
                        <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">    
                                        Velocity          
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class='checkbox checkbox-primary'><asp:CheckBox ID="rangeCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="rangeCheckBox_CheckedChanged" Text="Check this range only" /></div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-2">
                                                <label>From(Low):</label>
                                            </div>
                                            <div class="col-lg-4">
                                                <asp:TextBox ID="lowTextBox" runat="server" class="form-control" MaxLength="3"></asp:TextBox>
                                                <cc1:MaskedEditExtender ID="lowTextBox_MaskedEditExtender" runat="server" AutoComplete="False" BehaviorID="lowTextBox_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="999" MaskType="Number" PromptCharacter=" " TargetControlID="maxABTextBox" />
                                            </div>
                                            <div class="col-lg-2">
                                                <label>To(Low):</label>
                                            </div>
                                            <div class="col-lg-4">
                                                <asp:TextBox ID="highTextBox" runat="server" class="form-control" MaxLength="3"></asp:TextBox>
                                                <cc1:MaskedEditExtender ID="highTextBox_MaskedEditExtender" runat="server" AutoComplete="False" BehaviorID="highTextBox_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="999" MaskType="Number" PromptCharacter=" " TargetControlID="maxABTextBox" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <asp:Button ID="rangeGoButton" runat="server" OnClick="rangeGoButton_Click" Text="Go" class="btn btn-lg btn-block btn-primary"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4">
                                <label>Score:</label>
                            </div>
                            <div class="col-lg-8">
                                <asp:DropDownList ID="scoredd" runat="server" OnSelectedIndexChanged="scoredd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                    <asp:ListItem>All</asp:ListItem>
                                    <asp:ListItem>Even</asp:ListItem>
                                    <asp:ListItem>+/- 1</asp:ListItem>
                                    <asp:ListItem>+/- 2</asp:ListItem>
                                    <asp:ListItem>+/- 3</asp:ListItem>
                                    <asp:ListItem>Over 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4">
                                <label>Fielding:</label>
                            </div>
                            <div class="col-lg-8">
                                <asp:DropDownList ID="fieldingdd" runat="server" OnSelectedIndexChanged="fieldingdd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                    <asp:ListItem>All</asp:ListItem>
                                    <asp:ListItem>Highlight</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">    
                                        Team Selection          
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class='checkbox checkbox-primary'><asp:CheckBox ID="thisTeamCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="thisTeamCheckBox_CheckedChanged" Text="Check this range only" /></div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-12">
                                            <div class='radio radio-primary radio-inline'><asp:RadioButton ID="pitcherRadioButton" runat="server" GroupName="this" text="Pitcher" OnCheckedChanged="pitcherRadioButton_CheckedChanged"/></div>
                                            <div class='radio radio-primary radio-inline'><asp:RadioButton ID="batterRadioButton" runat="server" GroupName="this" text="Batter" OnCheckedChanged="batterRadioButton_CheckedChanged"/></div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <label>Team:</label>
                                            </div>
                                            <div class="col-lg-8">
                                                <asp:DropDownList ID="thisTeamdd" runat="server" OnSelectedIndexChanged="thisTeamdd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <asp:Button ID="teamGoButton" runat="server" OnClick="teamGoButton_Click" Text="Go" class="btn btn-lg btn-block btn-primary"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>
                </div>
            </div>

            <!----------------------->

            <asp:Panel ID="playerPanel" runat="server">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Select Player 
                    </div>
                    <div class="panel-body"> 
                        <div class="row">
                            <div class='col-md-12'>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="teamDropDownList" runat="server" OnSelectedIndexChanged="teamDropDownList_SelectedIndexChanged" AutoPostBack="True" class="form-control" >
                                </asp:DropDownList> 
                                <asp:ListBox ID="playerListBox" runat="server" Height="114px" OnSelectedIndexChanged="playerListBox_SelectedIndexChanged" class="form-control" ></asp:ListBox>
                            </ContentTemplate>
                            </asp:UpdatePanel>
                            </div>
                        </div>
                        <div class="row">
                            <div class='col-md-12'>
                                <asp:Button ID="playerOKButton" runat="server" OnClick="playerOKButton_Click" Text="OK"  class="btn btn-primary btn-block" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>










            <asp:Panel ID="selectionPanel" runat="server" GroupingText="Report Settings">
                <div class="row">
                    <div class="col-lg-9">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <label>Pitcher:</label>
                                        <asp:TextBox ID="pitcherTextBox" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-6">
                                        <label>Batter:</label>
                                        <asp:TextBox ID="batterTextBox" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <label>Games:</label>
                                        <asp:TextBox ID="gamesTextBox" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-6">
                                        <label>Location:</label>
                                        <asp:TextBox ID="locationTextBox" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <a class="btn btn-lg btn-block btn-primary" data-toggle="modal" data-target="#changeSelectionModal">Change Selection</a>
                    </div>
                    
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-4">
                                        <label>Count:</label>
                                        <asp:DropDownList ID="countdd" runat="server" OnSelectedIndexChanged="countdd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Catcher:</label>
                                        <asp:DropDownList ID="catcherdd" runat="server" OnSelectedIndexChanged="catcherdd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Outs:</label>
                                        <asp:DropDownList ID="outsdd" runat="server" OnSelectedIndexChanged="outsdd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <label>Pitch Loc:</label>
                                        <asp:DropDownList ID="pitchlocdd" runat="server" OnSelectedIndexChanged="pitchlocdd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Runners:</label>
                                        <asp:DropDownList ID="runnersdd" runat="server" OnSelectedIndexChanged="runnersdd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Inn:</label>
                                        <asp:DropDownList ID="inndd" runat="server" OnSelectedIndexChanged="inndd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <label>Pitch Type:</label>
                                        <asp:DropDownList ID="pitchtypedd" runat="server" OnSelectedIndexChanged="pitchtypedd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Result1:</label>
                                        <asp:DropDownList ID="result1dd" runat="server" OnSelectedIndexChanged="result1dd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <asp:Button ID="resetButton" runat="server" Text="Reset" class="btn btn-danger"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <a class="btn btn-md btn-info btn-block" data-toggle="modal" data-target="#moreModal">More</a>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Result2:</label>
                                        <asp:DropDownList ID="result2dd" runat="server" OnSelectedIndexChanged="result2dd_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <asp:ListBox ID="plListBox" runat="server" Height="320px" Font-Names="consolas" class="form-control" ></asp:ListBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <asp:ImageButton ID="szoneImageButton" runat="server" src="breakdownszone.aspx" alt="image could not be displayed refresh"/>
                    </div>
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Statistics
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-2 text-right">
                                        <label>G:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="gLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>SAC:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="sacLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>FB:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="fbLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2 text-right">
                                        <label>AB:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="abLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>DP:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="dpLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>GB:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="gbLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2 text-right">
                                        <label>H:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="hLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>HBP:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="hbpLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>LD:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="ldLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2 text-right">
                                        <label>2B:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="doubleLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>TPA:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="tpaLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>PU:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="puLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2 text-right">
                                        <label>3B:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="tripleLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                    </div>
                                    <div class="col-lg-2">
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>BU:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="buLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2 text-right">
                                        <label>HR:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="hrLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>AVG:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="avgLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-4">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2 text-right">
                                        <label>RBI:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="rbiLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>OBP:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="obpLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>Hard:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="hardLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2 text-right">
                                        <label>BB:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="bbLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>SLG:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="slgLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>Med:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="medLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2 text-right">
                                        <label>K:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="kLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>OPS:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="opsLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2 text-right">
                                        <label>Soft:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="softLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="col-lg-4">
                            <asp:Button ID="clearButton" runat="server" Text="Clear Selected" class="btn btn-primary"/>
                        </div>
                        <div class="col-lg-4">
                            <asp:Button ID="selectedButton" runat="server" Text="Selected" class="btn btn-primary"/>
                        </div>
                        <div class="col-lg-4">
                            <asp:Button ID="allButton" runat="server" Text="All" OnClick="allButton_Click" class="btn btn-primary"/>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <asp:Image ID="parkImage" runat="server" src="breakdownpark.aspx" alt="image could not be displayed refresh"/>
                    </div>
                    <div class="col-lg-2">
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button ID="ifButton" runat="server" Text="Infield" OnClick="ifButton_Click" class="btn btn-primary"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button ID="hlButton" runat="server" Text="Expand Ballpark View" OnClick="hlButton_Click" class="btn btn-primary"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-2">
                        <asp:Button ID="resultsButton" runat="server" Text="Pitch Results" class="btn btn-primary"/>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="typesButton" runat="server" Text="Pitch Types" OnClick="typesButton_Click" class="btn btn-primary"/>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="videosButton" runat="server" Text="Compare Videos" OnClick="videosButton_Click" class="btn btn-primary"/>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="prevButton" runat="server" Text="Prev. Pitch" OnClick="prevButton_Click" class="btn btn-primary"/>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="nextButton" runat="server" Text="Next Pitch" OnClick="nextButton_Click" class="btn btn-primary"/>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="printButton" runat="server" Text="Print..." class="btn btn-primary"/>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pTeamPanel" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Which pitcher team?
                </div>
                <div class="panel-body">     
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:DropDownList ID="pTeamDropDownList" runat="server" OnSelectedIndexChanged="pTeamDropDownList_SelectedIndexChanged" class="form-control">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="pTeamOKButton" runat="server" OnClick="pTeamOKButton_Click" Text="OK" style="margin-left: 60px" class="btn btn-default" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="bTeamPanel" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Which batter team?
                </div>
                <div class="panel-body">     
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:DropDownList ID="bTeamDropDownList" runat="server" OnSelectedIndexChanged="bTeamDropDownList_SelectedIndexChanged" class="form-control">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Button ID="bTeamOKButton" runat="server" OnClick="bTeamOKButton_Click" Text="OK" style="margin-left: 60px" class="btn btn-default" />
                            <asp:HiddenField ID="bTeamHiddenField" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        </form>
    </div>
</asp:Content>