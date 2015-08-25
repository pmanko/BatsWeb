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
        .auto-style7 {
            width: 238px;
            height: 30px;
        }
        .auto-style19 {
            width: 523px;
            height: 33px;
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
        .auto-style33 {
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
            height: 33px;
        }
        .auto-style52 {
            width: 84px;
            height: 59px;
        }
        .auto-style53 {
            width: 84px;
            height: 33px;
        }
        .auto-style58 {
            width: 283px;
            height: 59px;
        }
        .auto-style59 {
            width: 283px;
            height: 33px;
        }
        .auto-style61 {
            width: 309px;
            height: 59px;
        }
        .auto-style62 {
            width: 309px;
            height: 33px;
        }
        .auto-style65 {
            width: 61px;
            height: 59px;
        }
        .auto-style66 {
            width: 61px;
            height: 33px;
        }
        .auto-style68 {
            width: 406px;
            height: 59px;
        }
        .auto-style69 {
            width: 406px;
            height: 33px;
        }
        .auto-style75 {
            height: 149px;
        }
        .auto-style76 {
            width: 238px;
            height: 29px;
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
            height: 950px;
            width: 973px;
        }
        .auto-style108 {
            width: 160px;
        }
    </style>
</head>
<body>
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
                                                    <asp:RadioButton ID="RadioButton1" runat="server" GroupName="startDate" Text="All Games" />
                                                </td>
                                                <td class="auto-style40"></td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style31">
                                                    <asp:RadioButton ID="RadioButton2" runat="server" GroupName="startDate" Text="Start Date:" />
                                                </td>
                                                <td class="auto-style41">
                                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTime" Width="111px"></asp:TextBox>
                                                    <cc1:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" BehaviorID="TextBox1_CalendarExtender" TargetControlID="TextBox1" />
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
                                                    <asp:RadioButton ID="RadioButton3" runat="server" GroupName="endDate" Text="All Games" />
                                                </td>
                                                <td class="auto-style32"></td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style34">
                                                    <asp:RadioButton ID="RadioButton4" runat="server" GroupName="endDate" Text="End Date:" />
                                                </td>
                                                <td class="auto-style33">
                                                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                                                    <cc1:CalendarExtender ID="TextBox4_CalendarExtender" runat="server" BehaviorID="TextBox4_CalendarExtender" DefaultView="Days" PopupPosition="BottomLeft" TargetControlID="TextBox4" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style32" colspan="2">
                                                    <asp:Button ID="Button3" runat="server" Height="26px" Text="Date One-Clicks" />
                                                </td>
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
                                            <asp:TextBox ID="TextBox2" runat="server" style="text-align: left"></asp:TextBox>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style7">
                                        <asp:Button ID="Button1" runat="server" Text="Select Pitcher" OnClick="Button1_Click" />
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
                                            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style77">
                                        <asp:Button ID="Button2" runat="server" Text="Select Batter" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="auto-style52">Result1:</td>
                    <td class="auto-style65">
                        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                    <td align="right" class="auto-style58">Runners:</td>
                    <td class="auto-style61">
                        <asp:DropDownList ID="DropDownList3" runat="server" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td align="right" class="auto-style68">Inn:</td>
                    <td class="auto-style46">
                        <asp:DropDownList ID="DropDownList5" runat="server" OnSelectedIndexChanged="DropDownList5_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style49">
                        <asp:Button ID="Button4" runat="server" Text="Reset" />
                    </td>
                </tr>
                <tr>
                    <td align="right" class="auto-style53">Result2:</td>
                    <td class="auto-style66">
                        <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td align="right" class="auto-style59">Outs:</td>
                    <td class="auto-style62">
                        <asp:DropDownList ID="DropDownList4" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style69"></td>
                    <td class="auto-style19"></td>
                    <td class="auto-style50"></td>
                </tr>
                <tr>
                    <td class="auto-style103" valign="top">
                        <asp:CheckBoxList ID="CheckBoxList1" runat="server" Width="230px">
                            <asp:ListItem>Maximum At Bats:</asp:ListItem>
                            <asp:ListItem>Sort At Bats by Inning</asp:ListItem>
                            <asp:ListItem>Sort At Bats by Batter</asp:ListItem>
                            <asp:ListItem>Sort At Bats Oldest - Newest</asp:ListItem>
                        </asp:CheckBoxList>
                        <asp:Panel ID="Panel9" runat="server" style="z-index: 1; left: 397px; top: 254px; position: absolute; height: 14px; width: 44px" Visible="False">
                            <table style="height: 111px; width: 239px">
                                <tr>
                                    <td align="center" class="auto-style108">
                                        <asp:Label ID="Label2" runat="server" Text="Error Message"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" class="auto-style108">
                                        <asp:Label ID="Label3" runat="server" Text="Hey there's an error"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" class="auto-style108">
                                        <asp:Button ID="Button6" runat="server" Text="Button" />
                                        <asp:Button ID="Button7" runat="server" Text="Button" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:TextBox ID="TextBox5" runat="server" style="z-index: 1; left: 185px; top: 288px; position: absolute" Width="45px"></asp:TextBox>
                    </td>
                    <td class="auto-style102" colspan="7">
                        <asp:Button ID="Button5" runat="server" style="z-index: 1; left: 821px; top: 357px; position: absolute" Text="Show At Bats" OnClick="Button5_Click" />
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
    </form>
</body>
</html>
