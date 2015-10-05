<%@ Page AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="mainmenu.aspx.cbl" Inherits="batsweb.mainmenu" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

    <style type="text/css">
        .auto-style1 {
            width: 34%;
            height: 80px;
        }
        .auto-style2 {
            width: 133px;
        }
        .auto-style3 {
            width: 133px;
            height: 30px;
        }
        .auto-style4 {
            height: 30px;
            width: 1117px;
        }
        .auto-style5 {
            width: 1117px;
        }
        .auto-style8 {
            height: 30px;
            width: 124px;
        }
        .auto-style9 {
            width: 124px;
        }
        .auto-style10 {
            height: 30px;
            width: 88px;
        }
        .auto-style11 {
            width: 88px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div class="container main-container">

    <br />

    <h1>Game Summary</h1>

    <div id="main">
    <form id="form1" runat="server">
    <div>
    
        <asp:Panel ID="Panel1" runat="server" GroupingText="MAJORS" Width="421px">
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:Button ID="gamesButton" runat="server" Text="Games" OnClick="gamesButton_Click" />
                    </td>
                    <td class="auto-style5">
                        <asp:Button ID="Button2" runat="server" Text="Button" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">
                        <asp:Button ID="Button3" runat="server" Text="Button" />
                    </td>
                    <td class="auto-style4">
                        <asp:Button ID="Button4" runat="server" Text="Button" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Button ID="atbatButton" runat="server" Text="Full at Bat" OnClick="atbatButton_Click" />
                    </td>
                    <td class="auto-style5" bgcolor="#FF3300">
                        <asp:Button ID="Button6" runat="server" Text="Button" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    
        <br />
        <asp:Panel ID="Panel3" runat="server" Font-Bold="False" GroupingText="MINORS" style="height: 111px; width: 413px">
            <table>
                <tr>
                    <td class="auto-style10">
                        <asp:Button ID="Button7" runat="server" Text="Games" OnClick="Button7_Click" />
                    </td>
                    <td class="auto-style8">
                        <asp:Button ID="Button10" runat="server" Text="Button" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style11">
                        <asp:Button ID="Button9" runat="server" Text="Button" />
                    </td>
                    <td class="auto-style9">
                        <asp:Button ID="Button11" runat="server" Text="Button" OnClick="Button11_Click" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style11">
                        <asp:Button ID="fullatbatButtonmi" runat="server" OnClick="fullatbatButtonmi_Click" Text="Full At Bat" />
                    </td>
                    <td class="auto-style9">&nbsp;</td>
                </tr>
            </table>
        </asp:Panel>
    
    </div>
        <br />        <br />
        <asp:Panel ID="Panel4" runat="server" GroupingText="MISC." Height="93px" Width="415px">
            <table>
                <tr>
                    <td>
                        <asp:Button ID="EZvideobutton" runat="server" BorderStyle="Dashed" OnClick="EZvideobutton_Click" Text="EZ Video" />
                    </td>
                    <td>
                        <asp:Button ID="Button12" runat="server" Text="Reload Games" OnClick="Button12_Click" />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </asp:Panel>
    </form>
        </div>
        </div>
</asp:Content>