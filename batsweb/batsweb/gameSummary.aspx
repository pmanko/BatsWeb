<%@ Page AutoEventWireup="true" CodeBehind="gameSummary.aspx.cbl" Inherits="batsweb.gameSummary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 4px;
            height: 148px;
        }
        .auto-style2 {
            width: 4px;
            height: 34px;
        }
        .auto-style3 {
            width: 224px;
        }
        .auto-style4 {
            width: 107px;
        }
        .auto-style5 {
            width: 37px;
        }
        .auto-style6 {
            width: 154px;
        }
        .auto-style7 {
            width: 173px;
        }
        .auto-style8 {
            width: 37px;
            height: 33px;
        }
        .auto-style9 {
            width: 107px;
            height: 33px;
        }
        .auto-style10 {
            width: 154px;
            height: 33px;
        }
        .auto-style11 {
            width: 173px;
            height: 33px;
        }
        .auto-style12 {
            width: 224px;
            height: 33px;
        }
        .auto-style13 {}
        .auto-style14 {
            width: 37px;
            height: 34px;
        }
        .auto-style15 {
            width: 107px;
            height: 34px;
        }
        .auto-style16 {
            width: 154px;
            height: 34px;
        }
        .auto-style17 {
            width: 173px;
            height: 34px;
        }
        .auto-style18 {
            width: 224px;
            height: 34px;
        }
        .auto-style25 {}
        .auto-style26 {
            width: 37px;
            height: 31px;
        }
        .auto-style27 {
            width: 107px;
            height: 31px;
        }
        .auto-style28 {
            width: 154px;
            height: 31px;
        }
        .auto-style29 {
            width: 173px;
            height: 31px;
        }
        .auto-style30 {
            width: 224px;
            height: 31px;
        }
        .auto-style32 {
            width: 220px;
        }
        .auto-style33 {
            width: 247px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table style="height: 284px; width: 985px">
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="gamesHeader" runat="server" BorderStyle="Groove" Text="Label" Width="984px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style1" valign="top">
                    <asp:ListBox ID="ListBox1" runat="server" Height="238px" Width="988px"></asp:ListBox>
                </td>
            </tr>
        </table>
        <table style="height: 134px; width: 997px">
            <tr>
                <td class="auto-style8"></td>
                <td class="auto-style9"></td>
                <td class="auto-style10">
                    <asp:RadioButton ID="allRadioButton" runat="server" GroupName="Games" Text="All Games" />
                </td>
                <td class="auto-style11">
                    <asp:RadioButton ID="teamRadioButton" runat="server" GroupName="Games" Text="Team" />
&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td class="auto-style12">
                    <asp:DropDownList ID="teamDropDownList" runat="server">
                    </asp:DropDownList>
                </td>
                <td class="auto-style13" rowspan="2">
                    <asp:Button ID="inningsButton" runat="server" Text="Show Innings" />
                </td>
            </tr>
            <tr>
                <td class="auto-style14">Year:</td>
                <td class="auto-style15">
                    <asp:DropDownList ID="yearDropDownList" runat="server">
                    </asp:DropDownList>
                </td>
                <td class="auto-style16">
                    <asp:RadioButton ID="nlRadioButton" runat="server" GroupName="Games" Text="National League" />
                </td>
                <td class="auto-style17">
                    <asp:CheckBox ID="pitchersCheckBox" runat="server" Text="Show Starting Pitchers" />
                </td>
                <td class="auto-style18"></td>
            </tr>
            <tr>
                <td class="auto-style26"></td>
                <td class="auto-style27"></td>
                <td class="auto-style28">
                    <asp:RadioButton ID="alRadioButton" runat="server" GroupName="Games" Text="American League" />
                </td>
                <td class="auto-style29"></td>
                <td class="auto-style30"></td>
                <td class="auto-style25" rowspan="2">
                    <asp:Button ID="printButton" runat="server" Text="Print Game List" />
                </td>
            </tr>
            <tr>
                <td class="auto-style5">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td class="auto-style6">
                    &nbsp;</td>
                <td class="auto-style7">&nbsp;</td>
                <td class="auto-style3">&nbsp;</td>
            </tr>
        </table>
        <asp:Panel ID="Panel1" runat="server" GroupingText="Inning Summary" Width="998px">
            <table style="height: 107px; width: 991px">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Text="Label" Width="981px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="ListBox2" runat="server" Height="137px" Width="983px"></asp:ListBox>
                    </td>
                </tr>
            </table>
            <br />
            <table style="height: 60px; width: 988px">
                <tr>
                    <td class="auto-style32">
                        &nbsp;</td>
                    <td class="auto-style33">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style32">
                        <asp:Button ID="visButton" runat="server" Text="Select Visiting Player" />
                    </td>
                    <td class="auto-style33">
                        <asp:Button ID="statsButton" runat="server" Text="View Game Stats" />
                    </td>
                    <td>
                        <asp:Button ID="replaysButton" runat="server" Text="Replays" />
                    </td>
                    <td>
                        <asp:Button ID="homeButton" runat="server" Text="Select Home Player" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    
    </div>
    </form>
</body>
</html>
