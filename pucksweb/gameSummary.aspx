<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="gameSummary.aspx.cbl" Inherits="pucksweb.gameSummary" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link type="text/css" href="/Styles/gamesummary.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/gamesummary.js"></script> 
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
    <meta name="format-detection" content="telephone=no" />
    <link type="text/css" href="/dist/styles/dataTables.bootstrap.min.css" rel="stylesheet" />
    <link type="text/css" href="/dist/styles/select.bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="/dist/scripts/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/dist/scripts/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="/dist/scripts/dataTables.select.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div class="panel panel-default" id="gamesPanel">
<%--                <div class="panel-heading">
                    <div class="panel-title">List of Games</div>
                </div>--%>
                <div class="panel-body padding-none">
<%--                <div class="listbox-replacement-wrapper">
                    <asp:Table id="gamesTable" runat="server" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                data-index-field="#MainContent_gamesIndexField" 
                                data-value-field="#MainContent_gamesValueField" 
                                data-postback="double" 
                                data-multiple="false"
                    >
                    <asp:TableHeaderRow TableSection="TableHeader">
                        <asp:TableHeaderCell> Date                  Vis                      Score Home                   Score Video Gametype</asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                    </asp:Table>
                </div>--%>
                <table id="vis" class="table table-hover table-striped" style="width:100%"> </table>
                <asp:HiddenField ID="gamesValueField" runat="server" onvaluechanged="gameSelected" />
                <asp:HiddenField ID="gamesIndexField" runat="server"   />
                <asp:HiddenField ID="visField" runat="server" />
                </div>
                <%--<br />--%>
                <div class="panel-footer">
                    <div class="row">
                    <div class="col-xs-3">
                        <div class='radio radio-primary'>
                            <asp:RadioButton ID="rbAllGames" runat="server" GroupName="Games" Text="All Games" AutoPostBack="True" OnCheckedChanged="rbAllGames_CheckedChanged" />
                        </div>
                        <div class='form-group'>
                            <div class="input-group">
                                <span class="input-group-addon">Year:</span>
                                <asp:DropDownList ID="ddYear" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddYear_SelectedIndexChanged" class="form-control">
                                    <asp:ListItem>2021-2022</asp:ListItem>
                                    <asp:ListItem>2020-2021</asp:ListItem>
                                    <asp:ListItem>2019-2020</asp:ListItem>
                                    <asp:ListItem>2018-2019</asp:ListItem>
                                    <asp:ListItem>2017-2018</asp:ListItem>
                                    <asp:ListItem>2016-2017</asp:ListItem>
                                    <asp:ListItem>2015-2016</asp:ListItem>
                                    <asp:ListItem>2014-2015</asp:ListItem>
                                    <asp:ListItem>2013-2014</asp:ListItem>
                                    <asp:ListItem>2012-2013</asp:ListItem>
                                    <asp:ListItem>2011-2012</asp:ListItem>
                                    <asp:ListItem>2010-2011</asp:ListItem>
                                    <asp:ListItem>2009-2010</asp:ListItem>
                                    <asp:ListItem>2008-2009</asp:ListItem>
                                    <asp:ListItem>2007-2008</asp:ListItem>
                                    <asp:ListItem>2006-2007</asp:ListItem>
                                    <asp:ListItem>2005-2006</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-3 padding-0">
                        <div class='radio radio-primary'><asp:RadioButton ID="rbTeam" runat="server" GroupName="Games" Text="Team:" AutoPostBack="True" OnCheckedChanged="rbTeam_CheckedChanged" /></div>
                        <asp:DropDownList ID="ddTeam" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddTeam_SelectedIndexChanged" class="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <button type="button" id="btnGoals" class="btn btn-success" data-toggle="collapse" data-target="#allGoals">
                            <span class="glyphicon glyphicon-collapse-down" aria-hidden="true"></span> Show All Goals for Date
                        </button>
                        <%--<asp:Button ID="goalsButton" runat="server" Text="Show All Goals for Date" OnClick="goalsButton_Click" class="btn btn-success btn-block" />--%>
                    </div>
                    <div class="col-md-3">
                        <asp:Button ID="playsButton" runat="server" Text="Show Plays" OnClick="playsButton_Click" class="btn btn-primary" />
                    </div>
                </div>
                </div>
            </div>
           <!-- All Goals Screen -->

            <div class="collapse" id="allGoals">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong><label id="lblAllGoals"></label></strong>
                </div>
                <div class='panel-body'>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="listbox-replacement-wrapper" id="goalsTableWrapper">
                                <table id="goalsTable" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                data-value-field="#MainContent_goalsValueField" 
                                data-index-field="#MainContent_goalsIndexField" 
                                data-postback="false" 
                                data-multiple="true"
                                data-on-select="goalsUpdate"
                                data-on-dblclick-select="goalsUpdateDblclick"
                                data-on-dblclick="openBatsTube"
                                >
                                <thead>
                                <tr>
                                    <th>Pd V H   Description</th>
                                </tr>
                                </thead>
                                <tbody id="goalsTableBody" runat="server"></tbody>
                                </table>
                            </div>
                            <asp:HiddenField ID="goalsValueField" runat="server" />
                            <asp:HiddenField ID="goalsIndexField" runat="server"  />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3">
                            <a href="#" class="btn btn-block btn-primary btn-async-request" data-action-flag="play-goals">
                                <span class="glyphicon glyphicon-play" aria-hidden="true"></span> All
                            </a>
                        </div>
                        <div class="col-xs-3">
                            <a href="#" class="btn btn-block btn-primary btn-async-request" data-action-flag="goals-selection">
                                <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Selection
                            </a>
                        </div>
                        <div class="col-xs-3">
                            <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbPowerGoals" runat="server" AutoPostBack="False" OnClick="handleClick(this);" Text="Show All PP Goals" /></div>         
                        </div>
                        <div class="col-xs-3">
                            <div class='checkbox checkbox-primary'><asp:CheckBox ID="cbChanceGoals" runat="server" AutoPostBack="False" OnClick="handleClick(this);" Text="Show All 5% Chances" /></div>         
                        </div>
                    </div>
                </div>
            </div>
            </div>

            <br />

            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-title">Play Summary</div>
                </div>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="listbox-replacement-wrapper">
                    <asp:Table id="playTable" runat="server" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                    data-value-field="#MainContent_playValueField" 
                    data-index-field="#MainContent_playIndexField" 
                    data-postback="false" 
                    data-multiple="true"
                    data-on-select="playUpdate"
                    data-on-dblclick-select="playUpdateDblclick"
                    >
                                                                     
                    </asp:Table>
                </div>
                <asp:HiddenField ID="playValueField" runat="server" />
                <asp:HiddenField ID="playIndexField" runat="server"  />
                                    
                <div class="panel-footer">
                    <div class='row'>
                        <div class="col-xs-6">
                            <div class='row'>
                                <div class="col-xs-6">
                                    <a href="#" class="btn btn-block btn-primary btn-async-request" data-action-flag="play-full">
                                        <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Full Game
                                    </a>
                                </div>
                                <div class="col-xs-6">
                                    <a href="#" class="btn btn-block btn-primary btn-async-request" data-action-flag="from-sel">
                                        <span class="glyphicon glyphicon-play" aria-hidden="true"></span> From Selected
                                    </a>
                                </div>
                            </div>
                            <br />
                            <div class='row'>
                                <div class="col-xs-12">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                                    <label>Jump To</label>
                                            <div class="row">
                                                <div class="col-xs-4 padding-0">
                                                  <div class="input-group">
                                                        <span class="input-group-addon">P</span>
                                                      <select class="form-control" id="period">
                                                        <option>1</option>
                                                        <option>2</option>
                                                        <option>3</option>
                                                        <option>4</option>
                                                        <option>5</option>
                                                        <option>6</option>
                                                        <option>7</option>
                                                        <option>8</option>
                                                        <option>9</option>
                                                     </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-5 padding-0">
                                                  <div class="input-group">
                                                    <input name="min" id="min" onkeypress="return isNumberKey(event)" maxlength="2" class="form-control"/>
                                                    <span class="input-group-addon">:</span>
                                                    <input name="sec" id="sec" onkeypress="return isNumberKey(event)" maxlength="2" class="form-control"/>
                                                    </div>
                                                </div>
                                                <div class="col-xs-3">
                                                    <a href="#" class="btn btn-block btn-primary btn-async-request" data-action-flag="play-jump">Go</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
<%--                    <div class="clearfix"></div>
                    </div>--%>
                        <div class="col-xs-6">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    Sort By Event Type
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-xs-7">
                                            <div class="input-group">
                                                <span class="input-group-addon">NHL:</span>
                                                <asp:DropDownList ID="ddNhlEvent" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddNhlEvent_SelectedIndexChanged" class="form-control">
                                                </asp:DropDownList>         
                                            </div>
                                        </div>
                                        <div class="col-xs-5 padding-0">
                                            <a href="#" class="btn btn-block btn-primary btn-async-request" data-action-flag="play-sel">
                                                <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Selection
                                            </a>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-7">
                                            <div class="input-group">
                                                <span class="input-group-addon">Custom:</span>
                                                <asp:DropDownList ID="ddCustomEvent" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddCustomEvent_SelectedIndexChanged" class="form-control">
                                                </asp:DropDownList>         
                                            </div>
                                        </div>
                                        <div class="col-xs-5 padding-0">
                                            <a href="#" class="btn btn-info" data-toggle="modal" data-target="#advancedModal">
                                                <span class="glyphicon glyphicon-search" aria-hidden="true"></span> 
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
<%--            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddNhlEvent" />
            </Triggers>--%>
            </asp:UpdatePanel>
            </div>
            <div class="panel panel-default">
                <div class='panel-body'>
                    <div class='row'>
                        <div class="col-md-5">
                            <strong><asp:label id="lblVis" runat="server" Text="Visitors"></asp:label></strong>
                            <div class="btn-group" role="group" aria-label="...">
                                <button type="button" id="visPP" class="btn btn-default">Power Play</button>
                                <button type="button" id="visSH" class="btn btn-default">Short Hand</button>
                                <button type="button" id="visTOI" class="btn btn-default" data-toggle="collapse" data-target="#toiCollapse">Time On Ice</button>
                            </div>
    <%--                         <div class="btn-group" role="group" aria-label="...">
                             <button type="button" id="replays" class="btn btn-default" data-toggle="modal" data-target="#replaysModal">
                                  <span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> Replays
                              </button>--%>
                        </div>
                        <div class="col-md-2" style="text-align: center">  
                              <button type="button" id="btnGameReport" class="btn btn-default" data-toggle="collapse" data-target="#gameReport">
                                  <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> Game Report
                              </button>
                        </div>
                        <div class="col-md-5" style="text-align: right">
                            <strong><asp:label id="lblHome" runat="server" Text="Home"></asp:label></strong>
                            <div class="btn-group" role="group" aria-label="...">
                              <button type="button" id="homePP" class="btn btn-default">Power Play</button>
                              <button type="button" id="homeSH" class="btn btn-default">Short Hand</button>
                              <button type="button" id="homeTOI" class="btn btn-default" data-toggle="collapse" data-target="#toiCollapse">Time On Ice</button>
                            </div>
                        </div>
                    </div>
                </div>
                    
            </div>

        <!-- Game Report -->

        <div class="collapse" id="gameReport">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
            <div class='row'>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <strong><asp:label id="lblVisReport" runat="server" Text="Visitors"></asp:label></strong>
                        </div>
                        <div class='panel-body'>
                            <div class='row'>
                                <div class="col-md-12">
                                    <table class="table table-bordered table-hover">
                                        <tbody>
                                            <tr>
                                                <th scope="row" style="text-align: right">Total Shots: </th>
                                                <td><asp:Literal ID="visTotalShots" runat="server"></asp:Literal></td>
                                                <th style="text-align: right">Value: </th>
                                                <td><asp:Literal ID="visTotalVal" runat="server"></asp:Literal></td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="text-align: right">First Shots: </th>
                                                <td><asp:Literal ID="visFirstShots" runat="server"></asp:Literal></td>
                                                <th style="text-align: right">Value: </th>
                                                <td><asp:Literal ID="visFirstVal" runat="server"></asp:Literal></td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="text-align: right">Rebounds: </th>
                                                <td><asp:Literal ID="visRebounds" runat="server"></asp:Literal></td>
                                                <th style="text-align: right">Value: </th>
                                                <td><asp:Literal ID="visReboundVal" runat="server"></asp:Literal></td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="text-align: right">Opponent Blocked: </th>
                                                <td><asp:Literal ID="visOppBlocked" runat="server"></asp:Literal></td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="text-align: right">Net Value: </th>
                                                <td><asp:Literal ID="visNetVal" runat="server"></asp:Literal></td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="text-align: right">Empty Net Goals: </th>
                                                <td><asp:Literal ID="visEmptyGoals" runat="server"></asp:Literal></td>
                                                <th style="text-align: right">Rebound Goals: </th>
                                                <td><asp:Literal ID="visReboundGoals" runat="server"></asp:Literal></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class='row'>
                                <div class="col-md-12">
                                    <div class="outsideWrapper center-block">
                                        <div class="insideWrapper">
                                            <img id="visRinkImagebtn" src="Images/NHLrink2.png" class="coveredImage" alt="Images/NHLrink2.png"/>
                                            <canvas id="visCanvas" width="277" height="336" class="coveringCanvas" style="cursor:pointer;"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class='row'>
                                <div class="col-xs-6">
                                  <button type="button" id="btnVisFwdLines" class="btn btn-default center-block"> 
                                       <span class="glyphicon glyphicon-align-justify" aria-hidden="true"></span> Fwd Lines/Def Pairs
                                    </button>
                                </div>
                                <div class="col-xs-6">
                                    <button type="button" id="btnVisSelected" class="btn btn-primary center-block"> 
                                       <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Selected
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <strong><asp:label id="lblHomeReport" runat="server" Text="Home"></asp:label></strong>
                        </div>
                        <div class='panel-body'>
                            <div class='row'>
                                <div class="col-md-12">
                                    <table class="table table-bordered table-hover">
                                        <tbody>
                                            <tr>
                                                <th scope="row" style="text-align: right">Total Shots: </th>
                                                <td><asp:Literal ID="homeTotalShots" runat="server"></asp:Literal></td>
                                                <th style="text-align: right">Value: </th>
                                                <td><asp:Literal ID="homeTotalVal" runat="server"></asp:Literal></td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="text-align: right">First Shots: </th>
                                                <td><asp:Literal ID="homeFirstShots" runat="server"></asp:Literal></td>
                                                <th style="text-align: right">Value: </th>
                                                <td><asp:Literal ID="homeFirstVal" runat="server"></asp:Literal></td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="text-align: right">Rebounds: </th>
                                                <td><asp:Literal ID="homeRebounds" runat="server"></asp:Literal></td>
                                                <th style="text-align: right">Value: </th>
                                                <td><asp:Literal ID="homeReboundVal" runat="server"></asp:Literal></td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="text-align: right">Opponent Blocked: </th>
                                                <td><asp:Literal ID="homeOppBlocked" runat="server"></asp:Literal></td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="text-align: right">Net Value: </th>
                                                <td><asp:Literal ID="homeNetVal" runat="server"></asp:Literal></td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="text-align: right">Empty Net Goals: </th>
                                                <td><asp:Literal ID="homeEmptyGoals" runat="server"></asp:Literal></td>
                                                <th style="text-align: right">Rebound Goals: </th>
                                                <td><asp:Literal ID="homeReboundGoals" runat="server"></asp:Literal></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class='row'>
                                <div class="col-md-12">
                                    <div class="outsideWrapper center-block">
                                        <div class="insideWrapper">
                                            <img id="homeRinkImagebtn" src="Images/NHLrink2.png" class="coveredImage" alt="Images/NHLrink2.png"/>
                                            <canvas id="homeCanvas" width="277" height="336" class="coveringCanvas" style="cursor:pointer;"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class='row'>
                                <div class="col-xs-6">
                                    <button type="button" id="btnHomeFwdLines" class="btn btn-default center-block"> 
                                       <span class="glyphicon glyphicon-list" aria-hidden="true"></span> Fwd Lines/Def Pairs
                                    </button>
                                </div>
                                <div class="col-xs-6">
                                    <button type="button" id="btnHomeSelected" class="btn btn-primary center-block"> 
                                       <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Selected
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class='row'>
                <div class="col-xs-12">
                    <div class="panel panel-default">
                        <div class='panel-body'>
                            <div class='row'>
                                <div class="col-xs-3">
                                    <button type="button" id="btnPlayerGameValue" class="btn btn-default"> 
                                       <span class="glyphicon glyphicon-list" aria-hidden="true"></span> Player Game Value
                                    </button>
                                </div>
                                <div class="col-xs-3" style="text-align: right">
                                    <div class="input-group">
                                        <span class="input-group-addon">Period:</span>
                                        <asp:DropDownList ID="ddPeriod" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddPeriod_SelectedIndexChanged" class="form-control">
                                            <asp:ListItem>ALL</asp:ListItem>
                                            <asp:ListItem>REG</asp:ListItem>
                                            <asp:ListItem>OT</asp:ListItem>
                                            <asp:ListItem>1</asp:ListItem>
                                            <asp:ListItem>2</asp:ListItem>
                                            <asp:ListItem>3</asp:ListItem>
                                            <asp:ListItem>4</asp:ListItem>
                                            <asp:ListItem>5</asp:ListItem>
                                            <asp:ListItem>6</asp:ListItem>
                                            <asp:ListItem>7</asp:ListItem>
                                            <asp:ListItem>8</asp:ListItem>
                                            <asp:ListItem>9</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-xs-6" style="text-align: right">
                                    Key:
                                    <label style="color:yellowgreen">Green: Goals </label>
                                    <label style="color:darkgray">Grey: Blocked </label>
                                    <label style="color:royalblue">Blue: Saved </label>
                                    <label style="color:black">Black: Missed</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </ContentTemplate>
<%--            <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddPeriod"/>
            </Triggers>--%>
            </asp:UpdatePanel>
        </div>


        <!-- toi Screen -->

        <div class="collapse" id="toiCollapse">
            <div class="panel panel-default">
                <div class="panel-header">
                    <button type="button" class="close" id="toiClose" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class='panel-body'>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button1" onclick="playerButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button7" onclick="playerButton(7)" style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button13" onclick="playerButton(13)" style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button19" onclick="playerButton(19)" style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button25" onclick="playerButton(25)" style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button2" onclick="playerButton(2)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button8" onclick="playerButton(8)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button14" onclick="playerButton(14)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button20" onclick="playerButton(20)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button26" onclick="playerButton(26)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button3" onclick="playerButton(3)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button9" onclick="playerButton(9)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button15" onclick="playerButton(15)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button21" onclick="playerButton(21)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button27" onclick="playerButton(27)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button4" onclick="playerButton(4)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button10" onclick="playerButton(10)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button16" onclick="playerButton(16)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button22" onclick="playerButton(22)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button28" onclick="playerButton(28)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button5" onclick="playerButton(5)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button11" onclick="playerButton(11)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button17" onclick="playerButton(17)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button23" onclick="playerButton(23)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button29" onclick="playerButton(29)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button6" onclick="playerButton(6)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button12" onclick="playerButton(12)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button18" onclick="playerButton(18)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button24" onclick="playerButton(24)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                                <div class="btn-group" role="group">
                                    <button type="button" id="Button30" onclick="playerButton(30)"  style="display:none;" class="btn btn-default"> Button1</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- TOI Modal -->

        <div class="modal fade" id="toiModal" tabindex="-1" role="dialog" aria-labelledby="toiModalLabel">
          <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="toiModalLabel">Time On Ice Shifts</h4>
              </div>
              <div class="modal-body">
                <div class='row'>
                    <div class="col-md-12">
                        <strong><label id="lblPlayerName"></label></strong>
                    </div>
                </div>
                    <div class="listbox-replacement-wrapper" id="toiTableWrapper">
                        <table id="toiTable" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                    data-index-field="#MainContent_toiIndexField" 
                                    data-value-field="#MainContent_toiValueField" 
                                    data-postback="false" 
                                    data-multiple="false"
                                    data-on-select="toiUpdate"
                                    data-on-dblclick-select="toiUpdateDblclick"
                                    data-on-dblclick="openBatsTube"
                        >
                            <thead>
                            <tr>
                                <th>Prd  In   Out  Secs Type</th>
                            </tr>
                            </thead>
                        <tbody id="toiTableBody" runat="server"></tbody>
                        </table>
                    </div>
                    <asp:HiddenField ID="toiIndexField" runat="server" />
                    <asp:HiddenField ID="toiValueField" runat="server"  />
              </div>
              <div class="modal-footer">
                  <a href="#" class="btn btn-primary btn-async-request" data-action-flag="from-toi" style="text-align: center">
                      <span class="glyphicon glyphicon-play" aria-hidden="true"></span> From Selected
                  </a>
              </div>
            </div>
          </div>
        </div>

        <!-- Advanced Modal -->

        <div class="modal fade" id="advancedModal" tabindex="-1" role="dialog" aria-labelledby="advancedModalLabel">
          <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Advanced Search</h4>
                <small><label>Search Custom Marks by One or Two Keywords or Phrases
                        (Any Word or Phrase Contained in the Note Text)</label></small>
              </div>
              <div class="modal-body">
                  <div class="row">
                      <div class="col-md-12">
                          <div class="input-group">
                              <span class="input-group-addon">Search Criteria 1:</span>
                              <asp:TextBox ID="tbNote1" runat="server" class="form-control" ClientIDMode="Static"></asp:TextBox>
                          </div>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-md-12">
                          <div class="input-group">
                              <span class="input-group-addon">Search Criteria 2:</span>
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
                          <button type="button" id="btnReset" class="btn btn-default"> Reset All</button>
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

    </div>
</asp:Content>
