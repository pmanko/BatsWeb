<%@ Page AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="mainmenu.aspx.cbl" Inherits="batsweb.mainmenu" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent" >
    <form id="form1" runat="server">
        <br />
        <br />
        <div class="container">
            <div id="MAJORS">
                <h2>MAJORS</h2>     
                <asp:Panel ID="Panel1" runat="server">
                <div class="row">
                        <asp:Button ID="gamesButton" runat="server" Text="Games" OnClick="gamesButton_Click" Width="200px" CssClass="btn btn-default" />
                        <asp:Button ID="atbatButton" runat="server" Text="Full at Bat" OnClick="atbatButton_Click" Width="200px" CssClass="btn btn-default" />
                </div>
                <div class="row">
                        <asp:Button ID="pitcherBatterButton" runat="server" Text="Pitcher vs Batter At Bats" OnClick="pitcherBatterButton_Click" Width="200px" CssClass="btn btn-default" />
                        <asp:Button ID="Button3" runat="server" Text="Button" Width="200px" CssClass="btn btn-default" />
                </div>
                <div class="row">
                        <asp:Button ID="breakdownButton" runat="server" Text="Batter/Pitcher Breakdown" OnClick="breakdownButton_Click" Width="200px" CssClass="btn btn-default" />
                        <asp:Button ID="Button6" runat="server" Text="Button" Width="200px" CssClass="btn btn-default" />
                </div>
                </asp:Panel>
            </div>
            <br />
            <div id="MINORS">
                <h2>MINORS</h2>     
                <asp:Panel ID="Panel2" runat="server">
                    <div class="row">
                        <asp:Button ID="Button7" runat="server" Text="Games" OnClick="Button7_Click" Width="200px" CssClass="btn btn-default"  />
                        <asp:Button ID="Button10" runat="server" Text="Button" Width="200px" CssClass="btn btn-default"  />
                    </div>
                    <div class="row">
                        <asp:Button ID="Button9" runat="server" Text="Button" Width="200px" CssClass="btn btn-default"  />
                        <asp:Button ID="Button11" runat="server" Text="Button" OnClick="Button11_Click" Width="200px" CssClass="btn btn-default"  />
                    </div>
                    <div class="row">
                        <asp:Button ID="fullatbatButtonmi" runat="server" OnClick="fullatbatButtonmi_Click" Text="Full At Bat" Width="200px" CssClass="btn btn-default" />
                    </div>
                </asp:Panel>
            </div>
            <br />
            <div id="MISC">
                <h2>MISC</h2>     
                <asp:Panel ID="Panel3" runat="server">
                    <div class="row">
                        <asp:Button ID="EZvideobutton" runat="server" OnClick="EZvideobutton_Click" Text="EZ Video" Width="200px" CssClass="btn btn-default"/>
                        <asp:Button ID="Button12" runat="server" Text="Reload Games" OnClick="Button12_Click" Width="200px" CssClass="btn btn-default" />
                    </div>
                </asp:Panel>
            </div>
        </div>
    </form>
</asp:Content>