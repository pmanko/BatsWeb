<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="lineBreakdown.aspx.cbl" Inherits="pucksweb.lineBreakdown" EnableEventValidation="false" Language="C#" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link type="text/css" href="/Styles/lineBreakdown.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/lineBreakdown.js"></script> 
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
    <meta name="format-detection" content="telephone=no" />
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
        <div class="panel panel-primary" id="selectionPanel">
            <div class="panel-heading">
                Current Selection
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-8">
                        <div class="input-group">
                            <span class="input-group-addon">Line:</span>
                            <asp:TextBox ID="lblPlayer" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <button type="button" class="btn btn-lg btn-block btn-primary" id="changeSelectionButton" data-toggle="collapse" data-target="#changeSelectionCollapse">Change Selection</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-8">
                        <div class="input-group">
                            <span class="input-group-addon">Opponent:</span>
                            <asp:TextBox ID="lblOpponent" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="input-group">
                            <span class="input-group-addon">Games:</span>
                            <asp:TextBox ID="lblGames" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="input-group">
                            <span class="input-group-addon">Location:</span>
                            <asp:TextBox ID="lblLocation" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="collapse" id="changeSelectionCollapse">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <button type="button" class="close" id="changeClose" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Report Data Selection</h4>
                </div>
                <div class="panel panel-default">
                    <div class='panel-body'>
                        <div class="row">
                           <div class="col-md-4">
                                <div class="panel panel-default">
                                    <ul class="nav nav-tabs">
                                      <li class="active"><a data-toggle="tab" href="#dates">Select Dates</a></li>
                                      <li><a data-toggle="tab" href="#ones">Date One-Clicks</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="dates" class="tab-pane fade in active">
                                            <div class="list-group">
                                                <div class="list-group-item">
                                                    <h5>Start Date</h5>
                                                    <div class='radio radio-primary'><asp:RadioButton ID="rbStartAll" runat="server" GroupName="startDate" text="All Games"  OnCheckedChanged="rbStartAll_CheckedChanged"/></div>
                                                    <div class='radio radio-primary'><asp:RadioButton ID="rbStartDate" runat="server" GroupName="startDate" Text="Start Date:"  OnCheckedChanged="rbStartDate_CheckedChanged"/></div>
                                                    <asp:TextBox ID="startDateTextBox" runat="server" TextMode="DateTime" onfocus="selectDate('S')" class="form-control"></asp:TextBox>
                                                    <cc1:MaskedEditExtender ID="startDateTextBox_MaskedEditExtender" runat="server" BehaviorID="startDateTextBox_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" TargetControlID="startDateTextBox" />
                                                    <cc1:CalendarExtender ID="startDateTextBox_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="startDateTextBox_CalendarExtender" TargetControlID="startDateTextBox" />
                                                </div>
                                                <div class="list-group-item">
                                                    <h5>End Date</h5>
                                                    <div class='radio radio-primary'><asp:RadioButton ID="rbEndAll" runat="server" GroupName="endDate" Text="All Games" OnCheckedChanged="rbEndAll_CheckedChanged"/></div>
                                                    <div class='radio radio-primary'><asp:RadioButton ID="rbEndDate" runat="server" GroupName="endDate" Text="End Date:" OnCheckedChanged="rbEndDate_CheckedChanged"/></div>
                                                    <asp:TextBox ID="endDateTextBox" runat="server" TextMode="DateTime" onfocus="selectDate('D')" class="form-control"></asp:TextBox>
                                                    <cc1:MaskedEditExtender ID="endDateTextBox_MaskedEditExtender" runat="server" BehaviorID="endDateTextBox_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" TargetControlID="endDateTextBox" />
                                                    <cc1:CalendarExtender ID="endDateTextBox_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="endDateTextBox_CalendarExtender" DefaultView="Days" PopupPosition="BottomLeft" TargetControlID="endDateTextBox" />
                                                </div>
                                                <%--<a class="list-group-item list-group-item-info" href="#" data-toggle="modal" data-target="#oneClickDateModal">Date One-Clicks</a>--%>
                                            </div>
                                        </div>
                                        <div id="ones" class="tab-pane fade">
                                            <div class="list-group" id="oneClickDate">
                                                <button type="button" class="list-group-item" data-date-flag="A">All Games</button>
                                                <button type="button" class="list-group-item" data-date-flag="L">Last Game</button>
                                                <button type="button" class="list-group-item" data-date-flag="F">Last 5 Games</button>
                                                <button type="button" class="list-group-item" data-date-flag="G">Last 10 Games</button>
                                                <button type="button" class="list-group-item" data-date-flag="D">Last 20 Games</button>
                                                <button type="button" class="list-group-item" data-date-flag="C">Current Season</button>
                                                <button type="button" class="list-group-item" data-date-flag="P">Last Season</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Games Location
                                    </div> 
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbAllLocations" runat="server" GroupName="location" text="All Locations" OnCheckedChanged="rbAllLocations_CheckedChanged" /></div>
                                            </div> 
                                            <div class="col-xs-4">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbPlayerHome" runat="server" GroupName="location" text="Player Home" OnCheckedChanged="rbHome_CheckedChanged" /></div>
                                            </div> 
                                            <div class="col-xs-4">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbPlayerAway" runat="server" GroupName="location" text="Player Away" OnCheckedChanged="rbAway_CheckedChanged" /></div>
                                            </div> 
                                        </div> 
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Games
                                    </div> 
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbAllSeasonGames" runat="server" GroupName="games" text="All" OnCheckedChanged="rbAllGames_CheckedChanged" /></div>
                                            </div> 
                                            <div class="col-xs-6">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbPreSeason" runat="server" GroupName="games" text="Pre-Season" OnCheckedChanged="rbPreSeason_CheckedChanged" /></div>
                                            </div> 
                                        </div> 
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbRegSeason" runat="server" GroupName="games" text="Regular Season" OnCheckedChanged="rbRegularSeason_CheckedChanged" /></div>
                                            </div> 
                                            <div class="col-xs-6">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbExcludePreSeason" runat="server" GroupName="games" text="Exclude Pre-Season" OnCheckedChanged="rbExcludePreSeason_CheckedChanged" /></div>
                                            </div> 
                                        </div> 
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbPlayoffs" runat="server" GroupName="games" text="Playoffs" OnCheckedChanged="rbPlayoffs_CheckedChanged" /></div>
                                            </div> 
                                            <div class="col-xs-6">
                                            </div> 
                                        </div> 
                                    </div>
                                </div>
                           </div>
                           <div class="col-md-4">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Line Selection
                                    </div> 
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbLineTeam" runat="server" Text="Team" GroupName="line" OnCheckedChanged="rbLineTeam_CheckedChanged" /></div>
                                            </div> 
                                            <div class="col-xs-8">
                                                    <%--<asp:label ID="lblLineTeam" runat="server" style="text-align: left" class="form-control"></asp:label>--%>
                                                    <asp:DropDownList ID="ddLineTeam" runat="server" class="form-control">
                                                    </asp:DropDownList>
<%--                                                    <span class="input-group-btn">
                                                        <button type="button" id="btnLineTeamSelect" class="btn btn-default" data-player-type="e">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                         <button type="button" id="btnLineTeamClear" class="btn btn-default" data-player-type="w">Clear</button>
                                                    </span>--%>
                                            </div> 
                                        </div> 
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbLineToInclude" runat="server" Text="Players to Include (With)" GroupName="line" OnCheckedChanged="rbLineToInclude_CheckedChanged" /></div>
                                            </div> 
                                        </div> 
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblLI1" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LI(1);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LIC(1);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblLI2" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LI(2);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LIC(2);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblLI3" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LI(3);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LIC(3);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblLI4" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LI(4);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LIC(4);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblLI5" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LI(5);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LIC(5);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                Players to Exclude (Without)
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblLE1" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LE(1);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LEC(1);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblLE2" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LE(2);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LEC(2);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblLE3" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LE(3);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LEC(3);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblLE4" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LE(4);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LEC(4);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblLE5" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LE(5);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="LEC(5);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Sort:
                                    </div> 
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbOldToNew" runat="server" GroupName="Show" text="Show Games Oldest to Newest" OnCheckedChanged="rbShowOld_CheckedChanged" /></div>
                                            </div> 
                                        </div> 
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbNewToOld" runat="server" GroupName="Show" text="Show Games Newest to Oldest" OnCheckedChanged="rbShowNew_CheckedChanged" /></div>
                                            </div> 
                                        </div> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Opponent Selection
                                    </div> 
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-2">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbOppAll" runat="server" Text="All" GroupName="opponent" OnCheckedChanged="rbOppAll_CheckedChanged" /></div>
                                            </div> 
                                            <div class="col-xs-4">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbOppConf" runat="server" Text="Conference" GroupName="opponent" OnCheckedChanged="rbOppConf_CheckedChanged" /></div>
<%--                                                    <span class="input-group-btn padding-0">
                                                   <button type="button" id="btnOppConf" class="btn btn-default" data-player-type="e">Select</button>
                                                    </span>--%>
                                            </div> 
                                            <div class="col-xs-6">
                                                   <%--<button type="button" id="btnOppConf" class="btn btn-default btn-block" data-player-type="e">Select</button>--%>
                                                    <asp:DropDownList ID="ddOppConf" runat="server" AutoPostBack="false" OnSelectedIndexChanged="ddOppConf_SelectedIndexChanged" class="form-control">
                                                        <asp:ListItem>Eastern Conf.</asp:ListItem>
                                                        <asp:ListItem>Eastern Atl.</asp:ListItem>
                                                        <asp:ListItem>Eastern Metro</asp:ListItem>
                                                        <asp:ListItem>Western Conf.</asp:ListItem>
                                                        <asp:ListItem>Western Cent.</asp:ListItem>
                                                        <asp:ListItem>Western Pac.</asp:ListItem>
                                                    </asp:DropDownList>
                                                <%--<asp:Button ID="btnOppConf" runat="server" Text="Go" OnClick="btnOppConf_Click" class="btn btn-md btn-block btn-default"/>--%>
                                                    <%--<asp:label ID="Label12" runat="server" style="text-align: left" class="form-control"></asp:label>--%>
                                            </div> 
                                        </div> 
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbOppTeam" runat="server" Text="Team" GroupName="opponent" OnCheckedChanged="rbOppTeam_CheckedChanged" /></div>
                                            </div> 
                                            <div class="col-xs-8">
                                                    <%--<asp:label ID="lblOppTeam" runat="server" style="text-align: left" class="form-control"></asp:label>--%>
                                                    <asp:DropDownList ID="ddOppTeam" runat="server" class="form-control">
                                                    </asp:DropDownList>
<%--                                                    <span class="input-group-btn">
                                                        <button type="button" id="Button1" class="btn btn-default" data-player-type="e">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                         <button type="button" id="Button2" class="btn btn-default" data-player-type="w">Clear</button>
                                                    </span>--%>
                                            </div> 
                                        </div> 
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbOppToInclude" runat="server" Text="Players to Include (With)" GroupName="opponent" OnCheckedChanged="rbOppToInclude_CheckedChanged" /></div>
                                            </div> 
                                        </div> 
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblOI1" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OI(1);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OIC(1);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblOI2" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OI(2);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OIC(2);"  type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblOI3" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OI(3);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OIC(3);"  type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblOI4" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OI(4);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OIC(4);"  type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblOI5" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OI(5);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OIC(5);"  type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                Players to Exclude (Without)
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblOE1" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OE(1);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OEC(1);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblOE2" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OE(2);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OEC(2);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblOE3" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OE(3);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OEC(3);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblOE4" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OE(4);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OEC(4);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <asp:Textbox ID="lblOE5" runat="server" style="text-align: left" class="form-control" ReadOnly="true"></asp:Textbox>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OE(5);" type="button">Select</button>
                                                    </span>
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" onclick="OEC(5);" type="button">Clear</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <asp:Button ID="btnGo" runat="server" Text="Go-Read These Games!" OnClick="btnGo_Click" class="btn btn-lg btn-block btn-primary"/>
                               NOTE: If you wish to include a GOALIE, he must be listed as the first player in the line
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
        <asp:HiddenField ID="hidTab" runat="server" Value="home" />
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-12">
                        <ul class="nav nav-tabs">
                          <li class="active"><a data-toggle="tab" href="#home">Sort Options</a></li>
                          <li><a data-toggle="tab" href="#menu1">More...</a></li>
                        </ul>
                        <div class="tab-content">
                            <div id="home" class="tab-pane fade in active">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">Period:</span>
                                            <asp:DropDownList ID="ddPeriod" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddPeriod_SelectedIndexChanged" class="form-control">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="input-group">
                                            <span class="input-group-addon">NHL Event:</span>
                                            <asp:DropDownList ID="ddNhlEvent" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddNhlEvent_SelectedIndexChanged" class="form-control">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="input-group">
                                            <span class="input-group-addon">Custom Event:</span>
                                            <asp:DropDownList ID="ddCustomEvent" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddCustomEvent_SelectedIndexChanged" class="form-control">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">Score:</span>
                                            <asp:DropDownList ID="ddScore" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddScore_SelectedIndexChanged" class="form-control">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="input-group">
                                            <span class="input-group-addon">Situation:</span>
                                            <asp:DropDownList ID="ddSituation" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddSituation_SelectedIndexChanged" class="form-control">
                                            </asp:DropDownList>
                                        </div>
                                        <a href="#" class="btn btn-info" data-toggle="modal" data-target="#advancedModal">
                                            <span class="glyphicon glyphicon-search" aria-hidden="true"></span> Advanced
                                        </a>
                                        <asp:Button ID="btnReset" runat="server" Text="Reset Selections" OnClick="btnReset_Click" class="btn btn-md btn-success"/>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                Shot
                                            </div> 
                                            <div class="panel-body">
                                                <div class="input-group">
                                                    <span class="input-group-addon">Result:</span>
                                                    <asp:DropDownList ID="ddShotResult" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddShotResult_SelectedIndexChanged" class="form-control">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">Type:</span>
                                                    <asp:DropDownList ID="ddShotType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddShotType_SelectedIndexChanged" class="form-control">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="input-group">
                                                    <span class="input-group-addon">% Chances:</span>
                                                    <asp:DropDownList ID="ddPctChances" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddPctChances_SelectedIndexChanged" class="form-control">
                                                        <asp:ListItem>ALL</asp:ListItem>
                                                        <asp:ListItem>5%</asp:ListItem>
                                                        <asp:ListItem>10%</asp:ListItem>
                                                        <asp:ListItem>15%</asp:ListItem>
                                                        <asp:ListItem>Custom</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="menu1" class="tab-pane fade">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                Rebounds
                                            </div> 
                                            <div class="panel-body">
                                                <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbFirstShotsOnly" runat="server" AutoPostBack="True" OnCheckedChanged="cbFirstShotsOnly_CheckedChanged" Text="First Shots Only" /></div>         
                                                <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbReboundShotsOnly" runat="server" AutoPostBack="True" OnCheckedChanged="cbReboundShotsOnly_CheckedChanged" Text="Rebound Shots Only" /></div>         
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-3">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                Event Duration
                                            </div> 
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-8">
                                                        <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbUseDuration" runat="server" AutoPostBack="True" OnCheckedChanged="cbUseDuration_CheckedChanged" Text="Use Duration" /></div>         
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <asp:TextBox ID="tbDuration" runat="server" maxlength="3" onkeypress="return isNumberKey(event)" class="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <asp:Button ID="btnGoDuration" runat="server" Text="Go" OnClick="btnGoDuration_Click" class="btn btn-md btn-block btn-default"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-3">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                Opp-Faceoff-Handedness
                                            </div> 
                                            <div class="panel-body">
                                                <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbLeft" runat="server" AutoPostBack="True" OnCheckedChanged="cbLeft_CheckedChanged" Text="Left" /></div>         
                                                <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbRight" runat="server" AutoPostBack="True" OnCheckedChanged="cbRight_CheckedChanged" Text="Right" /></div>         
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-3">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                Faceoff Won By Opponent
                                            </div> 
                                            <div class="list-group">
                                                <div class="list-group-item">                                                        
                                                    <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbFOOppWon" runat="server" AutoPostBack="True" OnCheckedChanged="cbFOOppWon_CheckedChanged" Text="Sort" /></div>         
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
        </div>
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-10">
                        <div class="listbox-replacement-wrapper" id="playTableWrapper">
                            <asp:Table id="playTable" runat="server" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                            data-value-field="#MainContent_playValueField" 
                            data-index-field="#MainContent_playIndexField" 
                            data-postback="false" 
                            data-multiple="false"
                            data-on-select="playUpdate"
                            data-on-dblclick-select="playUpdateDblclick"
                            data-on-dblclick="openBatsTube"
                            >
                            <asp:TableHeaderRow TableSection="TableHeader">
                                <asp:TableHeaderCell>  Date  Pd V H   Description</asp:TableHeaderCell>
                            </asp:TableHeaderRow>                                                                    
                            </asp:Table>
                        </div>
                        <asp:HiddenField ID="playValueField" runat="server" />
                        <asp:HiddenField ID="playIndexField" runat="server"  />
                    </div>
                    <div class="col-md-2">
                        <a href="#" class="btn btn-block btn-primary btn-async-request" data-action-flag="play-full">
                            <span class="glyphicon glyphicon-play" aria-hidden="true"></span> All
                        </a>
                        <button type="button" class="btn btn-block btn-primary" onclick="playUpdateDblclick();openBatsTube();">
                            <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Selected
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-12">
                        <ul class="nav nav-tabs">
                          <li class="active"><a data-toggle="tab" href="#data">All Data</a></li>
                          <li><a data-toggle="tab" href="#value">Shot Value</a></li>
                        </ul>
                        <div class="tab-content">
                            <div id="data" class="tab-pane fade in active">
                                <div class="row">
                                    <div class="col-md-4 padding-0">
                                        <div class="panel panel-info">
                                            <div class="panel-heading">
                                                Team Statistics
                                            </div> 
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Shots:</span>
                                                            <asp:Button ID="btnTeamShots" onclientclick="playField(1);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Giveaways:</span>
                                                            <asp:Button ID="btnTeamGives" onclientclick="playField(8);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Misses:</span>
                                                            <asp:Button ID="btnTeamMisses" onclientclick="playField(2);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Hits:</span>
                                                            <asp:Button ID="btnTeamHits" onclientclick="playField(9);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Blocked:</span>
                                                            <asp:Button ID="btnTeamBlocked" onclientclick="playField(3);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Penalty:</span>
                                                            <asp:Button ID="btnTeamPens" onclientclick="playField(10);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">On Goal:</span>
                                                            <asp:Button ID="btnTeamOnGoal" onclientclick="playField(4);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Pen Min:</span>
                                                            <asp:Button ID="btnTeamPenMin" onclientclick="playField(11);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Goals:</span>
                                                            <asp:Button ID="btnTeamGoals" onclientclick="playField(5);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rbd Goals:</span>
                                                            <asp:Button ID="btnTeamRbdGoals" onclientclick="playField(12);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rbd Shots:</span>
                                                            <asp:Button ID="btnTeamRbds" onclientclick="playField(6);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group"> 
                                                            <span class="input-group-addon">Takeaways:</span>
                                                            <asp:Button ID="btnTeamTakes" onclientclick="playField(7);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <img class="center-block" id="btnTeamSL" src="Images/NHLrink2small.png" alt="Images/NHLrink2small.png" style="cursor: pointer;"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 padding-0">
                                        <div class="panel panel-warning">
                                            <div class="panel-heading">
                                                Opponent Statistics
                                            </div> 
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Shots:</span>
                                                            <asp:Button ID="btnOppShots" onclientclick="playField(13);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Giveaways:</span>
                                                            <asp:Button ID="btnOppGives" onclientclick="playField(20);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Misses:</span>
                                                            <asp:Button ID="btnOppMisses" onclientclick="playField(14);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Hits:</span>
                                                            <asp:Button ID="btnOppHits" onclientclick="playField(21);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Blocked:</span>
                                                            <asp:Button ID="btnOppBlocked" onclientclick="playField(15);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Penalty:</span>
                                                            <asp:Button ID="btnOppPens" onclientclick="playField(22);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">On Goal:</span>
                                                            <asp:Button ID="btnOppOnGoal" onclientclick="playField(16);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Pen Min:</span>
                                                            <asp:Button ID="btnOppPenMin" onclientclick="playField(23);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Goals:</span>
                                                            <asp:Button ID="btnOppGoals" onclientclick="playField(17);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rbd Goals:</span>
                                                            <asp:Button ID="btnOppRbdGoals" onclientclick="playField(24);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rbd Shots:</span>
                                                            <asp:Button ID="btnOppRbds" onclientclick="playField(18);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Takeaways:</span>
                                                            <asp:Button ID="btnOppTakes" onclientclick="playField(19);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <img class="center-block" id="btnOppSL" src="Images/NHLrink2small.png" alt="Images/NHLrink2small.png" style="cursor: pointer;"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 padding-0">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                Total
                                            </div> 
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">
                                                                <div class="row">
                                                                    <div class="col-xs-6 padding-0">
                                                                        <div class="input-group">
                                                                            <span class="input-group-addon">GP:</span>
                                                                            <asp:label ID="lblTotalGms" runat="server" style="text-align: left" class="form-control"></asp:label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-6 padding-0">
                                                                        <div class="input-group">
                                                                            <span class="input-group-addon">Time on Ice:</span>
                                                                            <asp:label ID="lblTotalMin" runat="server" style="text-align: left" class="form-control"></asp:label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-xs-6 padding-0">
                                                                    </div>
                                                                    <div class="col-xs-6 padding-0">
                                                                        <div class="input-group">
                                                                            <span class="input-group-addon">Min/Game:</span>
                                                                            <asp:label ID="lblTotalMinPerGame" runat="server" style="text-align: left" class="form-control"></asp:label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="panel-body">
                                                            <strong><label>Faceoffs</label></strong>
                                                            <div class="row">
                                                                <div class="col-xs-2 padding-0">
                                                                </div>
                                                                <div class="col-xs-2 padding-0" style="text-align: center;">
                                                                    Tot.
                                                                </div>
                                                                <div class="col-xs-2 padding-0" style="text-align: center;">
                                                                    Def.
                                                                </div>
                                                                <div class="col-xs-2 padding-0" style="text-align: center;">
                                                                    Neu.
                                                                </div>
                                                                <div class="col-xs-2 padding-0" style="text-align: center;">
                                                                    Off.
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-xs-12 padding-0">
                                                                    <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                                        <span class="input-group-addon">W:</span>
                                                                        <div class="btn-group" role="group">
                                                                            <asp:Button ID="btnFOTotW" onclientclick="playField(28);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                        </div>
                                                                        <div class="btn-group" role="group">
                                                                            <asp:Button ID="btnFODefW" onclientclick="playField(29);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                        </div>
                                                                        <div class="btn-group" role="group">
                                                                            <asp:Button ID="btnFONeuW" onclientclick="playField(30);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                        </div>
                                                                        <div class="btn-group" role="group">
                                                                            <asp:Button ID="btnFOOffW" onclientclick="playField(31);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                        </div>
                                                                        <div class="btn-group" role="group">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-xs-12 padding-0">
                                                                    <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                                        <span class="input-group-addon">L:</span>
                                                                        <div class="btn-group" role="group">
                                                                            <asp:Button ID="btnFOTotL" onclientclick="playField(32);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                        </div>
                                                                        <div class="btn-group" role="group">
                                                                            <asp:Button ID="btnFODefL" onclientclick="playField(33);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                        </div>
                                                                        <div class="btn-group" role="group">
                                                                            <asp:Button ID="btnFONeuL" onclientclick="playField(34);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                        </div>
                                                                        <div class="btn-group" role="group">
                                                                            <asp:Button ID="btnFOOffL" onclientclick="playField(35);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                        </div>
                                                                        <div class="btn-group" role="group">
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
                                </div>
                            </div>
                            <div id="value" class="tab-pane fade">
                                <div class="row">
                                    <div class="col-md-6 padding-0">
                                        <div class="panel panel-info">
                                            <div class="panel-heading">
                                                Team Statistics
                                            </div> 
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-4 padding-0">
                                                    </div>
                                                    <div class="col-xs-3 padding-0" style="text-align: right;">
                                                        Shot Value
                                                    </div>
                                                    <div class="col-xs-3 padding-0" style="text-align: center;">
                                                        NHL Expected
                                                    </div>
                                                    <div class="col-xs-2 padding-0" style="text-align: center;">
                                                        Diff.
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                <span class="input-group-addon">Team Shots:</span>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblTeamSVShots" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblTeamSVValue" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblTeamSVExp" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblTeamSVDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                <span class="input-group-addon">Rebounds:</span>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblTeamSVRbds" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblTeamSVRbdValue" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblTeamSVRbdExp" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblTeamSVRbdDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-3 col-xs-offset-7 padding-0" style="text-align: center;">
                                                        Shot Value Expected
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                            <div class="btn-group" role="group">
                                                            </div>
                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                <span class="input-group-addon">Actual Goals:*</span>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblTeamSVGoals" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblTeamSVGoalsExp" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblTeamSVGoalsDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">
                                                                <strong><label>Shooting Analysis</label></strong>
                                                                <div class="row">
                                                                    <div class="col-xs-8 padding-0" style="text-align: right;">
                                                                        vs NHL Expected
                                                                    </div>
                                                                    <div class="col-xs-4 padding-0" style="text-align: center;">
                                                                        Goals +/-
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                                <span class="input-group-addon">On Goal Shot Results:</span>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblTeamSVOnGoal" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblTeamSVOnGoalDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                                <span class="input-group-addon">Value Blocked:</span>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblTeamSVBlocked" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblTeamSVBlockedDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                                <span class="input-group-addon">Value Missed</span>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblTeamSVMissed" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblTeamSVMissedDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rbd Goals:</span>
                                                            <asp:label ID="lblTeamSVRbdGoals" runat="server" Text="0" class="form-control"></asp:label>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Empty Net Goals:</span>
                                                            <asp:label ID="lblTeamSVEmpty" runat="server" Text="0" class="form-control"></asp:label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 padding-0">
                                        <div class="panel panel-warning">
                                            <div class="panel-heading">
                                                Opponent Statistics
                                            </div> 
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-4 padding-0">
                                                    </div>
                                                    <div class="col-xs-3 padding-0" style="text-align: right;">
                                                        Shot Value
                                                    </div>
                                                    <div class="col-xs-3 padding-0" style="text-align: center;">
                                                        NHL Expected
                                                    </div>
                                                    <div class="col-xs-2 padding-0" style="text-align: center;">
                                                        Diff.
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                <span class="input-group-addon">Team Shots:</span>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblOppSVShots" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblOppSVValue" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblOppSVExp" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblOppSVDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                <span class="input-group-addon">Rebounds:</span>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblOppSVRbds" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblOppSVRbdValue" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblOppSVRbdExp" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblOppSVRbdDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-3 col-xs-offset-7 padding-0" style="text-align: center;">
                                                        Team Expected
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                            <div class="btn-group" role="group">
                                                            </div>
                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                <span class="input-group-addon">Actual Goals:*</span>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblOppSVGoals" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblOppSVGoalExp" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblOppSVGoalDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">
                                                                <strong><label>Shooting Analysis</label></strong>
                                                                <div class="row">
                                                                    <div class="col-xs-8 padding-0" style="text-align: right;">
                                                                        vs NHL Expected
                                                                    </div>
                                                                    <div class="col-xs-4 padding-0" style="text-align: center;">
                                                                        Goals +/-
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                                <span class="input-group-addon">On Goal Shot Results:</span>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblOppSVOnGoal" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblOppSVOnGoalDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                                <span class="input-group-addon">Value Blocked:</span>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblOppSVBlocked" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblOppSVBlockedDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified tester" role="group" aria-label="...">
                                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                                <span class="input-group-addon">Value Missed</span>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblOppSVMissed" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblOppSVMissedDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rbd Goals:</span>
                                                            <asp:label ID="lblOppSVRbdGoals" runat="server" Text="0" class="form-control"></asp:label>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Empty Net Goals:</span>
                                                            <asp:label ID="lblOppSVEmpty" runat="server" Text="0" class="form-control"></asp:label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3 padding-0">
                                        <label>*Note: Empty net goals not included</label>
                                    </div>
                                    <div class="col-md-3 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">Total Shot Value vs Opponents:</span>
                                            <asp:label ID="lblSVvsOpp" runat="server" Text="0" class="form-control"></asp:label>
                                        </div>
                                    </div>
                                    <div class="col-md-3 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">Pct vs Opponents:</span>
                                            <asp:label ID="lblSVPct" runat="server" Text="0" class="form-control"></asp:label>
                                        </div>
                                    </div>
                                    <div class="col-md-3 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">NHL Expected:</span>
                                            <asp:label ID="lblSVNHL" runat="server" Text="0" class="form-control"></asp:label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
            </ContentTemplate>
            </asp:UpdatePanel>

        <!-- Team Selection Modal -->
        <div class="modal fade" id="teamSelectionModal" tabindex="-1" role="dialog" aria-labelledby="teamSelectionModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Which <span id="modalType"></span> team?</h4>
                    </div>
                    <div class="modal-body">
                        <asp:DropDownList ID="ddTeam" runat="server" class="form-control"></asp:DropDownList>
                    </div>
                    <div class="modal-footer">
                        <a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
                        <a href="#" class="btn btn-primary" id="btnTeamSelectionOK">OK</a>
                    </div>
                </div>
            </div>
        </div>
        <!----------------------->

        <!-- Player Selection Modal -->
        <div class="modal fade" id="playerSelectionModal" tabindex="-1" role="dialog" aria-labelledby="playerSelectionModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Select Player</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class='col-md-12'>
                                <label>Locate Player:</label>
                                <asp:TextBox ID="locatePlayerTextBox" runat="server" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class='col-md-12'>
                                <asp:DropDownList ID="ddPlayerTeam" runat="server" class="form-control" ></asp:DropDownList> 
                                <br />
                                <div class="listbox-replacement-wrapper" id="playerTableWrapper">
                                    <table id="playerTable" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                    data-index-field="#MainContent_playerIndexField" 
                                    data-value-field="#MainContent_playerValueField" >
                                    <tbody></tbody>
                                    </table>                                
                                    <asp:HiddenField ID="playerIndexField" runat="server" />
                                    <asp:HiddenField ID="playerValueField" runat="server"  />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
                        <a href="#" class="btn btn-primary" id="btnSelectPlayerOK">OK</a>
                    </div>
                </div>
            </div>
        </div>            
        <!----------------------->

        <!-- Advanced Modal -->
        <div class="modal fade" id="advancedModal" tabindex="-1" role="dialog" aria-labelledby="advancedModalLabel">
          <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="H1">Advanced Search</h4>
                <small><label>Search Custom Marks by One or Two Keywords or Phrases
                        (Any Word or Phrase Contained in the Note Text)</label></small>
              </div>
              <div class="modal-body">
                  <div class="row">
                      <div class="col-md-12">
                          <div class="input-group">
                              <span class="input-group-addon">Seach Criteria 1:</span>
                              <asp:TextBox ID="tbNote1" runat="server" class="form-control" ClientIDMode="Static"></asp:TextBox>
                          </div>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-md-12">
                          <div class="input-group">
                              <span class="input-group-addon">Seach Criteria 2:</span>
                              <asp:TextBox ID="tbNote2" runat="server" class="form-control" ClientIDMode="Static"></asp:TextBox>
                          </div>
                      </div>
                  </div>
                  <br />
                  <div class="row">
                      <div class="col-md-12">
                          <div class="list-group">
                              <div class="list-group-item">
                                  <h4>Event Type</h4>
                                  <div class='radio radio-primary'><asp:RadioButton ID="rbAllEvents" runat="server" GroupName="advanced" text="All" OnCheckedChanged="rbAllEvents_CheckedChanged" /></div>
                                  <div class='radio radio-primary'><asp:RadioButton ID="rbNhlOnly" runat="server" GroupName="advanced" text="NHL Only" OnCheckedChanged="rbNhlOnly_CheckedChanged" /></div>
                                  <div class='radio radio-primary'><asp:RadioButton ID="rbCustomOnly" runat="server" GroupName="advanced" text="Custom Only" OnCheckedChanged="rbCustomOnly_CheckedChanged" /></div>
                              </div>
                          </div>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-md-8">
                          <div class="input-group">
                              <span class="input-group-addon">Author:</span>
                              <asp:TextBox ID="tbAuthor" runat="server" maxlength="3" class="form-control" ClientIDMode="Static"></asp:TextBox>
                          </div>
                      </div>
                      <div class="col-md-4" style="text-align: right">
                          <button type="button" id="btnResetAll" class="btn btn-default"> Reset All</button>
                      </div>
                  </div>
              </div>
              <div class="modal-footer">
                <asp:Button ID="btnOK" runat="server" Text="OK" OnClick="btnOK_Click" class="btn btn-primary btn-block" />
                <%--<button type="button" class="btn btn-default btn-lg" data-dismiss="modal">OK</button>--%>
              </div>
            </div>
          </div>
        </div>

        <!-- Custom Chances Modal -->
        <div class="modal fade" id="chancesModal" tabindex="-1" role="dialog" aria-labelledby="chancesModalLabel">
          <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="H2"> % Chances </h4>
              </div>
              <div class="modal-body">
                  <div class="row">
                      <div class="col-xs-6">
                          <div class="list-group">
                              <div class="list-group-item">
                                  <div class='radio radio-primary'><asp:RadioButton ID="rbGreaterOrEq" runat="server" GroupName="advanced" text="> or =" OnCheckedChanged="rbGreaterOrEq_CheckedChanged" /></div>
                                  <div class='radio radio-primary'><asp:RadioButton ID="rbLess" runat="server" GroupName="advanced" text="<" OnCheckedChanged="rbLess_CheckedChanged" /></div>
                              </div>
                          </div>
                      </div>
                      <div class="col-xs-6">
                        <div class="input-group">
                            <asp:TextBox ID="tbChances" runat="server" maxlength="2" class="form-control" onkeypress="return isNumberKey(event)"></asp:TextBox>
                            <span class="input-group-addon" style="min-width:20px">%</span>
                        </div>
                      </div>
                  </div>
              </div>
              <div class="modal-footer">
                <asp:Button ID="btnChancesOK" runat="server" Text="OK" OnClick="btnChancesOK_Click" class="btn btn-primary btn-block" />
                <%--<button type="button" class="btn btn-default btn-lg" data-dismiss="modal">OK</button>--%>
              </div>
            </div>
          </div>
        </div>

        <!-- Shot Locations Modal -->
        <div class="modal fade" id="slModal" tabindex="-1" role="dialog" aria-labelledby="slModalLabel">
          <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="H3"> Shot Locations</h4>
              </div>
              <div class="modal-body">
                  <div class="row">
                      <div class="col-md-5">
                        <div class="outsideWrapper center-block">
                            <div class="insideWrapper">
                                <img id="rinkImagebtn" src="Images/NHLrink2.png" class="coveredImage" alt="Images/NHLrink2.png"/>
                                <canvas id="canvas" width="277" height="336" class="coveringCanvas" style="cursor:pointer;"/>
                            </div>
                        </div>
                        <button type="button" id="btnSelected" class="btn btn-primary center-block"> 
                            <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Selected
                        </button>
                      </div>
                      <div class="col-md-7">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Goal Locations (Facing Goalie)
                            </div> 
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <asp:label ID="lblTopLeft" runat="server" Text="0" class="form-control"></asp:label>
                                    </div>
                                    <div class="col-xs-4">
                                        <asp:label ID="lblTopCenter" runat="server" Text="0" class="form-control"></asp:label>
                                    </div>
                                    <div class="col-xs-4">
                                        <asp:label ID="lblTopRight" runat="server" Text="0" class="form-control"></asp:label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <button type="button" id="btnTopLeft" class="btn btn-primary btn-block"> 
                                            <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Top Left
                                        </button>
                                    </div>
                                    <div class="col-xs-4">
                                        <button type="button" id="btnTopCenter" class="btn btn-primary btn-block"> 
                                            <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Top Center
                                        </button>
                                    </div>
                                    <div class="col-xs-4">
                                        <button type="button" id="btnTopRight" class="btn btn-primary btn-block"> 
                                            <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Top Right
                                        </button>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <asp:label ID="lblBotLeft" runat="server" Text="0" class="form-control"></asp:label>
                                    </div>
                                    <div class="col-xs-4">
                                        <asp:label ID="lblBotCenter" runat="server" Text="0" class="form-control"></asp:label>
                                    </div>
                                    <div class="col-xs-4">
                                        <asp:label ID="lblBotRight" runat="server" Text="0" class="form-control"></asp:label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <button type="button" id="btnBotLeft" class="btn btn-primary btn-block"> 
                                            <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Bottom Left
                                        </button>
                                    </div>
                                    <div class="col-xs-4">
                                        <button type="button" id="btnBotCenter" class="btn btn-primary btn-block"> 
                                            <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Bottom Center
                                        </button>
                                    </div>
                                    <div class="col-xs-4">
                                        <button type="button" id="btnBotRight" class="btn btn-primary btn-block"> 
                                            <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Bottom Right
                                        </button>
                                    </div>
                                </div>
                            </div>
                      </div>
                  </div>
              </div>
            </div>
            <div class="modal-footer">
                Key:
                <label style="color:yellowgreen">Green: Goals </label>
                <label style="color:royalblue">Blue: Saved </label>
                <label style="color:black">Black: Missed/Blocked</label>
            </div>
          </div>
        </div>
        </div>

    </div>
</asp:Content>
            