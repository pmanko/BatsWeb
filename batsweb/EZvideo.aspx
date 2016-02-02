﻿<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EZvideo.aspx.cbl" Inherits="batsweb.EZvideo" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Styles/ezvideo.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
    <script type="text/javascript" src="Scripts/ezvideo.js"></script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:Panel ID="Panel1" runat="server" GroupingText="Master Video List">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Start Date
                            </div>
                            <div class="panel-body">   
                                <asp:TextBox ID="TextBox1" runat="server" class="form-control"></asp:TextBox>
                                <cc1:MaskedEditExtender ID="TextBox1_MaskedEditExtender" runat="server" BehaviorID="TextBox1_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="TextBox1" />
                                <cc1:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox1_CalendarExtender" TargetControlID="TextBox1" />
                            </div>
                         </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                End Date
                            </div>
                            <div class="panel-body">   
                                <asp:TextBox ID="TextBox2" runat="server" class="form-control"></asp:TextBox>
                                <cc1:MaskedEditExtender ID="TextBox2_MaskedEditExtender" runat="server" BehaviorID="TextBox2_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="TextBox2" />
                                <cc1:CalendarExtender ID="TextBox2_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox2_CalendarExtender" TargetControlID="TextBox2" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <asp:Button ID="dateButton" runat="server" Text="Date One Clicks" CssClass="btn btn-default" />
                        <cc1:PopupControlExtender ID="dateButton_PopupControlExtender" runat="server" BehaviorID="dateButton_PopupControlExtender" DynamicServicePath="" ExtenderControlID="" PopupControlID="Panel3" TargetControlID="dateButton">
                        </cc1:PopupControlExtender>
                    </div>
                    <div class="col-lg-3">
                        <asp:Button ID="Button2" runat="server" Text="Go" OnClick="Button2_Click" CssClass="btn btn-primary" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <asp:Label ID="headerLabel" runat="server" Text="Date     Clip Description"  Font-Names="consolas" Font-Size="Medium" class="form-control" ></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <asp:ListBox ID="ListBox1" runat="server" Height="213px"  OnSelectedIndexChanged="ListBox1_SelectedIndexChanged" Font-Names="consolas" Font-Size="Medium" class="form-control"></asp:ListBox>
                        <asp:Table id="videoTable" runat="server" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                            data-index-field="#MainContent_videoIndexField" 
                            data-value-field="#MainContent_videoValueField" 
                            data-postback="false" 
                            data-multiple="true"
                            data-on-select="videoUpdate"
                            data-on-dblclick="openBatsTube"
                        >
                        <asp:TableHeaderRow TableSection="TableHeader">
                            <asp:TableHeaderCell>Date     Clip Description</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                                    
                        </asp:Table>
                        <asp:HiddenField ID="videoValueField" runat="server"  />
                        <asp:HiddenField ID="videoIndexField" runat="server"  />               
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Sort By:
                            </div>
                            <div class="panel-body">   
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:RadioButton ID="RadioButtonTeam" runat="server" Text="Team" AutoPostBack="True" OnCheckedChanged="RadioButtonTeam_CheckedChanged" GroupName="sort" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:RadioButton ID="RadioButtonName" runat="server" Text="Name" AutoPostBack="True" OnCheckedChanged="RadioButtonName_CheckedChanged" GroupName="sort" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:RadioButton ID="RadioButtonDate" runat="server" Text="Newest Date" AutoPostBack="True" OnCheckedChanged="RadioButtonDate_CheckedChanged" GroupName="sort" />
                                    </div>
                                </div>
                            </div>
                         </div>
                     </div>
                    <div class="col-lg-6">
                        <asp:Button ID="Button3" runat="server" Text="Play Video" CssClass="btn btn-primary" OnClick="Button3_Click" />
                        <a href="#" id="showVideosButton" class="btn btn-lg btn-primary btn-block">Show Videos in BatsTube</a>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="Panel3" runat="server" >
               <div class="panel panel-default">
                    <div class="panel-heading">
                        Dates
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button ID="allGamesButton" runat="server" OnClick="allGamesButton_Click" Text="All Games" Width="125px" class="btn btn-default"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button ID="currentYearButton" runat="server" OnClick="currentYearButton_Click" Text="Current Year" Width="125px" class="btn btn-default"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button ID="pastYearButton" runat="server" OnClick="pastYearButton_Click" Text="Past Year" Width="125px" class="btn btn-default"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button ID="twoWeeksButton" runat="server" OnClick="twoWeeksButton_Click" Text="Last 2 Weeks" Width="125px" class="btn btn-default"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button ID="currentMonthButton" runat="server" OnClick="currentMonthButton_Click" Text="Current Month" Width="125px" class="btn btn-default"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button ID="twoMonthsButton" runat="server" OnClick="twoMonthsButton_Click" Text="Last 2 Months" Width="125px" class="btn btn-default"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button ID="threeMonthsButton" runat="server" OnClick="threeMonthsButton_Click" Text="Last 3 Months" Width="125px" class="btn btn-default"/>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </form>
    </div>
</asp:Content>
