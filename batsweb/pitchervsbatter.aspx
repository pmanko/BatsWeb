<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" Language="C#" CodeBehind="pitchervsbatter.aspx.cbl" Inherits="batsweb.pitchervsbatter" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
    <script type="text/javascript">
          $(document).ready(function () {
              var names = "<%= Session["nameArray"] %>".split(";");
            $("#MainContent_locateBatterTextBox, #MainContent_locatePitcherTextBox").autocomplete({
                autoFocus: true,
                source: function (request, response) {
                    var matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex(request.term), "i");
                    response($.grep(names, function (item) {
                        return matcher.test(item);
                    }));
                }
            });
        });
  </script>
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
                                <asp:DropDownList ID="pTeamDropDownList" OnSelectedIndexChanged="pTeamDropDownList_SelectedIndexChanged" runat="server" AutoPostBack="True" class="form-control" >
                                </asp:DropDownList> 
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
                                <asp:DropDownList ID="bTeamDropDownList" OnSelectedIndexChanged="bTeamDropDownList_SelectedIndexChanged" runat="server" AutoPostBack="True" class="form-control">
                                </asp:DropDownList> 
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
                                Starting Date
                            </div>
                            <div class="list-group">
                                <div class="list-group-item">
                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTime" class="form-control"></asp:TextBox>
                                    <cc1:MaskedEditExtender ID="TextBox1_MaskedEditExtender" runat="server" BehaviorID="TextBox1_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="TextBox1" />
                                    <cc1:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox1_CalendarExtender" TargetControlID="TextBox1" />
                                    <asp:Button ID="goButton" runat="server" Text="Go" OnClick="goButton_Click" class="btn btn-primary"/>
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
                                <div class="row">
                                    <asp:Label ID="headerLabel" runat="server" BorderStyle="Groove" Font-Bold="True" Font-Names="Consolas" Font-Size="Medium" class="form-control"></asp:Label>
                                </div>
                                <div class="row">
                                    <asp:ListBox ID="abListBox" runat="server"  Height="444px" Font-Bold="True" Font-Names="Consolas" Font-Size="Medium" OnSelectedIndexChanged="abListBox_SelectedIndexChanged" class="form-control" SelectionMode="Multiple"></asp:ListBox>
                                </div>
                                <div class="row">
                                    <asp:Button ID="allButton" runat="server" Text="Play All" OnClick="allButton_Click" class="btn btn-default"/>
                                    <asp:Button ID="selectedButton" runat="server" Text="Play Selected" OnClick="selectedButton_Click" class="btn btn-default"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="selectPitcher" runat="server" >
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="row">
                                <div class="col-lg-2">
                                    <asp:Label ID="locatePitcherLabel" runat="server" Font-Size="Medium" Text="Locate Player:"></asp:Label>
                                </div>
                                <div class="col-lg-6">
                                    <div class="ui-widget">
                                        <asp:TextBox ID="locatePitcherTextBox" runat="server" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <asp:Button ID="locatePitcherButton" Text="OK" OnClick="locatePitcherButton_Click" runat="server" class="btn btn-primary"/>
                                </div>
                                <div class="col-lg-2">
                                    <asp:Button ID="backButton" Text="Back" runat="server" class="btn btn-danger"/>
                                </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button1" runat="server" Text="Button1" Visible="False" width="155px" OnClick="Button1_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button2" runat="server" Text="Button2" Visible="False" width="155px" OnClick="Button2_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button3" runat="server" Text="Button3" Visible="False" width="155px" OnClick="Button3_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button4" runat="server" Text="Button4" Visible="False" width="155px" OnClick="Button4_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button5" runat="server" Text="Button5" Visible="False" width="155px" OnClick="Button5_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button6" runat="server" Text="Button6" Visible="False" width="155px" OnClick="Button6_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button7" runat="server" Text="Button7" Visible="False" width="155px" OnClick="Button7_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button8" runat="server" Text="Button8" Visible="False" width="155px" OnClick="Button8_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button9" runat="server" Text="Button9" Visible="False" width="155px" OnClick="Button9_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button10" runat="server" Text="Button10" Visible="False" width="155px" OnClick="Button10_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button11" runat="server" Text="Button11" Visible="False" width="155px" OnClick="Button11_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button12" runat="server" Text="Button12" Visible="False" width="155px" OnClick="Button12_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button13" runat="server" Text="Button13" Visible="False" width="155px" OnClick="Button13_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button14" runat="server" Text="Button14" Visible="False" width="155px" OnClick="Button14_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button15" runat="server" Text="Button15" Visible="False" width="155px" OnClick="Button15_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button16" runat="server" Text="Button16" Visible="False" width="155px" OnClick="Button16_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button17" runat="server" Text="Button17" Visible="False" width="155px" OnClick="Button17_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button18" runat="server" Text="Button18" Visible="False" width="155px" OnClick="Button18_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button19" runat="server" Text="Button19" Visible="False" width="155px" OnClick="Button19_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button20" runat="server" Text="Button20" Visible="False" width="155px" OnClick="Button20_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button21" runat="server" Text="Button21" Visible="False" width="155px" OnClick="Button21_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button22" runat="server" Text="Button22" Visible="False" width="155px" OnClick="Button22_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button23" runat="server" Text="Button23" Visible="False" width="155px" OnClick="Button23_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button24" runat="server" Text="Button24" Visible="False" width="155px" OnClick="Button24_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button25" runat="server" Text="Button25" Visible="False" width="155px" OnClick="Button25_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button26" runat="server" Text="Button26" Visible="False" width="155px" OnClick="Button26_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button27" runat="server" Text="Button27" Visible="False" width="155px" OnClick="Button27_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button28" runat="server" Text="Button28" Visible="False" width="155px" OnClick="Button28_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button29" runat="server" Text="Button29" Visible="False" width="155px" OnClick="Button29_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button30" runat="server" Text="Button30" Visible="False" width="155px" OnClick="Button30_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="selectBatter" runat="server">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="row">
                                <div class="col-lg-2">
                                    <asp:Label ID="locateBatterLabel" runat="server" Font-Size="Medium" Text="Locate Player:"></asp:Label>
                                </div>
                                <div class="col-lg-6">
                                    <div class="ui-widget">
                                        <asp:TextBox ID="locateBatterTextBox" runat="server" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-lg-2">
                                    <asp:Button ID="locateBatterButton" Text="OK" OnClick="locateBatterButton_Click" runat="server" class="btn btn-primary"/>
                                </div>
                                <div class="col-lg-2">
                                    <asp:Button ID="backButton2" Text="Back" runat="server" class="btn btn-danger"/>
                                </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button31" runat="server" Text="Button31" Visible="False" width="155px" OnClick="Button31_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button32" runat="server" Text="Button32" Visible="False" width="155px" OnClick="Button32_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button33" runat="server" Text="Button33" Visible="False" width="155px" OnClick="Button33_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button34" runat="server" Text="Button34" Visible="False" width="155px" OnClick="Button34_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button35" runat="server" Text="Button35" Visible="False" width="155px" OnClick="Button35_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button36" runat="server" Text="Button36" Visible="False" width="155px" OnClick="Button36_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button37" runat="server" Text="Button37" Visible="False" width="155px" OnClick="Button37_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button38" runat="server" Text="Button38" Visible="False" width="155px" OnClick="Button38_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button39" runat="server" Text="Button39" Visible="False" width="155px" OnClick="Button39_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button40" runat="server" Text="Button40" Visible="False" width="155px" OnClick="Button40_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button41" runat="server" Text="Button41" Visible="False" width="155px" OnClick="Button41_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button42" runat="server" Text="Button42" Visible="False" width="155px" OnClick="Button42_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button43" runat="server" Text="Button43" Visible="False" width="155px" OnClick="Button43_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button44" runat="server" Text="Button44" Visible="False" width="155px" OnClick="Button44_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button45" runat="server" Text="Button45" Visible="False" width="155px" OnClick="Button45_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button46" runat="server" Text="Button46" Visible="False" width="155px" OnClick="Button46_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button47" runat="server" Text="Button47" Visible="False" width="155px" OnClick="Button47_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button48" runat="server" Text="Button48" Visible="False" width="155px" OnClick="Button48_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button49" runat="server" Text="Button49" Visible="False" width="155px" OnClick="Button49_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button50" runat="server" Text="Button50" Visible="False" width="155px" OnClick="Button50_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button51" runat="server" Text="Button51" Visible="False" width="155px" OnClick="Button51_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button52" runat="server" Text="Button52" Visible="False" width="155px" OnClick="Button52_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button53" runat="server" Text="Button53" Visible="False" width="155px" OnClick="Button53_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button54" runat="server" Text="Button54" Visible="False" width="155px" OnClick="Button54_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button55" runat="server" Text="Button55" Visible="False" width="155px" OnClick="Button55_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <asp:Button ID="Button56" runat="server" Text="Button56" Visible="False" width="155px" OnClick="Button56_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button57" runat="server" Text="Button57" Visible="False" width="155px" OnClick="Button57_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button58" runat="server" Text="Button58" Visible="False" width="155px" OnClick="Button58_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button59" runat="server" Text="Button59" Visible="False" width="155px" OnClick="Button59_Click" class="btn btn-default"/>
                                        <asp:Button ID="Button60" runat="server" Text="Button60" Visible="False" width="155px" OnClick="Button60_Click" class="btn btn-default"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
    </form>
    </div>
</asp:Content>
