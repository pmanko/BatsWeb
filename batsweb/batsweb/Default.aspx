<%@ Page Title="Home Page" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cbl" Inherits="batsweb._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 123px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Welcome to Batsweb!</h2>
    <p>
        &nbsp;</p>
    <table class="auto-style1">
        <tr>
            <td class="auto-style2">TEAM:</td>
            <td>
                <asp:TextBox ID="TextBox4" runat="server" Width="203px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style2">First name:</td>
            <td>
                <asp:TextBox ID="TextBox1" runat="server" Width="203px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style2">Last name:</td>
            <td>
                <asp:TextBox ID="TextBox3" runat="server" Width="203px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style2">Password:</td>
            <td>
                <asp:TextBox ID="TextBox2" runat="server" Height="16px" Width="204px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style2">
                <asp:Button ID="loginButton" runat="server" PostBackUrl="~/mainmenu.aspx" Text="Login" />
            </td>
            <td  class="auto-style2">
                <asp:Button ID="Button3" runat="server" Text="Test Password" OnClick="Button3_Click" />
            </td>
        </tr>
        <tr>
            <td class="auto-style2">
                <asp:Button ID="Button2" runat="server" Text="Go Back" />
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <p>
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>
