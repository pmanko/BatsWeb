<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="shotValueExplanation.aspx.cbl" Inherits="pucksweb.shotValueExplanation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="panel panel-primary" id="selectionPanel">
            <div class="panel-heading">
                <h1>The Value of a Shot is its Percent Chance of Scoring</h1>
                &emsp;
                <small>*Based on a sample of over 200,000 NHL shots</small>
            </div>
            <div class="panel-body">
                <img class="center-block" src="Images/Shot Values Example.png" alt="image cannot be loaded"/>
            </div>
        </div>
    </div>
</asp:Content>