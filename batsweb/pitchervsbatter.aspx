<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="pitchervsbatter.aspx.cbl" Inherits="batsweb.pitchervsbatter" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Panel ID="Panel1" runat="server" GroupingText="Report Settings">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Pitcher
                            </div>
                            <div class="panel-body">
                                <label>Team:</label>
                                <asp:TextBox ID="pitcherTeamTextBox" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                <label>Player:</label>
                                <asp:TextBox ID="pitcherTextBox" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                <asp:Button ID="pitcherButton" runat="server" Text="Select Pitcher" CssClass="btn btn-default" />
                                <cc1:PopupControlExtender ID="pitcherButton_PopupExtender" runat="server" BehaviorID="pitcherButton_PopupControlExtender" DynamicServicePath="" ExtenderControlID="" PopupControlID="selectPitcher" TargetControlID="pitcherButton">
                                </cc1:PopupControlExtender>      
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Batter
                            </div>
                            <div class="panel-body">            
                                <label>Team:</label>
                                <asp:TextBox ID="batterTeamTextBox" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                <label>Player:</label>
                                <asp:TextBox ID="batterTextBox" runat="server" class="form-control" ReadOnly="True"></asp:TextBox>
                                <asp:Button ID="batterButton" runat="server" Text="Select Batter" class="btn btn-default"/>
                                <cc1:PopupControlExtender ID="batterButton_PopupControlExtender" runat="server" BehaviorID="batterButton_PopupControlExtender" DynamicServicePath="" ExtenderControlID="" PopupControlID="selectBatter" TargetControlID="batterButton">
                                </cc1:PopupControlExtender>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Date Range
                            </div>
                            <div class="list-group">
                                <div class="list-group-item">
                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTime" class="form-control"></asp:TextBox>
                                    <cc1:MaskedEditExtender ID="TextBox1_MaskedEditExtender" runat="server" BehaviorID="TextBox1_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="TextBox1" />
                                    <cc1:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox1_CalendarExtender" TargetControlID="TextBox1" />
                                    <asp:Button ID="goButton" runat="server" Text="Go" class="btn btn-default"/>
                                </div>
                           </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                At Bats (Double Click to View)
                            </div>
                            <div class="panel-body">
                                <asp:Label ID="headerLabel" runat="server" BorderStyle="Groove" Text=" Inn Batter         Out Rnrs  Res  RBI   Inn Batter         Out Rnrs  Res  RBI" Width="981px" Font-Bold="True" Font-Names="Consolas" Font-Size="Medium"></asp:Label>
                                <asp:ListBox ID="abListBox" runat="server"  Height="444px" Width="981px" Font-Bold="True" Font-Names="Consolas" Font-Size="Medium"></asp:ListBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <asp:Button ID="allButton" runat="server" Text="Play All" class="btn btn-default"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <asp:Button ID="selectedButton" runat="server" Text="Play Selected" class="btn btn-default"/>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="selectPitcher" runat="server" Height="400px" style="margin-left: 0px" Width="600px">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Pitcher Team
                                <asp:DropDownList ID="teamDropDownList" runat="server" AutoPostBack="True">
                                </asp:DropDownList> 
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <asp:Button ID="Button1" runat="server" Text="Button1" class="btn btn-default"/>
                                    <asp:Button ID="Button2" runat="server" Text="Button2" class="btn btn-default"/>
                                    <asp:Button ID="Button3" runat="server" Text="Button3" class="btn btn-default"/>
                                    <asp:Button ID="Button4" runat="server" Text="Button4" class="btn btn-default"/>
                                    <asp:Button ID="Button5" runat="server" Text="Button5" class="btn btn-default"/>
                                </div>
                                <div class="row">
                                    <asp:Button ID="Button6" runat="server" Text="Button6" class="btn btn-default"/>
                                    <asp:Button ID="Button7" runat="server" Text="Button7" class="btn btn-default"/>
                                    <asp:Button ID="Button8" runat="server" Text="Button8" class="btn btn-default"/>
                                    <asp:Button ID="Button9" runat="server" Text="Button9" class="btn btn-default"/>
                                    <asp:Button ID="Button10" runat="server" Text="Button10" class="btn btn-default"/>
                                </div>
                                <div class="row">
                                    <asp:Button ID="Button11" runat="server" Text="Button11" class="btn btn-default"/>
                                    <asp:Button ID="Button12" runat="server" Text="Button12" class="btn btn-default"/>
                                    <asp:Button ID="Button13" runat="server" Text="Button13" class="btn btn-default"/>
                                    <asp:Button ID="Button14" runat="server" Text="Button14" class="btn btn-default"/>
                                    <asp:Button ID="Button15" runat="server" Text="Button15" class="btn btn-default"/>
                                </div>
                                <div class="row">
                                    <asp:Button ID="Button16" runat="server" Text="Button16" class="btn btn-default"/>
                                    <asp:Button ID="Button17" runat="server" Text="Button17" class="btn btn-default"/>
                                    <asp:Button ID="Button18" runat="server" Text="Button18" class="btn btn-default"/>
                                    <asp:Button ID="Button19" runat="server" Text="Button19" class="btn btn-default"/>
                                    <asp:Button ID="Button20" runat="server" Text="Button20" class="btn btn-default"/>
                                </div>
                                <div class="row">
                                    <asp:Button ID="Button21" runat="server" Text="Button21" class="btn btn-default"/>
                                    <asp:Button ID="Button22" runat="server" Text="Button22" class="btn btn-default"/>
                                    <asp:Button ID="Button23" runat="server" Text="Button23" class="btn btn-default"/>
                                    <asp:Button ID="Button24" runat="server" Text="Button24" class="btn btn-default"/>
                                    <asp:Button ID="Button25" runat="server" Text="Button25" class="btn btn-default"/>
                                </div>
                                <div class="row">
                                    <asp:Button ID="Button26" runat="server" Text="Button26" class="btn btn-default"/>
                                    <asp:Button ID="Button27" runat="server" Text="Button27" class="btn btn-default"/>
                                    <asp:Button ID="Button28" runat="server" Text="Button28" class="btn btn-default"/>
                                    <asp:Button ID="Button29" runat="server" Text="Button29" class="btn btn-default"/>
                                    <asp:Button ID="Button30" runat="server" Text="Button30" class="btn btn-default"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="selectBatter" runat="server" Height="259px" style="margin-left: 0px" Width="263px" GroupingText="Choose Batter">
                <div class="row">
                </div>
            </asp:Panel>
    </form>
    </div>
</asp:Content>
