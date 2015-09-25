<%@ Page Title="Home Page" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cbl" Inherits="batsweb._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <form runat="server">

    <h2>Welcome to Batsweb!</h2>


    <div class="container">
        <div id="sign-in">
            <h2>Please sign in</h2>
            <label for="TextBox4" class="sr-only">Team:</label>
            <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" placeholder="Team"></asp:TextBox>
            
            <label for="TextBox4" class="sr-only">First Name:</label>
            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="First Name"></asp:TextBox>

            <label for="TextBox4" class="sr-only">Last Name:</label>
            <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" placeholder="Last Name"></asp:TextBox>

            <label for="TextBox4" class="sr-only">Password:</label>
            <asp:TextBox ID="TextBox2" runat="server" type="password" CssClass="form-control" placeholder="Password"></asp:TextBox>

            <div class="checkbox">
              <label>
                <input type="checkbox" value="remember-me"> Remember me
              </label>
            </div>
            <asp:Button ID="loginButton" runat="server" PostBackUrl="~/mainmenu.aspx" Text="Sign In" class="btn btn-lg btn-primary btn-block"/>



        </div>
    </div> <!-- /container -->
    </form>
</asp:Content>
