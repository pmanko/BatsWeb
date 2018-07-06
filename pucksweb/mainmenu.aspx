<%@ Page AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="mainmenu.aspx.cbl" Inherits="pucksweb.mainmenu" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent" >
        <br />
        <br />
        <div class="container">
            <div class="row">
                <div id="MAJORS" class="col-md-4">
                    <h2>NHL</h2> 
                    <a href="/gameSummary.aspx?league=MA" class="btn btn-default btn-block">Games</a>    
                    <a href="/playerBreakdown.aspx?league=MA" class="btn btn-default btn-block">Player/Team Breakdown</a> 
                    <a href="/lineBreakdown.aspx?league=MA" class="btn btn-default btn-block">Line Breakdown</a> 
                    <a href="/goalieAnalysis.aspx?league=MA" class="btn btn-default btn-block">Goalie Analysis</a> 
                </div>
                <div id="MINORS" class="col-md-4">
                    <h2>MINORS</h2>     
                    <a href="/gameSummary.aspx?league=MI" class="btn btn-default btn-block">Games</a>    
                    <a href="/playerBreakdown.aspx?league=MI" class="btn btn-default btn-block">Player/Team Breakdown</a> 
                    <a href="/lineBreakdown.aspx?league=MI" class="btn btn-default btn-block">Line Breakdown</a> 
                    <a href="/goalieAnalysis.aspx?league=MI" class="btn btn-default btn-block">Goalie Analysis</a> 
                </div>
<%--                <div id="TRAINING" class="col-md-4">
                    <h2>TRAINING</h2>     --%>
            </div>
            <br />

            <br />

        </div>    
</asp:Content>