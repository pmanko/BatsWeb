<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="fullatbat.aspx.cbl" Inherits="batsweb.fullatbat" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/fullatbat.js"></script> 
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
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
                                    <asp:TextBox ID="TextBox4" runat="server" TextMode="DateTime"  class="form-control"></asp:TextBox>
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
                                <asp:TextBox ID="pitcherTextBox" runat="server" style="text-align: left" class="form-control" ReadOnly="True"></asp:TextBox>
                                <asp:Button ID="pitcherButton" runat="server" Text="Select Pitcher" OnClick="Button1_Click" CssClass="btn btn-default" />
                                <cc1:PopupControlExtender ID="pitcherButton_PopupExtender" runat="server" BehaviorID="pitcherButton_PopupControlExtender" DynamicServicePath="" ExtenderControlID="" PopupControlID="selectPitcher" TargetControlID="pitcherButton">
                                </cc1:PopupControlExtender>
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
                                    <asp:TextBox ID="batterTextBox" runat="server" class="form-control" ReadOnly="True"></asp:TextBox>

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
                                </asp:DropDownList>      
                            </div>
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
                                <asp:ListBox ID="ListBox1" runat="server" Height="444px" Width="923px" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged" class="form-control" SelectionMode="Multiple"></asp:ListBox>
                                <asp:HiddenField ID="vid_paths" runat="server" />
                                <asp:HiddenField ID="vid_titles" runat="server" />

                                <a href="#" id="show_videos" class="btn btn-lg btn-primary">Show</a>
                                <asp:Button id="showVideosButton" runat="server" Text="Show Videos in BatsTube" OnClick="showVideosButton_Click" class="btn btn-lg btn-primary"  />

                            </div>
                        </div>
                    </div>

                    
                </div>
            </asp:Panel>


            <asp:Panel ID="Panel12" runat="server" Height="260px" style="margin-left: 0px" Width="175px">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Dates
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <asp:Button ID="allGamesButton" runat="server" OnClick="allGamesButton_Click" Text="All Games" style="margin-left: 25px" Width="125px" class="btn btn-default"/>
                        </div>
                        <div class="row">
                            <asp:Button ID="currentYearButton" runat="server" OnClick="currentYearButton_Click" Text="Current Year" style="margin-left: 25px" Width="125px" class="btn btn-default"/>
                        </div>
                        <div class="row">
                            <asp:Button ID="pastYearButton" runat="server" OnClick="pastYearButton_Click" Text="Past Year" style="margin-left: 25px" Width="125px" class="btn btn-default"/>
                        </div>
                        <div class="row">
                            <asp:Button ID="twoWeeksButton" runat="server" OnClick="twoWeeksButton_Click" Text="Last 2 Weeks" style="margin-left: 25px" Width="125px" class="btn btn-default"/>
                        </div>
                        <div class="row">
                            <asp:Button ID="currentMonthButton" runat="server" OnClick="currentMonthButton_Click" Text="Current Month" style="margin-left: 25px" Width="125px" class="btn btn-default"/>
                        </div>
                        <div class="row">
                            <asp:Button ID="twoMonthsButton" runat="server" OnClick="twoMonthsButton_Click" Text="Last 2 Months" style="margin-left: 25px" Width="125px" class="btn btn-default"/>
                        </div>
                        <div class="row">
                            <asp:Button ID="threeMonthsButton" runat="server" OnClick="threeMonthsButton_Click" Text="Last 3 Months" style="margin-left: 25px" Width="125px" class="btn btn-default"/>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        <asp:Panel ID="SelectPitcher" runat="server" Height="300px" style="margin-left: 0px" Width="425px" >
            <div class="panel panel-default">
                <div class="panel-heading">
                    Select Pitcher
                </div>
                <div class="panel-body">
                    <div class="row">
                        <asp:TextBox ID="pCurrentSelection" runat="server" class="form-control" ReadOnly="True"></asp:TextBox>
                    </div>
                    <div class="row">
                        <asp:Button ID="pAllLeftButton" runat="server" OnClick="pAllLeftButton_Click" Text="All Left" style="margin-left: 25px" Width="125px" class="btn btn-default" />
                        <asp:Button ID="pAllButton" runat="server" OnClick="pAllButton_Click" Text="All" Width="125px"  class="btn btn-default" />
                        <asp:Button ID="pAllRightButton" runat="server" OnClick="pAllRightButton_Click" Text="All Right" Width="125px"  class="btn btn-default" />
                    </div>
                    <div class="row">
                        <asp:Button ID="pTeamLeftButton" runat="server" Text="Team Left" OnClick="pTeamLeftButton_Click" style="margin-left: 25px" Width="125px" class="btn btn-default" />
                        <asp:Button ID="pTeamButton" runat="server" Text="Team" OnClick="pTeamButton_Click" Width="125px"  class="btn btn-default" />
                        <asp:Button ID="pTeamRightButton" runat="server" Text="Team Right" OnClick="pTeamRightButton_Click" Width="125px"  class="btn btn-default" />
                    </div>
                    <div class="row">
                        <asp:Button ID="pPlayerButton" runat="server" Text="Select Player" OnClick="pPlayerButton_Click" style="margin-left: 154px" Width="125px" class="btn btn-default"/>
                    </div>
                    <div class="row">
                        <asp:Panel ID="Panel11" runat="server">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    Pitcher Options
                                </div>
                                <div class="panel-body"> 
                                    <div class="row">
                                        <asp:TextBox ID="TextBox5" runat="server" Width="20px" style="margin-left: 25px" class="form-control"></asp:TextBox>
                                        <asp:RadioButton ID="RadioButton1" runat="server" Text="Any Type" style="margin-left: 75px" />
                                        <asp:RadioButton ID="RadioButton3" runat="server" Text="Custom" style="margin-left: 25px" />
                                    </div>
                                    <div class="row">
                                        <asp:RadioButton ID="RadioButton2" runat="server" Text="Power" style="margin-left: 75px"/>
                                    </div>
                                    <div class="row">
                                        <asp:RadioButton ID="RadioButton4" runat="server" Text="Single" style="margin-left: 75px"/>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                    <div class="row">
                        <asp:Button ID="pitcherOKButton" runat="server" Text="OK" style="margin-left: 154px" Width="125px" class="btn btn-default" />
                        <cc1:ModalPopupExtender ID="pitcherOKButton_ModalPopupExtender" runat="server" BehaviorID="pitcherOKButton_ModalPopupExtender" DynamicServicePath="" PopupControlID="playerPanel" TargetControlID="ipHiddenField">
                        </cc1:ModalPopupExtender>
                        <asp:HiddenField ID="ipHiddenField" runat="server" />
                        <asp:HiddenField ID="pHiddenField" runat="server" />
                        <cc1:ModalPopupExtender ID="pHiddenFieldTeam_ModalPopupExtender" runat="server" BehaviorID="pHiddenFieldTeam_ModalPopupExtender" DynamicServicePath="" PopupControlID="pTeamPanel" TargetControlID="pHiddenField">
                        </cc1:ModalPopupExtender>
                    </div>
                </div>
             </div>
        </asp:Panel>
        <asp:Panel ID="playerPanel" runat="server" Height="275px" Width="275px">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Select Player 
                </div>
                <div class="panel-body"> 
                    <div class="row">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="teamDropDownList" runat="server" OnSelectedIndexChanged="teamDropDownList_SelectedIndexChanged" AutoPostBack="True" class="form-control" >
                        </asp:DropDownList> 
                        <asp:ListBox ID="playerListBox" runat="server" Height="114px" OnSelectedIndexChanged="playerListBox_SelectedIndexChanged" class="form-control" ></asp:ListBox>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                    </div>
                    <div class="row">
                        <asp:Button ID="playerOKButton" runat="server" OnClick="playerOKButton_Click" Text="OK" style="margin-left: 100px" class="btn btn-default" />
                    </div>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="selectBatter" runat="server"  Height="300px" style="margin-left: 0px" Width="425px" >
           <div class="panel panel-default">
                <div class="panel-heading">
                    Select Batter
                </div>
                <div class="panel-body">
                    <div class="row">
                        <asp:TextBox ID="bCurrentSelection" runat="server" class="form-control" ReadOnly="True"></asp:TextBox>
                    </div>
                    <div class="row">
                        <asp:Button ID="bAllLeftButton" runat="server" OnClick="bAllLeftButton_Click" Text="All Left" style="margin-left: 25px" Width="125px" class="btn btn-default" />
                        <asp:Button ID="bAllButton" runat="server" OnClick="bAllButton_Click" Text="All" Width="125px" class="btn btn-default" />
                        <asp:Button ID="bAllRightButton" runat="server" OnClick="bAllRightButton_Click" Text="All Right" Width="125px" class="btn btn-default" />
                    </div>
                    <div class="row">
                        <asp:Button ID="bTeamLeftButton" runat="server" Text="Team Left" OnClick="bTeamLeftButton_Click" style="margin-left: 25px" Width="125px" class="btn btn-default" />
                        <asp:Button ID="bTeamButton" runat="server" Text="Team" OnClick="bTeamButton_Click"  Width="125px" class="btn btn-default" />
                        <asp:Button ID="bTeamRightButton" runat="server" Text="Team Right" OnClick="bTeamRightButton_Click"  Width="125px" class="btn btn-default" />
                    </div>
                    <div class="row">
                        <asp:Button ID="bPlayerButton" runat="server" Text="Select Player" OnClick="bPlayerButton_Click" style="margin-left: 154px" Width="125px" class="btn btn-default" />
                    </div>
                    <div class="row">
                        <asp:Panel ID="Panel14" runat="server">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    Batter Options
                                </div>
                                <div class="panel-body"> 
                                    <div class="row">  
                                        <asp:TextBox ID="TextBox6" runat="server" Width="23px" style="margin-left: 25px" class="form-control"></asp:TextBox>
                                        <asp:RadioButton ID="RadioButton" runat="server" Text="Any Type" style="margin-left: 75px" />
                                        <asp:RadioButton ID="RadioButton5" runat="server" Text="Custom" style="margin-left: 25px"  />
                                    </div>
                                    <div class="row">  
                                        <asp:RadioButton ID="RadioButton6" runat="server" Text="Power" style="margin-left: 75px" />
                                    </div>
                                    <div class="row">  
                                        <asp:RadioButton ID="RadioButton7" runat="server" Text="Single" style="margin-left: 75px"  />
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                    <div class="row">
                        <asp:Button ID="batterOKButton" runat="server" Text="OK" style="margin-left: 154px" Width="125px" class="btn btn-default" />
                        <asp:HiddenField ID="bHiddenField" runat="server" />
                        <cc1:ModalPopupExtender ID="bHiddenFieldTeam_ModalPopupExtender" runat="server" BehaviorID="bHiddenFieldTeam_ModalPopupExtender" DynamicServicePath="" PopupControlID="bTeamPanel" TargetControlID="bHiddenField">
                        </cc1:ModalPopupExtender>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <br />
        <asp:Panel ID="pTeamPanel" runat="server" Height="110px" Width="180px">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Which pitcher team?
                </div>
                <div class="panel-body">     
                    <div class="row">
                        <asp:DropDownList ID="pTeamDropDownList" runat="server" OnSelectedIndexChanged="pTeamDropDownList_SelectedIndexChanged" class="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="row">
                        <asp:Button ID="pTeamOKButton" runat="server" OnClick="pTeamOKButton_Click" Text="OK" style="margin-left: 60px" class="btn btn-default" />
                    </div>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="bTeamPanel" runat="server" Height="110px" Width="180px">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Which batter team?
                </div>
                <div class="panel-body">     
                    <div class="row">
                        <asp:DropDownList ID="bTeamDropDownList" runat="server" OnSelectedIndexChanged="bTeamDropDownList_SelectedIndexChanged" class="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="row">
                        <asp:Button ID="bTeamOKButton" runat="server" OnClick="bTeamOKButton_Click" Text="OK" style="margin-left: 60px" class="btn btn-default" />
                    </div>
                </div>
            </div>
        </asp:Panel>
        </form>
    </div>
</asp:Content>


                    







