<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="breakdown.aspx.cbl" Inherits="batsweb.breakdown" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Panel ID="selectionPanel" runat="server" GroupingText="Report Settings">
                <div class="row">
                    <div class="col-lg-10">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <label>Pitcher:</label>
                                        <asp:TextBox ID="pitcherTextBox" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-6">
                                        <label>Batter:</label>
                                        <asp:TextBox ID="batterTextBox" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <label>Games:</label>
                                        <asp:TextBox ID="gamesTextBox" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-6">
                                        <label>Location:</label>
                                        <asp:TextBox ID="locationTextBox" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="selectionButton" runat="server" Text="Change Selection" class="btn btn-lg btn-primary"/>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-4">
                                        <label>Count:</label>
                                        <asp:DropDownList ID="countdd" runat="server" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Catcher:</label>
                                        <asp:DropDownList ID="catcherdd" runat="server" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Outs:</label>
                                        <asp:DropDownList ID="outsdd" runat="server" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <label>Pitch Loc:</label>
                                        <asp:DropDownList ID="pitchlocdd" runat="server" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Runners:</label>
                                        <asp:DropDownList ID="runnersdd" runat="server" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Inn:</label>
                                        <asp:DropDownList ID="inndd" runat="server" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <label>Pitch Type:</label>
                                        <asp:DropDownList ID="pitchtypedd" runat="server" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Result1:</label>
                                        <asp:DropDownList ID="result1dd" runat="server" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-lg-4">
                                        <asp:Button ID="resetButton" runat="server" Text="Reset" class="btn btn-danger"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <asp:Button ID="moreButton" runat="server" Text="More" class="btn btn-primary"/>
                                    </div>
                                    <div class="col-lg-4">
                                        <label>Result2:</label>
                                        <asp:DropDownList ID="result2dd" runat="server" AutoPostBack="True" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <asp:ListBox ID="ListBox1" runat="server" Height="320px" class="form-control" ></asp:ListBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <asp:ImageButton ID="szoneImageButton" runat="server" src="breakdownszone.aspx" alt="image could not be displayed refresh"/>
                    </div>
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Statistics
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>G:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="gLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>SAC:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="sacLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>FB:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="fbLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>AB:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="abLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>DP:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="dpLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>GB:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="gbLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>H:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="hLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>HBP:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="hbpLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>LD:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="ldLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>2B:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="doubleLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>TPA:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="tpaLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>PU:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="puLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>3B:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="tripleLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                    </div>
                                    <div class="col-lg-2">
                                    </div>
                                    <div class="col-lg-2">
                                        <label>BU:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="buLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>HR:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="hrLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>AVG:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="avgLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>RBI:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="rbiLabel1" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>OBP:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="obpLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>Hard:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="hardLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>BB:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="bbLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>SLG:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="slgLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>Med:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="medLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label>K:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="kLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>OPS:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="opsLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                        <label>Soft:</label>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="softLabel" runat="server" ReadOnly="true" class="form-control"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="col-lg-4">
                            <asp:Button ID="clearButton" runat="server" Text="Clear Selected" class="btn btn-primary"/>
                        </div>
                        <div class="col-lg-4">
                            <asp:Button ID="selectedButton" runat="server" Text="Selected" class="btn btn-primary"/>
                        </div>
                        <div class="col-lg-4">
                            <asp:Button ID="allButton" runat="server" Text="All" class="btn btn-primary"/>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <asp:ImageButton ID="ImageButton2" runat="server" src="breakdownszone.aspx" alt="image could not be displayed refresh"/>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-2">
                        <asp:Button ID="resultsButton" runat="server" Text="Pitch Results" class="btn btn-primary"/>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="typesButton" runat="server" Text="Pitch Types" class="btn btn-primary"/>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="videosButton" runat="server" Text="Compare Videos" class="btn btn-primary"/>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="prevButton" runat="server" Text="Prev. Pitch" class="btn btn-primary"/>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="nextButton" runat="server" Text="Next Pitch" class="btn btn-primary"/>
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="printButton" runat="server" Text="Print..." class="btn btn-primary"/>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="changeSelection" runat="server" Height="800px" Width="800px">
                <div class="col-lg-2">
                    <div class="row">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Date Range
                            </div>
                            <div class="list-group">
                                <div class="list-group-item">
                                    <h4>Start Date</h4>
                                    <div class='radio radio-primary'><asp:RadioButton ID="allStartRadioButton" runat="server" GroupName="startDate" text="All Games" OnCheckedChanged="allStartRadioButton_CheckedChanged" /></div>
                                    <div class='radio radio-primary'><asp:RadioButton ID="startDateRadioButton" runat="server" GroupName="startDate" Text="Start Date:" OnCheckedChanged="startDateRadioButton_CheckedChanged" /></div>
                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTime" class="form-control"></asp:TextBox>
                                    <cc1:MaskedEditExtender ID="TextBox1_MaskedEditExtender" runat="server" BehaviorID="TextBox1_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="99/99/99" MaskType="Date" PromptCharacter="9" TargetControlID="TextBox1" />
                                    <cc1:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" Format="MM/dd/yy" BehaviorID="TextBox1_CalendarExtender" TargetControlID="TextBox1" />
                                </div>
                                <div class="list-group-item">
                                    <h4>End Date</h4>
                                    <div class='radio radio-primary'><asp:RadioButton ID="allEndRadioButton" runat="server" GroupName="endDate" Text="All Games" OnCheckedChanged="allEndRadioButton_CheckedChanged" /></div>
                                    <div class='radio radio-primary'><asp:RadioButton ID="endDateRadioButton" runat="server" GroupName="endDate" Text="End Date:" OnCheckedChanged="endDateRadioButton_CheckedChanged" /></div>
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
                    <div class="row">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Other Selections
                            </div>
                            <div class="list-group">
                                <div class='radio radio-primary'><asp:RadioButton ID="allLocRadioButton" runat="server" GroupName="location" text="All Locations" OnCheckedChanged="allLocRadioButton_CheckedChanged" /></div>
                                <div class='radio radio-primary'><asp:RadioButton ID="pitchHomeRadioButton" runat="server" GroupName="location" text="Pitcher Home/Batter Away" OnCheckedChanged="pitchHomeRadioButton_CheckedChanged" /></div>
                                <div class='radio radio-primary'><asp:RadioButton ID="pitchAwayRadioButton" runat="server" GroupName="location" text="Pitcher Away/Batter Home" OnCheckedChanged="pitchawayRadioButton_CheckedChanged" /></div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    Game Time
                                </div>
                                <div class="panel-body">
                                    <div class='radio radio-primary'><asp:RadioButton ID="allTimeRadioButton" runat="server" GroupName="location" text="All" OnCheckedChanged="allTimeRadioButton_CheckedChanged" /></div>
                                    <div class='radio radio-primary'><asp:RadioButton ID="dayRadioButton" runat="server" GroupName="location" text="Day" OnCheckedChanged="dayRadioButton_CheckedChanged" /></div>
                                    <div class='radio radio-primary'><asp:RadioButton ID="nightRadioButton" runat="server" GroupName="location" text="Night" OnCheckedChanged="nightRadioButton_CheckedChanged" /></div>
                                </div>
                                <div class='form-group'>
                                    <div class='checkbox checkbox-primary'><asp:CheckBox ID="maxAtBatsCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="maxAtBatsCheckBox_CheckedChanged" Text="Maximum At Bats:" /></div>
                                    <asp:TextBox ID="maxABTextBox" runat="server" class="form-control" MaxLength="3"></asp:TextBox>
                                </div>
                                <cc1:MaskedEditExtender ID="maxABTextBox_MaskedEditExtender" runat="server" AutoComplete="False" BehaviorID="maxABTextBox_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="999" MaskType="Number" PromptCharacter=" " TargetControlID="maxABTextBox" />
                                <div class='checkbox checkbox-primary'><asp:CheckBox ID="myCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="myCheckBox_CheckedChanged" Text="My Team's Games Only" /></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5">
                </div>
            </asp:Panel>
        </form>
    </div>
</asp:Content>