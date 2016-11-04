<%@ Page Title="Home Page" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cbl" Inherits="batsweb._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
        <script type="text/javascript" src="Scripts/default.js"></script> 
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <h2>Welcome to Batsweb!</h2>


    <div class="container">
        <div id="sign-in">
            <h2>Please sign in</h2>
            <asp:label ID="Msg" CssClass="text-danger" runat="server"></asp:label>
            <div class='form-group'>
                <label for="TextBox4" class="sr-only">Team:</label>
                <asp:DropDownList ID="teamDropDownList" runat="server" AutoPostBack="false" class="form-control" >
                    <asp:ListItem>HALTEST</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class='form-group'>
                <label for="TextBox1" class="sr-only">First Name:</label>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="First Name"></asp:TextBox>
            </div>
            <div class='form-group'>
                <label for="TextBox3" class="sr-only">Last Name:</label>
                <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" placeholder="Last Name"></asp:TextBox>
            </div>
            <div class='form-group'>
                <label for="TextBox2" class="sr-only">Password:</label>
                <asp:TextBox ID="TextBox2" runat="server" type="password" CssClass="form-control" placeholder="Password"></asp:TextBox>
            </div>
            <div class='checkbox checkbox-primary'><asp:CheckBox ID="rememberCheckBox" runat="server" AutoPostBack="False" Text="Remember Me" /></div>
           <asp:Button ID="loginButton" runat="server" Text="Log In" OnClick="loginButton_Click" class="btn btn-primary btn-block" />
            <a href="#" id="login" class="btn btn-lg btn-primary btn-block">Log In</a>
        </div>
    </div> <!-- /container -->
</asp:Content>
