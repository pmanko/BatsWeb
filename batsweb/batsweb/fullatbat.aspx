<%@ Page AutoEventWireup="true" CodeBehind="fullatbat.aspx.cbl" Inherits="batsweb.fullatbat" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
            height: 122px;
            margin-right: 0px;
        }
        .auto-style19 {
            width: 523px;
            height: 34px;
        }
        .auto-style21 {
            width: 267px;
            height: 27px;
        }
        .auto-style24 {
        }
        .auto-style29 {
            width: 274px;
            height: 94px;
        }
        .auto-style30 {
            height: 25px;
            width: 100px;
        }
        .auto-style31 {
            width: 100px;
        }
        .auto-style32 {
            height: 26px;
        }
        .auto-style34 {
            height: 26px;
            width: 92px;
        }
        .auto-style37 {
            width: 274px;
            height: 102px;
        }
        .auto-style40 {
            height: 25px;
            width: 94px;
        }
        .auto-style41 {
            width: 94px;
        }
        .auto-style46 {
            width: 523px;
            height: 59px;
        }
        .auto-style49 {
            width: 613px;
            height: 59px;
        }
        .auto-style50 {
            width: 613px;
            height: 34px;
        }
        .auto-style52 {
            width: 84px;
            height: 59px;
        }
        .auto-style53 {
            width: 84px;
            height: 34px;
        }
        .auto-style58 {
            width: 283px;
            height: 59px;
        }
        .auto-style59 {
            width: 283px;
            height: 34px;
        }
        .auto-style61 {
            width: 309px;
            height: 59px;
        }
        .auto-style62 {
            width: 309px;
            height: 34px;
        }
        .auto-style65 {
            width: 61px;
            height: 59px;
        }
        .auto-style66 {
            width: 61px;
            height: 34px;
        }
        .auto-style68 {
            width: 406px;
            height: 59px;
        }
        .auto-style69 {
            width: 406px;
            height: 34px;
        }
        .auto-style75 {
            height: 149px;
        }
        .auto-style76 {
            width: 238px;
            height: 14px;
        }
        .auto-style77 {
            width: 267px;
            height: 74px;
        }
        .auto-style102 {
            height: 97px;
        }
        .auto-style103 {
            height: 97px;
        }
        .auto-style104 {
            width: 922px;
        }
        .auto-style106 {
            width: 922px;
            height: 451px;
        }
        #form1 {
            height: 1035px;
            width: 973px;
        }
        .auto-style109 {
            height: 26px;
            width: 159px;
        }
        .auto-style110 {
            width: 238px;
        }
        .auto-style112 {
            height: 34px;
        }
        .auto-style114 {
            width: 105px;
        }
        .auto-style115 {
            width: 87px;
        }
        .auto-style118 {
            width: 27px;
        }
        .auto-style120 {
            width: 93px;
        }
        .auto-style121 {
            width: 93px;
            height: 30px;
        }
        .auto-style122 {
            width: 27px;
            height: 26px;
        }
        .auto-style123 {
            width: 105px;
            height: 26px;
        }
        .auto-style124 {
            width: 87px;
            height: 26px;
        }
        .auto-style125 {
            height: 110px;
        }
        .auto-style126 {
            height: 31px;
        }
        .auto-style127 {
            height: 31px;
            width: 148px;
        }
        .auto-style132 {
            height: 23px;
        }
        .auto-style133 {
            height: 35px;
        }
        .auto-style137 {
            height: 35px;
            width: 112px;
        }
        .auto-style138 {
            width: 91px;
            height: 34px;
        }
        .auto-style140 {
            height: 47px;
        }
        .auto-style142 {
            width: 110px;
        }
        .auto-style143 {
            height: 29px;
        }
        .auto-style144 {
            width: 110px;
            height: 29px;
        }
        .auto-style147 {
            width: 112px;
            height: 34px;
        }
        .auto-style148 {
            width: 112px;
            }
        .auto-style149 {
            width: 4px;
        }
        .auto-style152 {
            width: 4px;
            height: 3px;
        }
        .auto-style153 {
            width: 4px;
            height: 20px;
        }
        .auto-style154 {
            height: 87px;
        }
        .auto-style155 {
            width: 91px;
        }
        .auto-style157 {
            width: 131px;
            height: 23px;
        }
        .auto-style158 {
            width: 131px;
        }
    </style>
</head>
<body>

        <div id="header">
        <img src="sydex.png" style="width: 70px; height: 70px; float: left"/>Welcome to BATS! on the Web<img src="sydex.png" style="width: 70px; height: 70px; float: right"/>
    </div>


    <h1>Game Summary</h1>

    <div id="main">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:Panel ID="Panel6" runat="server" GroupingText="Report Settings" Height="948px" style="margin-bottom: 0px" Width="970px">
            <table style="height: 381px; width: 943px" title="Report Settings">
                <tr>
                    <td class="auto-style24" rowspan="3" valign="top">
                        <table style="width: 265px">
                            <tr>
                                <td class="auto-style29">
                                    <asp:Panel ID="Panel1" runat="server" GroupingText="Start Date" Height="90px" style="margin-left: 0px; margin-right: 0px; margin-top: 0px" Width="278px">
                                        <table style="width: 260px">
                                            <tr>
                                                <td class="auto-style30">
                                                    <asp:RadioButton ID="allStartRadioButton" runat="server" GroupName="startDate" Text="All Games" OnCheckedChanged="allStartRadioButton_CheckedChanged" />
                                                </td>
                                                <td class="auto-style40"></td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style31">
                                                    <asp:RadioButton ID="startDateRadioButton" runat="server" GroupName="startDate" Text="Start Date:" OnCheckedChanged="startDateRadioButton_CheckedChanged" />
                                                </td>
                                                <td class="auto-style41">
                                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTime" Width="111px"></asp:TextBox>
                                                    <cc1:MaskedEditExtender ID="TextBox1_MaskedEditExtender" runat="server" BehaviorID="TextBox1_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="TextBox1" />
                                                    <cc1:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox1_CalendarExtender" TargetControlID="TextBox1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style37" valign="top">
                                    <asp:Panel ID="Panel7" runat="server" GroupingText="End Date" Height="41px" HorizontalAlign="Center" width="278px">
                                        <table style="width: 261px">
                                            <tr>
                                                <td class="auto-style34">
                                                    <asp:RadioButton ID="allEndRadioButton" runat="server" GroupName="endDate" Text="All Games" OnCheckedChanged="allEndRadioButton_CheckedChanged" />
                                                </td>
                                                <td class="auto-style109"></td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style34">
                                                    <asp:RadioButton ID="endDateRadioButton" runat="server" GroupName="endDate" Text="End Date:" OnCheckedChanged="endDateRadioButton_CheckedChanged" />
                                                </td>
                                                <td class="auto-style109">
                                                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                                                    <cc1:MaskedEditExtender ID="TextBox4_MaskedEditExtender" runat="server" BehaviorID="TextBox4_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="TextBox4" />
                                                    <cc1:CalendarExtender ID="TextBox4_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox4_CalendarExtender" DefaultView="Days" PopupPosition="BottomLeft" TargetControlID="TextBox4" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style32" colspan="2">
                                                    <asp:Button ID="dateButton" runat="server" Height="26px" Text="Date One-Clicks" />
                                                    <cc1:PopupControlExtender ID="dateButton_PopupControlExtender" runat="server" BehaviorID="dateButton_PopupControlExtender" DynamicServicePath="" ExtenderControlID="" PopupControlID="Panel12" TargetControlID="dateButton">
                                                    </cc1:PopupControlExtender>
                                                    &nbsp;</td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <br />
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="auto-style75" colspan="4" valign="top">
                        <asp:Panel ID="Panel2" runat="server" GroupingText="Pitcher" height="148px" HorizontalAlign="Center" style="margin-right: 0px; margin-left: 6px;" Width="277px">
                            <table class="auto-style1">
                                <tr>
                                    <td class="auto-style76">
                                        <asp:Panel ID="Panel3" runat="server" GroupingText="Current Pitcher Selection" HorizontalAlign="Center" style="font-size: small" height="41px" Width="267px">
                                            <asp:TextBox ID="pitcherTextBox" runat="server" style="text-align: left"></asp:TextBox>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style110">
                                        <asp:Button ID="pitcherButton" runat="server" Text="Select Pitcher" OnClick="Button1_Click" />
                                        <cc1:ModalPopupExtender ID="pitcherButton_ModalPopupExtender" runat="server" BehaviorID="pitcherButton_ModalPopupExtender" DynamicServicePath="" PopupControlID="selectPitcher" TargetControlID="pitcherButton" X="0" Y="0">
                                        </cc1:ModalPopupExtender>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                    <td class="auto-style75" colspan="3" valign="top">
                        <asp:Panel ID="Panel4" runat="server" GroupingText="Batter" height="145px" HorizontalAlign="Center" width="277px">
                            <table>
                                <tr>
                                    <td class="auto-style21">
                                        <asp:Panel ID="Panel5" runat="server" GroupingText="Current Batter Selection" style="font-size: small">
                                            <asp:TextBox ID="batterTextBox" runat="server"></asp:TextBox>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style77">
                                        <asp:Button ID="batterButton" runat="server" Text="Select Batter" />
                                        <cc1:PopupControlExtender ID="batterButton_PopupControlExtender" runat="server" BehaviorID="batterButton_PopupControlExtender" DynamicServicePath="" ExtenderControlID="" PopupControlID="selectBatter" TargetControlID="batterButton">
                                        </cc1:PopupControlExtender>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="auto-style52">Result1:</td>
                    <td class="auto-style65">
                        <asp:DropDownList ID="Result1" runat="server" OnSelectedIndexChanged="Result1_SelectedIndexChanged" AutoPostBack="True">
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
                    </td>
                    <td align="right" class="auto-style58">Runners:</td>
                    <td class="auto-style61">
                        <asp:DropDownList ID="Runners" runat="server" OnSelectedIndexChanged="Runners_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                    <td align="right" class="auto-style68">Inn:</td>
                    <td class="auto-style46">
                        <asp:DropDownList ID="Innings" runat="server" OnSelectedIndexChanged="Innings_SelectedIndexChanged" AutoPostBack="True"> 
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style49">
                        <asp:Button ID="resetButton" runat="server" Text="Reset" OnClick="resetButton_Click" />
                    </td>
                </tr>
                <tr>
                    <td align="right" class="auto-style53">Result2:</td>
                    <td class="auto-style66">
                        <asp:TextBox ID="maxABTextBox" runat="server" style="z-index: 1; left: 206px; top: 415px; position: absolute; width: 51px" MaxLength="3"></asp:TextBox>
                        <cc1:MaskedEditExtender ID="maxABTextBox_MaskedEditExtender" runat="server" AutoComplete="False" BehaviorID="maxABTextBox_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="999" MaskType="Number" PromptCharacter=" " TargetControlID="maxABTextBox" />
                        <asp:DropDownList ID="Result2" runat="server" Height="16px" OnSelectedIndexChanged="Result2_SelectedIndexChanged" AutoPostBack="True">
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
                    </td>
                    <td align="right" class="auto-style59">Outs:</td>
                    <td class="auto-style62">
                        <asp:DropDownList ID="Outs" runat="server" OnSelectedIndexChanged="Outs_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style69">&nbsp;</td>
                    <td class="auto-style19"></td>
                    <td class="auto-style50"></td>
                </tr>
                <tr>
                    <td class="auto-style103" valign="top">
                        <asp:CheckBox ID="maxAtBatsCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="maxAtBatsCheckBox_CheckedChanged" Text="Maximum At Bats:" />
                        <br />
                        <asp:CheckBox ID="sortByInningCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="sortByInningCheckBox_CheckedChanged" Text="Sort At Bats by Inning" />
                        <br />
                        <asp:CheckBox ID="sortByBatterCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="sortByBatterCheckBox_CheckedChanged" Text="Sort At Bats by Batter" />
                        <br />
                        <asp:CheckBox ID="sortByOldCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="sortByOldCheckBox_CheckedChanged" Text="Sort At Bats Oldest - Newest" />
                    </td>
                    <td class="auto-style102" colspan="7">
                        <asp:Button ID="Button5" runat="server" style="z-index: 1; left: 814px; top: 447px; position: absolute" Text="Show At Bats" OnClick="Button5_Click" />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style24" colspan="8">
                        <asp:Panel ID="Panel8" runat="server" GroupingText="List of At Bats">
                            <table>
                                <tr>
                                    <td align="center" class="auto-style104"><strong>Double-click an at bat to show its detail</strong></td>
                                </tr>
                                <tr>
                                    <td class="auto-style104">
                                        <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Text="Label" Width="910px"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style106">
                                        <asp:ListBox ID="ListBox1" runat="server" Height="444px" Width="923px" AutoPostBack="True" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged"></asp:ListBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style104"></td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </asp:Panel>
                                        <p>
                                            &nbsp;</p>
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
</body>
</html>
