<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="breakdown.aspx.cbl" Inherits="batsweb.breakdown" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Panel ID="selectionPanel" runat="server" GroupingText="Report Settings">
                <div class="row">
                    <div class="col-lg-10">
                        <div class="panel panel-default">
                            <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Pitcher:</label>
                                    <asp:TextBox ID="pitcherTextBox" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                </div>
                                <div class="col-lg-6">
                                    <label>Pitcher:</label>
                                    <asp:TextBox ID="batterTextBox" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <label>Games:</label>
                                    <asp:TextBox ID="TextBox1" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                </div>
                                <div class="col-lg-6">
                                    <label>Location:</label>
                                    <asp:TextBox ID="TextBox2" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="selectionButton" runat="server" Text="Change Selection" class="btn btn-lg btn-primary"/>
                    </div>
                </div>
            </asp:Panel>
        </form>
    </div>
</asp:Content>