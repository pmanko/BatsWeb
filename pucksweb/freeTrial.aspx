<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="freeTrial.aspx.cbl" Inherits="pucksweb.freeTrial" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
        <style>
        .input-group-addon {
    min-width:160px;
    text-align:right;
}
    </style>
    <meta name="format-detection" content="telephone=no" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div id="sign-in">
        <div class="panel panel-default" id="gamesPanel">
            <div class="panel-heading">
                <div class="panel-title">Sign up here for a 30 day free trial!</div>
            </div>
            <div class="panel-body">
                <div class='form-group'>
                    <div class="input-group" style="width:100%">
                        <span class="input-group-addon">NHL Team:</span>
                        <asp:DropDownList ID="ddTeam" runat="server" AutoPostBack="false" class="form-control" >
                            <asp:ListItem>Avalanche</asp:ListItem>
                            <asp:ListItem>Blackhawks</asp:ListItem>
                            <asp:ListItem>Blue Jackets</asp:ListItem>
                            <asp:ListItem>Blues</asp:ListItem>
                            <asp:ListItem>Bruins</asp:ListItem>
                            <asp:ListItem>Canadiens</asp:ListItem>
                            <asp:ListItem>Canucks</asp:ListItem>
                            <asp:ListItem>Capitals</asp:ListItem>
                            <asp:ListItem>Coyotes</asp:ListItem>
                            <asp:ListItem>Devils</asp:ListItem>
                            <asp:ListItem>Ducks</asp:ListItem>
                            <asp:ListItem>Flames</asp:ListItem>
                            <asp:ListItem>Flyers</asp:ListItem>
                            <asp:ListItem>Golden Knights</asp:ListItem>
                            <asp:ListItem>Hurricanes</asp:ListItem>
                            <asp:ListItem>Islanders</asp:ListItem>
                            <asp:ListItem>Jets</asp:ListItem>
                            <asp:ListItem>Kings</asp:ListItem>
                            <asp:ListItem>Lightning</asp:ListItem>
                            <asp:ListItem>Maple Leafs</asp:ListItem>
                            <asp:ListItem>Oilers</asp:ListItem>
                            <asp:ListItem>Panthers</asp:ListItem>
                            <asp:ListItem>Penguins</asp:ListItem>
                            <asp:ListItem>Predators</asp:ListItem>
                            <asp:ListItem>Rangers</asp:ListItem>
                            <asp:ListItem>Red Wings</asp:ListItem>
                            <asp:ListItem>Sabres</asp:ListItem>
                            <asp:ListItem>Senators</asp:ListItem>
                            <asp:ListItem>Sharks</asp:ListItem>
                            <asp:ListItem>Stars</asp:ListItem>
                            <asp:ListItem>Wild</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                 <div class="row">
                      <div class="col-xs-12">
                          <div class="input-group" style="width:100%">
                              <span class="input-group-addon">Name:</span>
                              <asp:TextBox ID="tbName" runat="server" CssClass="form-control" ></asp:TextBox>
                          </div>
                      </div>
                 </div>
                 <div class="row">
                      <div class="col-xs-12">
                          <div class="input-group" style="width:100%">
                              <span class="input-group-addon">Username:</span>
                              <asp:TextBox ID="tbUser" runat="server" CssClass="form-control" MaxLength="30" ></asp:TextBox>
                          </div>
                      </div>
                  </div>
                 <div class="row">
                      <div class="col-xs-12">
                          <div class="input-group" style="width:100%">
                              <span class="input-group-addon">Password:</span>
                              <asp:TextBox ID="tbPass" runat="server" type="password" CssClass="form-control" MaxLength="18" ></asp:TextBox>
                          </div>
                      </div>
                  </div>
                 <div class="row">
                      <div class="col-xs-12">
                          <div class="input-group" style="width:100%">
                              <span class="input-group-addon">Confirm Password:</span>
                              <asp:TextBox ID="tbPass2" runat="server" type="password" CssClass="form-control" MaxLength="18" ></asp:TextBox>
                          </div>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-xs-12">
                          <div class="input-group" style="width:100%">
                              <span class="input-group-addon">Email:</span>
                              <asp:TextBox ID="tbEmail" runat="server" CssClass="form-control" ></asp:TextBox>
                          </div>
                      </div>
                  </div>
                  <div class='form-group'>
                      <div class="input-group" style="width:100%">
                        <span class="input-group-addon">Note:</span>
                        <asp:TextBox ID="tbNote" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-xs-12 text-center">
                          <asp:Button ID="btnTrial" runat="server" OnClick="btnTrial_Click" Text="Submit" class="btn btn-lg btn-primary"/>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-xs-12">
                          <asp:Label ID="lblMsg" runat="server" style="color:red;font-weight:bold"></asp:Label>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-xs-12">
                        <a href="/default.aspx" class="btn btn-lg btn-success" runat="server" id="btnReturn" visible="false">
                            <span class="glyphicon glyphicon-circle-arrow-left" aria-hidden="true"></span> Return
                        </a>
                       </div>
                  </div>
            </div>
        </div>
        </div>
    </div>
</asp:Content>