<%@ Page AutoEventWireup="true" CodeBehind="EZvideo.aspx.cbl" Inherits="batsweb.EZvideo" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <!--
        .auto-style1 {
            width: 406px;
        }
        .auto-style2 {
            height: 203px;
        }
    </style>  -->
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" /> 
    <!--
    <link href="Styles/BenStyleSheet.css" rel="stylesheet" type="text/css" />
    
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style> -->
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
</head>
<body>

        <div id="header">
            <img src="images/homeplategrey.png" style="width:70px; height:70px; float:left"/>Welcome to BATS! Online<img src="images/homeplategrey.png" style="width:70px; height:70px; float:right ;margin-right: 15px" />
        </div>



    <h1>BATS! EZ Video</h1>


    <div id="main">
    <form id="form1" runat="server">
    <div style="height: 571px; width: 1251px">
    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    
        
         <table>           
                    x</td>
            </tr>
            <tr>
                <td align="center" class="auto-style1">x</td>
            </tr>
        </table>
        <br />
        <asp:Panel ID="Panel1" runat="server" GroupingText="Master Video List" Height="303px">
            <table style="height: 447px; width: 963px">
                <tr>
                    <td class="text">Start Date:</td>
                    <td>
                        <asp:TextBox ID="TextBox1" class="namebox" runat="server" CssClass="namebox"></asp:TextBox>
                        <cc1:MaskedEditExtender ID="TextBox1_MaskedEditExtender" runat="server" BehaviorID="TextBox1_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="TextBox1" />
                        <cc1:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox1_CalendarExtender" TargetControlID="TextBox1" />
                    </td>
                    <td class="text">End Date:</td>
                    <td>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="namebox"></asp:TextBox>
                        <cc1:MaskedEditExtender ID="TextBox2_MaskedEditExtender" runat="server" BehaviorID="TextBox2_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="TextBox2" />
                        <cc1:CalendarExtender ID="TextBox2_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox2_CalendarExtender" TargetControlID="TextBox2" />
                    </td>
                    <td>
                        <asp:Button ID="dateButton" runat="server" Text="Date One Clicks" CssClass="pushbutton" />
                        <cc1:PopupControlExtender ID="dateButton_PopupControlExtender" runat="server" BehaviorID="dateButton_PopupControlExtender" DynamicServicePath="" ExtenderControlID="" PopupControlID="Panel3" TargetControlID="dateButton">
                        </cc1:PopupControlExtender>
                    </td>
                    <td>
                        <asp:Button ID="Button2" runat="server" Text="Go" OnClick="Button2_Click" CssClass="pushbutton" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:TextBox ID="TextBox3" runat="server" Width="943px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2" colspan="6">
                        <asp:ListBox ID="ListBox1" runat="server" Height="213px" Width="946px" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged"></asp:ListBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Panel ID="Panel2" runat="server" GroupingText="Sort By:" Height="136px">
                            <table style="height: 134px; width: 218px">
                                <tr>
                                    <td>
                                        <asp:RadioButton ID="RadioButtonTeam" runat="server" Text="Team" AutoPostBack="True" OnCheckedChanged="RadioButtonTeam_CheckedChanged" GroupName="sort" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:RadioButton ID="RadioButtonName" runat="server" Text="Name" AutoPostBack="True" OnCheckedChanged="RadioButtonName_CheckedChanged" GroupName="sort" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:RadioButton ID="RadioButtonDate" runat="server" Text="Newest Date" AutoPostBack="True" OnCheckedChanged="RadioButtonDate_CheckedChanged" GroupName="sort" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                    <td>
                        <asp:Button ID="Button3" runat="server" Text="Play Video" CssClass="playbutton" OnClick="Button3_Click" />
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </asp:Panel>
    
        <br />
        <br />
        <br />
    
    </div>
        <asp:Panel ID="Panel3" runat="server" BackColor="#CCCCCC" GroupingText="Dates" Height="210px" Width="189px">
            <table>
                <tr>
                    <td>
                        <asp:Button ID="allGamesButton" runat="server" OnClick="allGamesButton_Click" Text="Button" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="Button5" runat="server" Text="Button" />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </asp:Panel>
    </form>
    </div>
</body>
</html>
