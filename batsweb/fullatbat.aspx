<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="fullatbat.aspx.cbl" Inherits="batsweb.fullatbat" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/fullatbat.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Panel ID="Panel6" runat="server" GroupingText="Report Settings">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Date Range
                            </div>
                            <div class="list-group">
                                <div class="list-group-item">
                                    <h4>Start Date</h4>
                                    <asp:RadioButton ID="allStartRadioButton" runat="server" GroupName="startDate" Text="All Games" OnCheckedChanged="allStartRadioButton_CheckedChanged" />
                                    <asp:RadioButton ID="startDateRadioButton" runat="server" GroupName="startDate" Text="Start Date:" OnCheckedChanged="startDateRadioButton_CheckedChanged" />
                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTime" class="form-control"></asp:TextBox>
                                    <cc1:MaskedEditExtender ID="TextBox1_MaskedEditExtender" runat="server" BehaviorID="TextBox1_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="TextBox1" />
                                    <cc1:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox1_CalendarExtender" TargetControlID="TextBox1" />
                                </div>
                                <div class="list-group-item">
                                    <h4>End Date</h4>
                                    <asp:RadioButton ID="allEndRadioButton" runat="server" GroupName="endDate" Text="All Games" OnCheckedChanged="allEndRadioButton_CheckedChanged" />
                                    <asp:RadioButton ID="endDateRadioButton" runat="server" GroupName="endDate" Text="End Date:" OnCheckedChanged="endDateRadioButton_CheckedChanged" />
                                    <asp:TextBox ID="TextBox4" runat="server" class="form-control"></asp:TextBox>
                                    <cc1:MaskedEditExtender ID="TextBox4_MaskedEditExtender" runat="server" BehaviorID="TextBox4_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="TextBox4" />
                                    <cc1:CalendarExtender ID="TextBox4_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox4_CalendarExtender" DefaultView="Days" PopupPosition="BottomLeft" TargetControlID="TextBox4" />
                                    <asp:Button ID="dateButton" runat="server" Text="Date One-Clicks" CssClass="btn btn-default btn-sm" />
                                    <cc1:PopupControlExtender ID="dateButton_PopupControlExtender" runat="server" BehaviorID="dateButton_PopupControlExtender" DynamicServicePath="" ExtenderControlID="" PopupControlID="Panel12" TargetControlID="dateButton">
                                    </cc1:PopupControlExtender>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Current Pitcher
                            </div>
                            <div class="panel-body">
                                
                                <asp:TextBox ID="pitcherTextBox" runat="server" style="text-align: left" class="form-control"></asp:TextBox>
                                <asp:Button ID="pitcherButton" runat="server" Text="Select Pitcher" OnClick="Button1_Click" CssClass="btn btn-default" />
                                <cc1:ModalPopupExtender ID="pitcherButton_ModalPopupExtender" runat="server" BehaviorID="pitcherButton_ModalPopupExtender" DynamicServicePath="" PopupControlID="selectPitcher" TargetControlID="pitcherButton" X="0" Y="0"></cc1:ModalPopupExtender>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Current Batter
                            </div>

                            <div class="panel-body">            
                                <div class="input-group">
                                    <asp:TextBox ID="batterTextBox" runat="server" class="form-control"></asp:TextBox>

                                    <asp:Button ID="batterButton" runat="server" Text="Select Batter" class="btn btn-default"/>
                                    <cc1:PopupControlExtender ID="batterButton_PopupControlExtender" runat="server" BehaviorID="batterButton_PopupControlExtender" DynamicServicePath="" ExtenderControlID="" PopupControlID="selectBatter" TargetControlID="batterButton">
                                    </cc1:PopupControlExtender>
                                </div>                
                            </div>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-lg-3">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="input-group">
                                    <asp:CheckBox ID="maxAtBatsCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="maxAtBatsCheckBox_CheckedChanged" Text="Maximum At Bats:" />
                                    <asp:TextBox ID="maxABTextBox" runat="server" class="form-control" MaxLength="3"></asp:TextBox>
                                    <cc1:MaskedEditExtender ID="maxABTextBox_MaskedEditExtender" runat="server" AutoComplete="False" BehaviorID="maxABTextBox_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="999" MaskType="Number" PromptCharacter=" " TargetControlID="maxABTextBox" />

                                    <asp:CheckBox ID="sortByInningCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="sortByInningCheckBox_CheckedChanged" Text="Sort At Bats by Inning" />
                                    <asp:CheckBox ID="sortByBatterCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="sortByBatterCheckBox_CheckedChanged" Text="Sort At Bats by Batter" />
                                    <asp:CheckBox ID="sortByOldCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="sortByOldCheckBox_CheckedChanged" Text="Sort At Bats Oldest - Newest" />
                                </div>
                            </div>
                            
                        </div>

                    </div>
                    <div class="col-lg-9">
                        <div class="row">
                            <div class="col-lg-4">
                                <label>Result1:</label>
                                <asp:DropDownList ID="Result1" runat="server" OnSelectedIndexChanged="Result1_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                    <asp:ListItem>ALL</asp:ListItem>
                                    <asp:ListItem>HIT</asp:ListItem>
                                    <asp:ListItem>EXTRA</asp:ListItem>
                                    <asp:ListItem>HR</asp:ListItem>
                                    <asp:ListItem>OUT</asp:ListItem>
                                    <asp:ListItem>FLY</asp:ListItem>
                                    <asp:ListItem>POP UP</asp:ListItem>
                                    <asp:ListItem>GB</asp:ListItem>
                                    <asp:ListItem>BUNT</asp:ListItem>
                                    <asp:ListItem>LD</asp:ListItem>
                                    <asp:ListItem>KO</asp:ListItem>
                                    <asp:ListItem>HARD</asp:ListItem>
                                    <asp:ListItem>MEDIUM</asp:ListItem>
                                    <asp:ListItem>SOFT</asp:ListItem>
                                    <asp:ListItem>DP</asp:ListItem>
                                    <asp:ListItem>SINGLE</asp:ListItem>
                                    <asp:ListItem>DOUBLE</asp:ListItem>
                                    <asp:ListItem>TRIPLE</asp:ListItem>
                                    <asp:ListItem>RBI</asp:ListItem>
                                    <asp:ListItem>SAC</asp:ListItem>
                                    <asp:ListItem>NO IBB</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-4">
                                <label>Runners:</label>
                                <asp:DropDownList ID="Runners" runat="server" OnSelectedIndexChanged="Runners_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-4">
                                <label>Inn:</label>
                                <asp:DropDownList ID="Innings" runat="server" OnSelectedIndexChanged="Innings_SelectedIndexChanged" AutoPostBack="True" class="form-control"> 
                                </asp:DropDownList>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-4">
                                <label>Result2:</label>
                                <asp:DropDownList ID="Result2" runat="server" OnSelectedIndexChanged="Result2_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                    <asp:ListItem>ALL</asp:ListItem>
                                    <asp:ListItem>HIT</asp:ListItem>
                                    <asp:ListItem>EXTRA</asp:ListItem>
                                    <asp:ListItem>HR</asp:ListItem>
                                    <asp:ListItem>OUT</asp:ListItem>
                                    <asp:ListItem>FLY</asp:ListItem>
                                    <asp:ListItem>POP UP</asp:ListItem>
                                    <asp:ListItem>GB</asp:ListItem>
                                    <asp:ListItem>BUNT</asp:ListItem>
                                    <asp:ListItem>LD</asp:ListItem>
                                    <asp:ListItem>KO</asp:ListItem>
                                    <asp:ListItem>HARD</asp:ListItem>
                                    <asp:ListItem>MEDIUM</asp:ListItem>
                                    <asp:ListItem>SOFT</asp:ListItem>
                                    <asp:ListItem>DP</asp:ListItem>
                                    <asp:ListItem>SINGLE</asp:ListItem>
                                    <asp:ListItem>DOUBLE</asp:ListItem>
                                    <asp:ListItem>TRIPLE</asp:ListItem>
                                    <asp:ListItem>RBI</asp:ListItem>
                                    <asp:ListItem>SAC</asp:ListItem>
                                    <asp:ListItem>NO IBB</asp:ListItem>
                                </asp:DropDownList>

                            </div>
                            <div class="col-lg-4">
                                <label>Outs:</label>
                                <asp:DropDownList ID="Outs" runat="server" OnSelectedIndexChanged="Outs_SelectedIndexChanged" AutoPostBack="True" class="form-control">
                                </asp:DropDownList>                            </div>
                            <div class="col-lg-2">
                            
                                <%--<asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>--%>
                                <asp:Button ID="Button5" runat="server" Text="Show At Bats" OnClick="Button5_Click" CssClass="btn btn-primary" />
                            </div>
                            <div class="col-lg-2">
                                <%--<asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>--%>
                                <asp:Button ID="resetButton" runat="server" Text="Reset" OnClick="resetButton_Click" CssClass="btn btn-danger"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                List of At-Bats
                            </div>
                            <div class="panel-body">
                                <asp:ListBox ID="ListBox1" runat="server" Height="444px" Width="923px" AutoPostBack="True" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged" class="form-control"></asp:ListBox>
                                <asp:BulletedList ID="BulletedList2" runat="server" CssClass="list-group"></asp:BulletedList>

                                <asp:HiddenField ID="vid_paths" runat="server" />
                                <asp:HiddenField ID="vid_titles" runat="server" />
                                <button id="show_videos" class="btn btn-lg btn-primary">Show Videos in BatsTube</button>

                            </div>
                        </div>
                    </div>

                    
                </div>
            </asp:Panel>


            <asp:Panel ID="Panel12" runat="server" BackColor="#CCCCCC" GroupingText="Dates" Height="240px" style="text-align: left; margin-right: 1px" Width="173px">
            <table align="center" style="height: 205px; width: 125px;">
                <tr>
                    <td align="center" class="auto-style120">
                        <asp:Button ID="allGamesButton" runat="server" OnClick="allGamesButton_Click" Text="All Games" width="125px" />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style121">
                        <asp:Button ID="currentYearButton" runat="server" OnClick="currentYearButton_Click" Text="Current Year" width="125px" />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style120">
                        <asp:Button ID="pastYearButton" runat="server" OnClick="pastYearButton_Click" Text="Past Year" width="125px" />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style120">
                        <asp:Button ID="twoWeeksButton" runat="server" OnClick="twoWeeksButton_Click" Text="Last 2 Weeks" width="125px" />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style120">
                        <asp:Button ID="currentMonthButton" runat="server" OnClick="currentMonthButton_Click" Text="Current Month" width="125px" />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style120">
                        <asp:Button ID="twoMonthsButton" runat="server" OnClick="twoMonthsButton_Click" Text="Last 2 Months" width="125px" />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style120">
                        <asp:Button ID="threeMonthsButton" runat="server" OnClick="threeMonthsButton_Click" Text="Last 3 Months" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="SelectPitcher" runat="server" BackColor="Silver" Height="259px" style="margin-left: 0px" Width="263px" GroupingText="Select Pitcher">
            <table style="height: 159px; width: 261px">
                <tr>
                    <td align="center" colspan="3">
                        <asp:TextBox ID="pCurrentSelection" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="pAllLeftButton" runat="server" OnClick="pAllLeftButton_Click" Text="All Left" />
                    </td>
                    <td align="center">
                        <asp:Button ID="pAllButton" runat="server" OnClick="pAllButton_Click" Text="All" />
                    </td>
                    <td align="center">
                        <asp:Button ID="pAllRightButton" runat="server" OnClick="pAllRightButton_Click" Text="All Right" />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style112">
                        <asp:Button ID="pTeamLeftButton" runat="server" Text="Team Left" OnClick="pTeamLeftButton_Click" />
                    </td>
                    <td align="center" class="auto-style112">
                        <asp:Button ID="pTeamButton" runat="server" Text="Team" OnClick="pTeamButton_Click" />
                    </td>
                    <td align="center" class="auto-style112">
                        <asp:Button ID="pTeamRightButton" runat="server" Text="Team Right" OnClick="pTeamRightButton_Click" />
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="3">
                        <asp:Button ID="pPlayerButton" runat="server" Text="Select Player" OnClick="pPlayerButton_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Panel ID="Panel11" runat="server" GroupingText="Pitcher options">
                            <table style="height: 69px; width: 210px">
                                <tr>
                                    <td class="auto-style122">
                                        <asp:TextBox ID="TextBox5" runat="server" Height="16px" Width="18px"></asp:TextBox>
                                    </td>
                                    <td class="auto-style123">
                                        <asp:RadioButton ID="RadioButton1" runat="server" Text="Any Type" />
                                    </td>
                                    <td class="auto-style124">
                                        <asp:RadioButton ID="RadioButton3" runat="server" Text="Custom" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style118">&nbsp;</td>
                                    <td class="auto-style114">
                                        <asp:RadioButton ID="RadioButton2" runat="server" Text="Power" />
                                    </td>
                                    <td class="auto-style115">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style118">&nbsp;</td>
                                    <td class="auto-style114">
                                        <asp:RadioButton ID="RadioButton4" runat="server" Text="Single" />
                                    </td>
                                    <td class="auto-style115">&nbsp;</td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="3">
                        <asp:Button ID="pitcherOKButton" runat="server" Text="OK" />
                        <cc1:ModalPopupExtender ID="pitcherOKButton_ModalPopupExtender" runat="server" BehaviorID="pitcherOKButton_ModalPopupExtender" DynamicServicePath="" PopupControlID="playerPanel" TargetControlID="pitcherOKButton" X="25" Y="25">
                        </cc1:ModalPopupExtender>
                        <asp:HiddenField ID="pHiddenField" runat="server" />
                        <cc1:ModalPopupExtender ID="pHiddenFieldTeam_ModalPopupExtender" runat="server" BehaviorID="pHiddenFieldTeam_ModalPopupExtender" DynamicServicePath="" PopupControlID="pTeamPanel" TargetControlID="pHiddenField" X="2" Y="2">
                        </cc1:ModalPopupExtender>
                    </td>
                </tr>
            </table>
        </asp:Panel>
            <br />
            <asp:Panel ID="playerPanel" runat="server" BackColor="Silver" Height="275px" Width="292px">
                <table style="height: 178px; width: 279px">
                    <tr>
                        <td class="auto-style126">Team:</td>
                        <td class="auto-style127">
                            <asp:DropDownList ID="teamDropDownList" runat="server" OnSelectedIndexChanged="teamDropDownList_SelectedIndexChanged" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style154" colspan="2">
                            <asp:ListBox ID="playerListBox" runat="server" Height="114px" OnSelectedIndexChanged="playerListBox_SelectedIndexChanged" Width="267px" AutoPostBack="True"></asp:ListBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style125" colspan="2">
                            <asp:Button ID="playerOKButton" runat="server" OnClick="playerOKButton_Click" Text="OK" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        <asp:Panel ID="selectBatter" runat="server" BackColor="Silver" Height="281px" Width="320px" GroupingText="Select Batter">
            <table style="height: 277px; width: 321px">
                <tr>
                    <td align="center" class="auto-style133" colspan="3">
                        <asp:TextBox ID="bCurrentSelection" runat="server" Height="16px" ReadOnly="True" style="margin-left: 0px" Width="139px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style133">
                        <asp:Button ID="bAllLeftButton" runat="server" OnClick="bAllLeftButton_Click" Text="All Left" />
                    </td>
                    <td align="center" class="auto-style133">
                        <asp:Button ID="bAllButton" runat="server" OnClick="bAllButton_Click" Text="All" />
                    </td>
                    <td align="center" class="auto-style137">
                        <asp:Button ID="bAllRightButton" runat="server" OnClick="bAllRightButton_Click" Text="All Right" />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style138">
                        <asp:Button ID="bTeamLeftButton" runat="server" Text="Team Left" OnClick="bTeamLeftButton_Click" />
                    </td>
                    <td align="center" class="auto-style138">
                        <asp:Button ID="bTeamButton" runat="server" Text="Team" OnClick="bTeamButton_Click" />
                    </td>
                    <td align="center" class="auto-style147">
                        <asp:Button ID="bTeamRightButton" runat="server" Text="Team Right" OnClick="bTeamRightButton_Click" />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style155"></td>
                    <td align="center" class="auto-style155">
                        <asp:Button ID="bPlayerButton" runat="server" Text="Select Player" OnClick="bPlayerButton_Click" />
                    </td>
                    <td align="center" class="auto-style148">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style140" align="left" colspan="3">
                        <asp:Panel ID="Panel14" runat="server" GroupingText="Batter Options" Height="102px" Width="314px">
                            <table style="height: 85px; width: 248px">
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="TextBox6" runat="server" Height="16px" Width="23px"></asp:TextBox>
                                    </td>
                                    <td align="left" class="auto-style142">
                                        <asp:RadioButton ID="RadioButton" runat="server" Text="Any Type" />
                                    </td>
                                    <td align="left">
                                        <asp:RadioButton ID="RadioButton5" runat="server" Text="Custom" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" class="auto-style143"></td>
                                    <td align="left" class="auto-style144">
                                        <asp:RadioButton ID="RadioButton6" runat="server" Text="Power" />
                                    </td>
                                    <td align="left" class="auto-style143">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td align="left">&nbsp;</td>
                                    <td align="left" class="auto-style142">
                                        <asp:RadioButton ID="RadioButton7" runat="server" Text="Single" />
                                    </td>
                                    <td align="left">&nbsp;</td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style132" colspan="3">
                        <asp:Button ID="batterOKButton" runat="server" Text="OK" />
                        <asp:HiddenField ID="bHiddenField" runat="server" />
                        <cc1:ModalPopupExtender ID="bHiddenFieldTeam_ModalPopupExtender" runat="server" BehaviorID="bHiddenFieldTeam_ModalPopupExtender" DynamicServicePath="" PopupControlID="bTeamPanel" TargetControlID="bHiddenField" X="50" Y="50">
                        </cc1:ModalPopupExtender>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <asp:Panel ID="pTeamPanel" runat="server" BackColor="Silver" Height="110px" Width="180px" GroupingText="Which pitcher team?">
            <table style="height: 84px; width: 160px">
                <tr>
                    <td align="center" class="auto-style152">
                        <asp:DropDownList ID="pTeamDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="pTeamDropDownList_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style153"></td>
                </tr>
                <tr>
                    <td align="center" class="auto-style149">
                        <asp:Button ID="pTeamOKButton" runat="server" Text="OK" OnClick="pTeamOKButton_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="bTeamPanel" runat="server" BackColor="Silver" GroupingText="Which batter team?" Height="112px" Width="149px">
            <table>
                <tr>
                    <td align="center" class="auto-style158">
                        <asp:DropDownList ID="bTeamDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="bTeamDropDownList_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="auto-style157"></td>
                </tr>
                <tr>
                    <td align="center" class="auto-style158">
                        <asp:Button ID="bTeamOKButton" runat="server" OnClick="bTeamOKButton_Click" Text="OK" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        </form>
    </div>
</asp:Content>


                    







