<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="summaryatbatdetail.aspx.cbl" Inherits="batsweb.atbatdetail" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Panel ID="Panel6" runat="server" >
                <div class="row">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="col-lg-3">
                                <label>Date:</label>
                                <asp:TextBox ID="dateTextBox" runat="server" TextMode="DateTime" class="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <asp:TextBox ID="visTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:TextBox ID="visScoreTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                <label>at</label>
                                <asp:TextBox ID="homeTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:TextBox ID="homeScoreTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <label>Inning:</label>
                                <asp:TextBox ID="inningTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-lg-3">
                                <label>Current Batting:</label>
                                <asp:TextBox ID="battingTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="col-lg-6">
                                <label>Pitcher:</label>
                                <asp:TextBox ID="pitcherTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-lg-6">
                                <label>Batter:</label>
                                <asp:TextBox ID="batterTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="col-lg-4">
                                <asp:ImageButton ID="szoneImageButton" runat="server" OnClick="szoneImageButton_Click" src="gamesummaryszone.aspx" alt="image could not be displayed refresh"/>
                            </div>
                            <div class="col-lg-4">
                                <div class="row">
                                <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Text="## Type Location K Vel * Vid" Font-Bold="True" Font-Names="Consolas" Font-Size="Medium" class="form-control"></asp:Label>
                                </div>
                                <div class="row">
                                <asp:ListBox ID="ListBox1" runat="server" Height="160px" Font-Bold="True" Font-Names="Consolas" Font-Size="Medium" class="form-control"></asp:ListBox>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="row">
                                    <asp:Image ID="runnersImage" runat="server" src="summaryrunners.aspx" alt="image could not be displayed refresh"/>
                                </div>
                                <div class="row">
                                    <asp:Image ID="parkImage" runat="server" src="summarypark.aspx" alt="image could not be displayed refresh"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </form>
    </div>
</asp:Content>
