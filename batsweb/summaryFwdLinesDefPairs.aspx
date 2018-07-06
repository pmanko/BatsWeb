<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="summaryFwdLinesDefPairs.aspx.cbl" Inherits="pucksweb.summaryFwdLinesDefPairs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/summaryFwdLinesDefPair.js"></script> 
    <link type="text/css" href="/Styles/summaryFwdLinesDefPair.css" rel="stylesheet"/>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid main-container">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="panel panel-primary">
            <div class="panel-heading">
                <strong><asp:label id="lblTeam" runat="server" Text="Team"></asp:label> </strong>(Double-Click Any Line to View Shifts)
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Defensive Pairs
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-md-offset-5">
                                <label> Even</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="listbox-replacement-wrapper" id="defEvenWrapper">
                                    <table id="defEven" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                    data-value-field="#MainContent_defEvenValueField" 
                                    data-index-field="#MainContent_defEvenIndexField" 
                                    data-postback="false" 
                                    data-multiple="false"
                                    data-on-select="defEvenUpdate"
                                    data-on-dblclick-select="defEvenUpdateDblclick"
                                    >
                                    <thead>
                                    <tr>
                                        <th>                                          Sh   5%  5%</th>
                                        <th>    Name                           Time   Val For  Ag</th>
                                    </tr>
                                    </thead>
                                    <tbody id="defEvenTableBody" runat="server"></tbody>
                                    </table>
                                </div>
                                <asp:HiddenField ID="defEvenValueField" runat="server" />
                                <asp:HiddenField ID="defEvenIndexField" runat="server" />
                                <asp:HiddenField ID="defEvenField" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                <button type="button" id="btnDefOppLines" class="btn btn-success center-block" data-toggle="collapse" data-target="#oppLines"> View Opposing Lines</button>
                            </div>
                            <div class="col-xs-6">
                                <button type="button" id="btnDefToi" class="btn btn-info center-block"> View Line TOI</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-md-offset-5">
                                <label> Shorthanded</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="listbox-replacement-wrapper" id="defShWrapper">
                                    <table id="defSh" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                    data-value-field="#MainContent_defShValueField" 
                                    data-index-field="#MainContent_defShIndexField" 
                                    data-postback="false" 
                                    data-multiple="false"
                                    data-on-select="defShUpdate"
                                    data-on-dblclick-select="defShUpdateDblclick"
                                    >
                                    <thead>
                                    <tr>
                                    <tr>
                                        <th>                                            Sh   5%</th>
                                        <th>    Name                           Time  Sh Val  Ag Gl</th>
                                    </tr>
                                    </thead>
                                    <tbody id="defShTableBody" runat="server"></tbody>
                                    </table>
                                </div>
                                <asp:HiddenField ID="defShValueField" runat="server" />
                                <asp:HiddenField ID="defShIndexField" runat="server" />
                                <asp:HiddenField ID="defShField" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Forward Lines
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-md-offset-5">
                                <label> Even</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="listbox-replacement-wrapper" id="fwdEvenWrapper">
                                    <table id="fwdEven" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                    data-value-field="#MainContent_fwdEvenValueField" 
                                    data-index-field="#MainContent_fwdEvenIndexField" 
                                    data-postback="false" 
                                    data-multiple="false"
                                    data-on-select="fwdEvenUpdate"
                                    data-on-dblclick-select="fwdEvenUpdateDblclick"
                                    >
                                    <thead>
                                    <tr>
                                        <th>                                                      Sh   5%  5%</th>
                                        <th>    Name                                       Time   Val For  Ag</th>
                                    </tr>
                                    </thead>
                                    <tbody id="fwdEvenTableBody" runat="server"></tbody>
                                    </table>
                                </div>
                                <asp:HiddenField ID="fwdEvenValueField" runat="server" />
                                <asp:HiddenField ID="fwdEvenIndexField" runat="server" />
                                <asp:HiddenField ID="fwdEvenField" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                <button type="button" id="btnFwdOppLines" class="btn btn-success center-block" data-toggle="collapse" data-target="#oppLines"> View Opposing Lines</button>
                            </div>
                            <div class="col-xs-6">
                                <button type="button" id="btnFwdToi" class="btn btn-info center-block"> View Line TOI</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-md-offset-5">
                                <label> Power Play</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="listbox-replacement-wrapper" id="fwdPpWrapper">
                                    <table id="fwdPp" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                    data-value-field="#MainContent_fwdPpValueField" 
                                    data-index-field="#MainContent_fwdPpIndexField" 
                                    data-postback="false" 
                                    data-multiple="false"
                                    data-on-select="fwdPpUpdate"
                                    data-on-dblclick-select="fwdPpUpdateDblclick"
                                    >
                                    <thead>
                                    <tr>
                                    <tr>
                                        <th>                                                        Sh   5%</th>
                                        <th>    Name                                        Time Sh Val  Ag Gl</th>
                                    </tr>
                                    </thead>
                                    <tbody id="fwdPpTableBody" runat="server"></tbody>
                                    </table>
                                </div>
                                <asp:HiddenField ID="fwdPpValueField" runat="server" />
                                <asp:HiddenField ID="fwdPpIndexField" runat="server" />
                                <asp:HiddenField ID="fwdPpField" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="collapse" id="oppLines">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong><label> Opponent Lines</label></strong>
                    <button type="button" class="close"  id="toiClose" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="panel panel-default">
                    <div class='panel-body'>
                        <div class="row">
                            <div class="col-md-6 col-md-offset-4">
                                <label>Lines Who Had More Than 20 Seconds:</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="listbox-replacement-wrapper" id="linesTableWrapper">
                                    <table id="linesTable" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                    data-value-field="#MainContent_linesValueField" 
                                    data-index-field="#MainContent_linesIndexField" 
                                    data-postback="false" 
                                    data-multiple="false"
                                    data-on-select="linesUpdate"
                                    data-on-dblclick-select="linesUpdateDblclick"
                                    >
                                    <thead>
                                    <tr>
                                        <th>                                                                         5%   5%   5%   Val  Val   Val</th>
                                        <th>Team            Line                                              Time ChFor ChAg  +/-  For   Ag   +/-</th>
                                    </tr>
                                    </thead>
                                    <tbody id="linesTableBody" runat="server"></tbody>
                                    </table>
                                </div>
                                <asp:HiddenField ID="linesValueField" runat="server" />
                                <asp:HiddenField ID="linesIndexField" runat="server"  />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-4 col-md-offset-2">
                                <label>Double-Click to View Shift Video</label>
                            </div>
                            <div class="col-xs-6">
                                <button type="button" id="btnOppShifts" class="btn btn-info center-block"> View Line TOI</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

                <!-- TOI Modal -->

        <div class="modal fade" id="toiModal" tabindex="-1" role="dialog" aria-labelledby="toiModalLabel">
          <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="toiModalLabel">Time On Ice Shifts</h4>
              </div>
              <div class="modal-body">
                <div class='row'>
                    <div class="col-md-12">
                        <strong><label id="lblPlayerName"></label></strong>
                    </div>
                </div>
                    <div class="listbox-replacement-wrapper" id="toiTableWrapper">
                        <table id="toiTable" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                                    data-index-field="#MainContent_toiIndexField" 
                                    data-value-field="#MainContent_toiValueField" 
                                    data-postback="false" 
                                    data-multiple="false"
                                    data-on-select="toiUpdate"
                                    data-on-dblclick-select="toiUpdateDblclick"
                                    data-on-dblclick="openBatsTube"
                        >
                            <thead>
                            <tr>
                                <th>Prd  In   Out  Secs Type</th>
                            </tr>
                            </thead>
                        <tbody id="toiTableBody" runat="server"></tbody>
                        </table>
                    </div>
                    <asp:HiddenField ID="toiIndexField" runat="server" />
                    <asp:HiddenField ID="toiValueField" runat="server"  />
              </div>
              <div class="modal-footer">
                  <a href="#" class="btn btn-primary btn-async-request" data-action-flag="from-toi" style="text-align: center">
                      <span class="glyphicon glyphicon-play" aria-hidden="true"></span> From Selected
                  </a>
              </div>
            </div>
          </div>
        </div>

    </div>
</asp:Content>