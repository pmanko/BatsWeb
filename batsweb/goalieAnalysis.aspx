<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="goalieAnalysis.aspx.cbl" Inherits="pucksweb.goalieAnalysis" EnableEventValidation="false" Language="C#"  %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link type="text/css" href="/Styles/goalieAnalysis.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/goalieAnalysis.js"></script> 
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
                            <span class="input-group-addon">Goalie:</span>
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
                            <div class="col-xs-3">
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
                           <div class="col-xs-9">
                                <div class="row">
                                    <div class="col-xs-6">
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
                                    </div>
                                    <div class="col-xs-6">
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
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-8">
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
                                    <div class="col-xs-4">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                Games Location
                                            </div> 
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        <div class='radio radio-primary'><asp:RadioButton ID="rbAllLocations" runat="server" GroupName="location" text="All Locations" OnCheckedChanged="rbAllLocations_CheckedChanged" /></div>
                                                    </div> 
                                                </div> 
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        <div class='radio radio-primary'><asp:RadioButton ID="rbPlayerHome" runat="server" GroupName="location" text="Player Home" OnCheckedChanged="rbHome_CheckedChanged" /></div>
                                                    </div> 
                                                </div> 
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        <div class='radio radio-primary'><asp:RadioButton ID="rbPlayerAway" runat="server" GroupName="location" text="Player Away" OnCheckedChanged="rbAway_CheckedChanged" /></div>
                                                    </div> 
                                                </div> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <asp:Button ID="btnGo" runat="server" Text="Go-Read These Games!" OnClick="btnGo_Click" class="btn btn-lg btn-block btn-primary"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
        <div class="panel panel-default">
            <div class="row">
                <div class="col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Sort Options
                        </div> 
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-xs-5">
                                    <div class="input-group">
                                        <span class="input-group-addon">Period:</span>
                                        <asp:DropDownList ID="ddPeriod" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddPeriod_SelectedIndexChanged" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon">Opp Situation:</span>
                                        <asp:DropDownList ID="ddSituation" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddSituation_SelectedIndexChanged" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon">Rebound Secs:</span>
                                        <asp:TextBox ID="tbRbdSeconds" runat="server" maxlength="2" onkeypress="return isNumberKey(event)" class="form-control"></asp:TextBox>
                                        <span class="input-group-btn">
                                            <asp:Button ID="btnGoRbd" runat="server" Text="Go" OnClick="btnGoRbd_Click" class="btn btn-md btn-block btn-default"/>
                                        </span>
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
                                <div class="col-xs-4">
                                    <div class="input-group">
                                        <span class="input-group-addon">Score:</span>
                                        <asp:DropDownList ID="ddScore" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddScore_SelectedIndexChanged" class="form-control">
                                        </asp:DropDownList>
                                    </div>
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
                                </div>
                                <div class="col-xs-3">
                                    <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbReboundShotsOnly" runat="server" AutoPostBack="True" OnCheckedChanged="cbReboundShotsOnly_CheckedChanged" Text="Rebound Shots Only" /></div>         
                                    <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbShCausingRbd" runat="server" AutoPostBack="True" OnCheckedChanged="cbShCausingRbd_CheckedChanged" Text="Shot Causing Rebound" /></div>         
                                    <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbFirstShotsOnly" runat="server" AutoPostBack="True" OnCheckedChanged="cbFirstShotsOnly_CheckedChanged" Text="First Shots Only" /></div>         
                                    <asp:Button ID="btnReset" runat="server" Text="Reset Selections" OnClick="btnReset_Click" class="btn btn-md btn-success"/>
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
                    <div class="col-md-5">
                        <br />
                        <div class="outsideWrapper center-block">
                            <div class="insideWrapper">
                                <img id="rinkImagebtn" src="Images/NHLrink2.png" class="coveredImage" alt="Images/NHLrink2.png"/>
                                <canvas id="canvas" width="277" height="336" class="coveringCanvas" style="cursor:pointer;"/>
                            </div>
                        </div>
                        Click and drag over shot locations to select video to view
                        <a href="#" class="btn btn-block btn-primary btn-async-request" data-action-flag="play-full">
                            <span class="glyphicon glyphicon-play" aria-hidden="true"></span> All
                        </a>
                        <a href="#" class="btn btn-block btn-primary btn-async-request" data-action-flag="play-sel">
                            <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Selected
                        </a>
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
                        <div class="panel panel-warning">
                            <div class="panel-heading">
                                Opponent Statistics
                            </div> 
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-xs-6 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">Shots:</span>
                                            <asp:Button ID="btnOppShots" onclientclick="playField(1);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                        </div>
                                    </div>
                                    <div class="col-xs-6 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">Rbd:</span>
                                            <asp:Button ID="btnOppRbd" onclientclick="playField(4);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">On Goal:</span>
                                            <asp:Button ID="btnOppOnGoal" onclientclick="playField(2);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                        </div>
                                    </div>
                                    <div class="col-xs-6 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">Rbd %:</span>
                                            <asp:Button ID="btnOppRbdPct" onclientclick="playField(4);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">Goals:</span>
                                            <asp:Button ID="btnOppGoals" onclientclick="playField(3);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                        </div>
                                    </div>
                                    <div class="col-xs-6 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">Rbd G:</span>
                                            <asp:Button ID="btnOppRbdG" onclientclick="playField(5);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">Save %:</span>
                                            <asp:Button ID="btnOppSavePct" onclientclick="playField(6);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                        </div>
                                    </div>
                                    <div class="col-xs-6 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">Rbd G%:</span>
                                            <asp:Button ID="btnOppRbdGPct" onclientclick="playField(5);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6 padding-0">
                                        <div class="input-group">
                                            <span class="input-group-addon">Exp Save %:</span>
                                            <asp:Button ID="btnOppExpSvPct" onclientclick="playField(2);return false;" runat="server" Text="0" class="btn btn-md btn-block btn-default"/>
                                        </div>
                                    </div>
                                    <div class="col-xs-6 padding-0">
                                        <img class="center-block" id="btnRbdSprayChart" src="Images/RbdSprayChartSmall.png" alt="Images/RbdSprayChartSmall.png" style="cursor: pointer;"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <div class="row">
                    <div class="col-xs-6">
                        Key:
                        <label style="color:yellowgreen">Green: Goals </label>
                        <label style="color:royalblue">Blue: Saved </label>
                        <label style="color:black">Black: Missed/Blocked</label>
                    </div>
                    <div class="col-xs-6">
                        <div class="input-group">
                            <span class="input-group-addon" style="min-width:80px">Games:</span>
                            <asp:TextBox ID="lblGoalieGames" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
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

        <!--Rebounds Modal -->
        <div class="modal fade" id="rbdModal" tabindex="-1" role="dialog" aria-labelledby="rbdModalLabel">
          <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="H3"> Rebound Spray Chart</h4>
                  Choose a Set of Shots on the Main Goalie Screen, Then Re-click the Rebound Spray Chart Button
              </div>
              <div class="modal-body">
                  <div class="row">
                      <div class="col-xs-12">
                        <img id="rbdImagebtn" src="Images/NHLrink2.png" class="center-block" alt="Images/NHLrink2.png"/>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-xs-12">
                            <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbHideShotLines" runat="server" AutoPostBack="False" Text="Hide Shot Lines"  OnClick="hideShotLines(this);" /></div>         
                      </div>
                  </div>
              </div>
              <div class="modal-footer">
                  <div class="row">
                      <div class="col-md-6" style="text-align:left">
                          Line Key:
                          <label style="color:royalblue">Blue: Original Shot </label>
                          <label style="color:red">Red: Rebound Shot</label>
                      </div>
                      <div class="col-md-6">
                        Key:
                        <label style="color:yellowgreen">Green: Goals </label>
                        <label style="color:royalblue">Blue: Saved </label>
                        <label style="color:black">Black: Missed/Blocked</label>
                      </div>
                  </div>
              </div>
          </div>
        </div>
        </div>

    </div>
</asp:Content>
