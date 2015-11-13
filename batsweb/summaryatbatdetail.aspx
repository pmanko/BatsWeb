﻿<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="summaryatbatdetail.aspx.cbl" Inherits="batsweb.atbatdetail" %>
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
                            <div class="row">
                            <div class="col-lg-1">
                                <label>Pitcher:</label>
                            </div>
                            <div class="col-lg-2">
                                <asp:TextBox ID="pitcherTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-lg-1">
                                <label>Batter:</label>
                            </div>
                            <div class="col-lg-2">
                                <asp:TextBox ID="batterTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-4">
                                    <asp:ImageButton ID="szoneImageButton" runat="server" OnClick="szoneImageButton_Click" src="gamesummaryszone.aspx" alt="image could not be displayed refresh"/>
                                </div>
                                <div class="col-lg-4">
                                    <div class="row">
                                        <asp:Label ID="headerLabel" runat="server" BorderStyle="Groove" Text="## Type Location K Vel * Vid" Font-Bold="True" Font-Names="Consolas" Font-Size="Medium" class="form-control"></asp:Label>
                                    </div>
                                    <div class="row">
                                        <asp:ListBox ID="ListBox1" runat="server" Height="160px" Font-Bold="True" Font-Names="Consolas" Font-Size="Medium" class="form-control"></asp:ListBox>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <asp:Image ID="runnersImage" runat="server" src="summaryrunners.aspx" alt="image could not be displayed refresh"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <asp:Label ID="Label1" runat="server" Text="Outs:" style="text-align: right;" ReadOnly="true" Width="100px"></asp:Label>
                                        </div>
                                        <div class="col-lg-1">
                                            <asp:Label ID="outsLabel" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <asp:Label ID="Label2" runat="server" Text="Hit Type:" style="text-align: right;" ReadOnly="true"></asp:Label>
                                        </div>
                                        <div class="col-lg-5">
                                            <asp:Label ID="hitLabel" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <label>Result:</label>
                                        </div>
                                        <div class="col-lg-5">
                                            <asp:Label ID="resultLabel" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <label>Final Count:</label>
                                        </div>
                                        <div class="col-lg-5">
                                            <asp:Label ID="countLabel" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <label>Fielded By(1):</label>
                                        </div>
                                        <div class="col-lg-3">
                                            <asp:Label ID="posLabel1" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                        <div class="col-lg-4">
                                            <asp:Label ID="fieldedLabel1" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                        <div class="col-lg-2">
                                            <asp:Label ID="flagLabel1" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <label>Fielded By(2):</label>
                                        </div>
                                        <div class="col-lg-3">
                                            <asp:Label ID="posLabel2" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                        <div class="col-lg-4">
                                            <asp:Label ID="fieldedLabel2" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                        <div class="col-lg-2">
                                            <asp:Label ID="flagLabel2" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <label>RBI:</label>
                                        </div>
                                        <div class="col-lg-1">
                                            <asp:Label ID="rbiLabel" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <label>Catcher:</label>
                                        </div>
                                        <div class="col-lg-3">
                                            <asp:Label ID="catcherLabel" runat="server" class="form-control" ReadOnly="true"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
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
