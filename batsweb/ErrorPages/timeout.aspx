<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="timeout.aspx.cbl" Inherits="batsweb.ErrorPages.timeout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id='fullatbat' class="container main-container">
        <form id="form1" runat="server">
            <div>
                <h2>Session has timed out. Click to return to login page.</h2> 
                <a href="/default.aspx" class="btn btn-lg btn-primary">Return</a>    
            </div>
        </form>
    </div>
</asp:Content>
