<%@ Page AutoEventWireup="true" CodeBehind="gameSummary.aspx.cbl" Inherits="batsweb.gameSummary" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

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
        .auto-style34 {
            width: 4px;
        }
    </style>
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
</head>
<body>

    <div id="header">
        <img src="sydex.png" style="width: 70px; height: 70px; float: left"/>Welcome to BATS! on the Web<img src="sydex.png" style="width: 70px; height: 70px; float: right"/>
    </div>


    <h1>Game Summary</h1>

    <div id="main">
    <form id="form1" runat="server">
           <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
        <table style="height: 284px; width: 985px">
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="gamesHeader" runat="server" BorderStyle="Groove" Text="Date        Vis                         Home                     Time Video" Width="984px" Font-Names="consolas" Font-Size="Medium"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style1" valign="top">
                    <asp:ListBox ID="ListBox1" runat="server" Height="238px" Width="988px" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged" Font-Names="consolas" Font-Size="Medium"></asp:ListBox>
                </td>
            </tr>
        </table>
        <table style="height: 134px; width: 997px">
            <tr>
                <td class="auto-style8"></td>
                <td class="auto-style9"></td>
                <td class="auto-style10">
                    <asp:RadioButton ID="allRadioButton" runat="server" GroupName="Games" Text="All Games" AutoPostBack="True" OnCheckedChanged="allRadioButton_CheckedChanged" />
                </td>
                <td class="auto-style11">
                    <asp:RadioButton ID="teamRadioButton" runat="server" GroupName="Games" Text="Team" AutoPostBack="True" OnCheckedChanged="teamRadioButton_CheckedChanged" />
&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td class="auto-style12">
                    <asp:DropDownList ID="teamDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="teamDropDownList_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td class="auto-style13" rowspan="2">
                    <asp:Button ID="inningsButton" runat="server" Text="Show Innings" OnClick="inningsButton_Click" />
                </td>
            </tr>
            <tr>
                <td class="auto-style14">Year:</td>
                <td class="auto-style15">
                    <asp:DropDownList ID="yearDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="yearDropDownList_SelectedIndexChanged">
                        <asp:ListItem>2020</asp:ListItem>
                        <asp:ListItem>2019</asp:ListItem>
                        <asp:ListItem>2018</asp:ListItem>
                        <asp:ListItem>2017</asp:ListItem>
                        <asp:ListItem>2016</asp:ListItem>
                        <asp:ListItem>2015</asp:ListItem>
                        <asp:ListItem>2014</asp:ListItem>
                        <asp:ListItem>2013</asp:ListItem>
                        <asp:ListItem>2012</asp:ListItem>
                        <asp:ListItem>2011</asp:ListItem>
                        <asp:ListItem>2010</asp:ListItem>
                        <asp:ListItem>2009</asp:ListItem>
                        <asp:ListItem>2008</asp:ListItem>
                        <asp:ListItem>2007</asp:ListItem>
                        <asp:ListItem>2006</asp:ListItem>
                        <asp:ListItem>2005</asp:ListItem>
                        <asp:ListItem>2004</asp:ListItem>
                        <asp:ListItem>2003</asp:ListItem>
                        <asp:ListItem>2002</asp:ListItem>
                        <asp:ListItem>2001</asp:ListItem>
                        <asp:ListItem>2000</asp:ListItem>
                        <asp:ListItem>1999</asp:ListItem>
                        <asp:ListItem>1998</asp:ListItem>
                        <asp:ListItem>1997</asp:ListItem>
                        <asp:ListItem>1996</asp:ListItem>
                        <asp:ListItem>1995</asp:ListItem>
                        <asp:ListItem>1994</asp:ListItem>
                        <asp:ListItem>1993</asp:ListItem>
                        <asp:ListItem>1992</asp:ListItem>
                        <asp:ListItem>1991</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style16">
                    <asp:RadioButton ID="nlRadioButton" runat="server" GroupName="Games" Text="National League" AutoPostBack="True" OnCheckedChanged="nlRadioButton_CheckedChanged" />
                </td>
                <td class="auto-style17">
                    <asp:CheckBox ID="pitchersCheckBox" runat="server" Text="Show Starting Pitchers" AutoPostBack="True" OnCheckedChanged="pitchersCheckBox_CheckedChanged" />
                </td>
                <td class="auto-style18"></td>
            </tr>
            <tr>
                <td class="auto-style26"></td>
                <td class="auto-style27"></td>
                <td class="auto-style28">
                    <asp:RadioButton ID="alRadioButton" runat="server" GroupName="Games" Text="American League" AutoPostBack="True" OnCheckedChanged="alRadioButton_CheckedChanged" />
                </td>
                <td class="auto-style29"></td>
                <td class="auto-style30">&nbsp;</td>
                <td class="auto-style25" rowspan="2">
                    <asp:Button ID="printButton" runat="server" Text="Print Game List" OnClick="printButton_Click" />
                </td>
            </tr>
            <tr>
                <td class="auto-style5">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td class="auto-style6">
                    &nbsp;</td>
                <td class="auto-style7">
                </td>
                <td class="auto-style3">&nbsp;</td>
            </tr>
        </table>
        <asp:Panel ID="Panel1" runat="server" GroupingText="Inning Summary" Width="998px">
            <table style="height: 107px; width: 991px">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Text=" Inn Batter         Out Rnrs  Res  RBI   Inn Batter         Out Rnrs  Res  RBI" Width="981px" Font-Bold="True" Font-Names="Consolas" Font-Size="Medium"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListBox ID="ListBox2" runat="server" Height="137px" Width="983px" Font-Bold="True" Font-Names="Consolas" OnSelectedIndexChanged="ListBox2_SelectedIndexChanged" Font-Size="Medium"></asp:ListBox>
                        <asp:HiddenField ID="vid_paths" runat="server" />
                        <asp:HiddenField ID="vid_titles" runat="server" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="height: 60px; width: 988px">
                <tr>
                    <td class="auto-style32">
                        <asp:Button ID="playVis" runat="server" OnClick="playVis_Click" Text="Play Visitors" />
                    </td>
                    <td class="auto-style33">
                        <asp:Button ID="playHome" runat="server" OnClick="playHome_Click" Text="Play Home" />
                    </td>
                    <td>
                        <asp:Button ID="fromSelected" runat="server" OnClick="fromSelected_Click" Text="From Selected" />
                    </td>
                    <td>
                        <asp:Button ID="playFull" runat="server" OnClick="playFull_Click" Text="Play Full Game" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style32">
                        <asp:Button ID="visButton" runat="server" Text="Select Visiting Player" OnClick="visButton_Click" />
                        <cc1:ModalPopupExtender ID="HiddenField1Vis_ModalPopupExtender" runat="server" BehaviorID="HiddenField1Vis_ModalPopupExtender" TargetControlID="HiddenField1" PopupControlID="visPanel">
                        </cc1:ModalPopupExtender>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                    </td>
                    <td class="auto-style33">
                        <asp:Button ID="statsButton" runat="server" Text="View Game Stats"/>
                        <cc1:PopupControlExtender ID="statsButton_PopupControlExtender" runat="server" BehaviorID="statsButton_PopupControlExtender" DynamicServicePath="" ExtenderControlID="" PopupControlID="statsPanel" TargetControlID="statsButton">
                        </cc1:PopupControlExtender>
                    </td>
                    <td>
                        <asp:Button ID="replaysButton" runat="server" Text="Replays" />
                    </td>
                    <td>
                        <asp:Button ID="homeButton" runat="server" Text="Select Home Player" OnClick="homeButton_Click" />
                        <cc1:PopupControlExtender ID="homeButton_PopupControlExtender" runat="server" BehaviorID="homeButton_PopupControlExtender" DynamicServicePath="" ExtenderControlID="" PopupControlID="visPanel" TargetControlID="homeButton">
                        </cc1:PopupControlExtender>
                    </td>
                </tr>
            </table>
        </asp:Panel>


        <asp:Panel ID="visPanel" runat="server" Height="203px" Width="592px" BackColor="Silver">
            <table style="height: 200px; width: 543px">
                <tr>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Button" Visible="False" OnClick="Button1_Click" width="112px" />
                    </td>
                    <td>
                        <asp:Button ID="Button2" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button2_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button3" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button3_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button4" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button4_Click" />
                    </td>
                    <td class="auto-style34">
                        <asp:Button ID="Button5" runat="server" Text="Button" Visible="False" style="margin-left: 0px" Width="112px" OnClick="Button5_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="Button6" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button6_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button7" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button7_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button8" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button8_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button9" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button9_Click" />
                    </td>
                    <td class="auto-style34">
                        <asp:Button ID="Button10" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button10_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="Button11" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button11_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button12" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button12_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button13" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button13_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button14" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button14_Click" />
                    </td>
                    <td class="auto-style34">
                        <asp:Button ID="Button15" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button15_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="Button16" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button16_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button17" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button17_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button18" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button18_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button19" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button19_Click" />
                    </td>
                    <td class="auto-style34">
                        <asp:Button ID="Button20" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button20_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="Button21" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button21_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button22" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button22_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button23" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button23_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button24" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button24_Click" />
                    </td>
                    <td class="auto-style34">
                        <asp:Button ID="Button25" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button25_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="Button26" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button26_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button27" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button27_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button28" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button28_Click" />
                    </td>
                    <td>
                        <asp:Button ID="Button29" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button29_Click" />
                    </td>
                    <td class="auto-style34">
                        <asp:Button ID="Button30" runat="server" Text="Button" Visible="False" width="112px" OnClick="Button30_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="statsPanel" runat="server" BackColor="Silver" Width="591px">
            <asp:ListBox ID="ListBox3" runat="server" Height="245px" Width="586px" Font-Names="consolas"></asp:ListBox>
            <br />
            <asp:Button ID="Button31" runat="server" Text="Button" />
        </asp:Panel>
    </form>
    </div>
</body>
</html>
