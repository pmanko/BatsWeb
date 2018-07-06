<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="playerBreakdown.aspx.cbl" Inherits="pucksweb.playerBreakdown" EnableEventValidation="false" Language="C#" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link type="text/css" href="/Styles/playerBreakdown.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/playerBreakdown.js"></script> 
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
                    <div class="col-xs-4">
                        <div class="input-group">
                            <span class="input-group-addon">Player:</span>
                            <asp:TextBox ID="lblPlayer" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="input-group">
                            <span class="input-group-addon">Opponent:</span>
                            <asp:TextBox ID="lblOpponent" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <button type="button" class="btn btn-lg btn-block btn-primary" id="changeSelectionButton" data-toggle="collapse" data-target="#changeSelectionCollapse">Change Selection</button>
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
                           <div class="col-xs-2">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Date Range
                                    </div>
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
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Date One-Clicks
                                    </div>
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
                           <div class="col-xs-5">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Player
                                    </div> 
                                    <div class="panel-body">
                                        <h5>Current Player Selection</h5>
                                        <asp:TextBox ID="lblCurrentPlayer" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                        <br />
                                        <div class="btn-toolbar" role="toolbar">
                                            <a href="#" class="btn btn-default" data-toggle="modal" data-target="#playerSelectionModal">Select Player</a>                                                                                                
                                            <a href="#" class="btn btn-default" data-toggle="modal" data-target="#teamSelectionModal" data-modal-type="player">Team</a>
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
                                <asp:Button ID="btnGo" runat="server" Text="Go-Read These Games!" OnClick="btnGo_Click" class="btn btn-lg btn-block btn-primary"/>

                            </div>
                            <div class="col-xs-5">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Opponent
                                    </div> 
                                    <div class="panel-body">
                                        <h5>Current Opponent Selection</h5>
                                        <asp:TextBox ID="lblCurrentOpponent" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                        <br />
                                        <div class="btn-toolbar" role="toolbar">
                                            <a href="#" class="btn btn-default" id="btnOppAll" data-player-type="o">All</a>
                                            <a href="#" class="btn btn-default" data-toggle="modal" data-target="#teamSelectionModal" data-modal-type="opponent">Team</a>
                                        </div>
                                        <br />
                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                            <div class="btn-group" role="group">
                                            <button type="button" id="btnEastConf" class="btn btn-default" data-player-type="e">Eastern Conf.</button>
                                            </div>
                                            <div class="btn-group" role="group">
                                            <button type="button" id="btnWestConf" class="btn btn-default" data-player-type="w">Western Conf.</button>
                                            </div>
                                        </div>
                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                            <div class="btn-group" role="group">
                                            <button type="button" id="btnEastAtl" class="btn btn-default" data-player-type="a">Eastern Atl.</button>
                                            </div>
                                            <div class="btn-group" role="group">
                                            <button type="button" id="btnWestCent" class="btn btn-default" data-player-type="c">Western Cent.</button>
                                            </div>
                                        </div>
                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                            <div class="btn-group" role="group">
                                            <button type="button" id="btnEastMetro" class="btn btn-default" data-player-type="m">Eastern Metro</button>
                                            </div>
                                            <div class="btn-group" role="group">
                                            <button type="button" id="btnWestPac" class="btn btn-default" data-player-type="p">Western Pac.</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Other Sort Options:
                                    </div> 
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbChkToi" runat="server" GroupName="Check" text="Check Games Based on Time On Ice" OnCheckedChanged="rbCheckToi_CheckedChanged" /></div>
                                            </div> 
                                        </div> 
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class='radio radio-primary'><asp:RadioButton ID="rbChkPlayerName" runat="server" GroupName="Check" text="Check Games Based on Player Name" OnCheckedChanged="rbCheckName_CheckedChanged" /></div>
                                            </div> 
                                        </div> 
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
                                                Faceoff Won By
                                            </div> 
                                            <div class="list-group">
                                                <div class="list-group-item">                                                        
                                                    <div class='radio radio-primary'><asp:RadioButton ID="rbFOAll" runat="server" GroupName="faceoff" AutoPostBack="True" text="All" OnCheckedChanged="rbFOAll_CheckedChanged" /></div>
                                                    <div class='radio radio-primary'><asp:RadioButton ID="rbFOTeam" runat="server" GroupName="faceoff" AutoPostBack="True" text="Team" OnCheckedChanged="rbFOTeam_CheckedChanged" /></div>
                                                    <div class='radio radio-primary'><asp:RadioButton ID="rbFOOpp" runat="server" GroupName="faceoff" AutoPostBack="True" text="Opp" OnCheckedChanged="rbFOOpp_CheckedChanged" /></div>
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
                                                            <span class="input-group-addon">Takeaways:</span>
                                                            <asp:Button ID="btnTeamTakes" onclientclick="playField(7);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
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
                                                            <span class="input-group-addon">Giveaways:</span>
                                                            <asp:Button ID="btnTeamGives" onclientclick="playField(8);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
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
                                                            <span class="input-group-addon">Hits:</span>
                                                            <asp:Button ID="btnTeamHits" onclientclick="playField(9);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
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
                                                            <span class="input-group-addon">Penalty:</span>
                                                            <asp:Button ID="btnTeamPens" onclientclick="playField(10);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
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
                                                            <span class="input-group-addon">Pen Min:</span>
                                                            <asp:Button ID="btnTeamPenMin" onclientclick="playField(11);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
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
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rbd Goals:</span>
                                                            <asp:Button ID="btnTeamRbdGoals" onclientclick="playField(12);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-10 padding-0">
                                                        <div class="panel panel-default">
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
                                                                    <div class="col-xs-2 padding-0" style="text-align: center;">
                                                                        Off%
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                                            <span class="input-group-addon">W:</span>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnTeamFOTotW" onclientclick="playField(13);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnTeamFODefW" onclientclick="playField(14);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnTeamFONeuW" onclientclick="playField(15);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnTeamFOOffW" onclientclick="playField(16);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblTeamFOPct" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                                            <span class="input-group-addon">L:</span>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnTeamFOTotL" onclientclick="playField(18);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnTeamFODefL" onclientclick="playField(19);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnTeamFONeuL" onclientclick="playField(20);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnTeamFOOffL" onclientclick="playField(21);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-2 padding-0">
                                                        <br />
                                                        <br />
                                                        <br />
                                                        <img class="center-block" id="btnTeamSL" src="Images/NHLrink2small.png" alt="Images/NHLrink2small.png" style="cursor: pointer;"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 padding-0">
                                        <div class="panel panel-default">
                                            <div class="panel-heading panel-heading-custom">
                                                Player Statistics
                                            </div> 
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Shots:</span>
                                                            <asp:Button ID="btnPlShots" onclientclick="playField(22);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Takeaways:</span>
                                                            <asp:Button ID="btnPlTakes" onclientclick="playField(30);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Misses:</span>
                                                            <asp:Button ID="btnPlMisses" onclientclick="playField(23);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Giveaways:</span>
                                                            <asp:Button ID="btnPlGives" onclientclick="playField(31);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Blocks:</span>
                                                            <asp:Button ID="btnPlBlocks" onclientclick="playField(24);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Hits:</span>
                                                            <asp:Button ID="btnPlHits" onclientclick="playField(32);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">On Goal:</span>
                                                            <asp:Button ID="btnPlOnGoal" onclientclick="playField(25);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Penalty:</span>
                                                            <asp:Button ID="btnPlPens" onclientclick="playField(33);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Goals:</span>
                                                            <asp:Button ID="btnPlGoals" onclientclick="playField(26);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Pen Min:</span>
                                                            <asp:Button ID="btnPlPenMin" onclientclick="playField(34);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rbd Shots:</span>
                                                            <asp:Button ID="btnPlRbds" onclientclick="playField(27);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Pen Drawn:</span>
                                                            <asp:Button ID="btnPlPenDr" onclientclick="playField(35);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rbd Goals:</span>
                                                            <asp:Button ID="btnPlRbdGoals" onclientclick="playField(28);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Pen Dr Min:</span>
                                                            <asp:Button ID="btnPlPenDrMin" onclientclick="playField(36);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Pen Diff:</span>
                                                            <asp:Button ID="btnPlPenDiff" onclientclick="playField(37);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Assist1:</span>
                                                            <asp:Button ID="btnPlAss1" onclientclick="playField(29);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Assist2:</span>
                                                            <asp:Button ID="btnPlAss2" onclientclick="playField(38);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-10 padding-0">
                                                        <div class="panel panel-default">
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
                                                                    <div class="col-xs-2 padding-0" style="text-align: center;">
                                                                        Off%
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                                            <span class="input-group-addon">W:</span>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnPlFOTotW" onclientclick="playField(39);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnPlFODefW" onclientclick="playField(40);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnPlFONeuW" onclientclick="playField(41);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnPlFOOffW" onclientclick="playField(42);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblPlFOPct" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                                            <span class="input-group-addon">L:</span>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnPlFOTotL" onclientclick="playField(44);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnPlFODefL" onclientclick="playField(45);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnPlFONeuL" onclientclick="playField(46);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:Button ID="btnPlFOOffL" onclientclick="playField(47);return false;" runat="server" Text="0" class="btn btn-default"/>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-2 padding-0">
                                                        <br />
                                                        <br />
                                                        <br />
                                                        <img class="center-block" id="btnPlSL" src="Images/NHLrink2small.png" alt="Images/NHLrink2small.png" style="cursor: pointer;"/>
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
                                                            <asp:Button ID="btnOppShots" onclientclick="playField(48);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Giveaways:</span>
                                                            <asp:Button ID="btnOppGives" onclientclick="playField(55);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Misses:</span>
                                                            <asp:Button ID="btnOppMisses" onclientclick="playField(49);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Hits:</span>
                                                            <asp:Button ID="btnOppHits" onclientclick="playField(56);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Blocked:</span>
                                                            <asp:Button ID="btnOppBlocked" onclientclick="playField(50);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Penalty:</span>
                                                            <asp:Button ID="btnOppPens" onclientclick="playField(57);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">On Goal:</span>
                                                            <asp:Button ID="btnOppOnGoal" onclientclick="playField(51);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Pen Min:</span>
                                                            <asp:Button ID="btnOppPenMin" onclientclick="playField(58);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Goals:</span>
                                                            <asp:Button ID="btnOppGoals" onclientclick="playField(52);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rbd Goals:</span>
                                                            <asp:Button ID="btnOppRbdGoals" onclientclick="playField(59);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Rbd Shots:</span>
                                                            <asp:Button ID="btnOppRbds" onclientclick="playField(53);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Takeaways:</span>
                                                            <asp:Button ID="btnOppTakes" onclientclick="playField(54);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <img class="center-block" id="btnOppSL" src="Images/NHLrink2small.png" alt="Images/NHLrink2small.png" style="cursor: pointer;"/>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">
                                                                <strong><label>Total for Player</label></strong>
                                                                <div class="row">
                                                                    <div class="col-xs-6 padding-0">
                                                                        <div class="input-group">
                                                                            <span class="input-group-addon">GP:</span>
                                                                            <asp:label ID="lblGP" runat="server" style="text-align: left" class="form-control"></asp:label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-6 padding-0">
                                                                        <div class="input-group">
                                                                            <span class="input-group-addon">Time on Ice:</span>
                                                                            <asp:label ID="lblTotMins" runat="server" style="text-align: left" class="form-control"></asp:label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-xs-6 padding-0">
                                                                    </div>
                                                                    <div class="col-xs-6 padding-0">
                                                                        <div class="input-group">
                                                                            <span class="input-group-addon">Min/Game:</span>
                                                                            <asp:label ID="lblMinPerGame" runat="server" style="text-align: left" class="form-control"></asp:label>
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
                                    <div class="col-md-4 padding-0">
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
                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
                                    <div class="col-md-4 padding-0">
                                        <div class="panel panel-default">
                                            <div class="panel-heading panel-heading-custom">
                                                Player Statistics
                                            </div> 
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-3 col-xs-offset-7 padding-0" style="text-align: center;">
                                                        Shot Value
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                            <div class="btn-group" role="group">
                                                            </div>
                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                <span class="input-group-addon">Team Shots:</span>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblPlSVShots" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblPlSVValue" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                            <div class="btn-group" role="group">
                                                            </div>
                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                <span class="input-group-addon">Rebounds:</span>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblPlSVRbds" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblPlSVRbdValue" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-3 col-xs-offset-7 padding-0" style="text-align: center;">
                                                        Player Expected
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-12 padding-0">
                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                            <div class="btn-group" role="group">
                                                            </div>
                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                <span class="input-group-addon">Actual Goals:*</span>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblPlSVGoals" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblPlSVGoalExp" runat="server" Text="0" class="form-control"></asp:label>
                                                            </div>
                                                            <div class="btn-group" role="group">
                                                                <asp:label ID="lblPlSVGoalDiff" runat="server" Text="0" class="form-control"></asp:label>
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
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                                <span class="input-group-addon">On Goal Shot Results:</span>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblPlSVOnGoal" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblPlSVOnGoalDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                                <span class="input-group-addon">Value Blocked:</span>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblPlSVBlocked" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblPlSVBlockedDiff" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12 padding-0">
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                                                            <div class="btn-group" role="group" style="width: 1.5%;">
                                                                                <span class="input-group-addon">Value Missed</span>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblPlSVMissed" runat="server" Text="0" class="form-control"></asp:label>
                                                                            </div>
                                                                            <div class="btn-group" role="group">
                                                                                <asp:label ID="lblPlSVMissedDiff" runat="server" Text="0" class="form-control"></asp:label>
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
                                                            <asp:label ID="lblPlSVRbdGoals" runat="server" Text="0" class="form-control"></asp:label>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-6 padding-0">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">Empty Net Goals:</span>
                                                            <asp:label ID="lblPlSVEmpty" runat="server" Text="0" class="form-control"></asp:label>
                                                        </div>
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
                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
                                                                        <div class="btn-group btn-group-justified" role="group" aria-label="...">
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
            