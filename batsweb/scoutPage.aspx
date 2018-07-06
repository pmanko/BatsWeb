<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="scoutPage.aspx.cbl" Inherits="pucksweb.scoutPage" EnableEventValidation="false" Language="C#" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link type="text/css" href="/Styles/scoutPage.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/scoutPage.js"></script> 
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
    <meta name="format-detection" content="telephone=no" />
    <script type="text/javascript" src="/dist/scripts/chart.min.js"></script>
    <script type="text/javascript" src="/dist/scripts/chartjs-plugin-annotation.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="panel panel-default" id="gamesPanel">
            <div class="panel-heading">
                <asp:DropDownList ID="ddTeam" runat="server" AutoPostBack="True" class="form-control">
                </asp:DropDownList>
            </div>
            <div class="panel-body">
<%--                <div class="row">
                    <div class="col-xs-6">
                        <div class="graph">
                            <div style="height: 22%;" class="barRed" id="teamRed1" data-toggle="tooltip" data-html="true" title="team1<br>info" ></div>
                            <div style="height: 11%;" class="barBlue" id="teamBlue1" data-toggle="tooltip" data-html="true" title="team1<br>info" ></div>
                            <div style="height: 100%;" class="breakBar"></div>
                            <div style="height: 100%;" class="barRed"></div>
                            <div class="centerLine"></div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="graph">
                            <div style="height: 22%;" class="barRed" id="teamRed2" data-toggle="tooltip" data-html="true" title="team1<br>info" ></div>
                            <div style="height: 11%;" class="barBlue" id="teamBlue2" data-toggle="tooltip" data-html="true" title="team1<br>info" ></div>
                            <div style="height: 100%;" class="breakBar"></div>
                            <div style="height: 100%;" class="barRed"></div>
                            <div style="height: 50%;" class="barBlue"></div>
                            <div class="centerLine"></div>
                        </div>
                    </div>
                </div>--%>
                <div class="row">
                    <div class="col-xs-6" >
                        <%--style="width: 400px">--%>
                        <canvas id="myGoalChart"></canvas>
                    </div>
                    <div class="col-xs-6">
                        <canvas id="myChanceChart"></canvas>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12" style="height:300px">
                        <%--style="width: 400px">--%>
                        <canvas id="fwdGoalChart"></canvas>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12" style="height:300px">
                        <%--style="width: 400px">--%>
                        <canvas id="fwdChanceChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

