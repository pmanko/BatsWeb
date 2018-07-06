<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="playerGameValue.aspx.cbl" Inherits="pucksweb.playerGameValue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/playerGameValue.js"></script> 
    <link type="text/css" href="/Styles/playerGameValue.css" rel="stylesheet" />
    <link type="text/css" href="/dist/styles/dataTables.bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="/dist/scripts/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/dist/scripts/dataTables.bootstrap.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid main-container">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="row">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <strong><asp:label id="lblVis" runat="server" Text="Visitors"></asp:label></strong>
                    </div>
                    <div class='panel-body'>
                        <div class="row">
                            <div class="col-md-12" id="trest">
                                <table id="vis" class="table table-striped table-bordered listbox-replacement-clickable" width="100%"> </table>
                            </div>
                        </div>
                        <asp:HiddenField ID="visField" runat="server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <strong><asp:label id="lblHome" runat="server" Text="Visitors"></asp:label></strong>
                    </div>
                    <div class='panel-body'>
                        <div class="row">
                            <div class="col-md-12">
                                <table id="home" class="table table-striped table-bordered listbox-replacement-clickable" width="100%"></table>
                            </div>
                        </div>
                        <asp:HiddenField ID="homeField" runat="server" />
                    </div>
                </div>
            </div>
        </div>
<%--        <div class="row">
            <div class="col-md-12">
                <strong>Click Any Header Field to Sort by Column | Select Any Cell to View Video</strong>
            </div>
        </div>--%>

        <!-- TOI Modal -->

        <div class="modal fade" id="toiModal" tabindex="-1" role="dialog" aria-labelledby="toiModalLabel">
          <div class="modal-dialog modal-lg" role="document">
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
                    <div class="listbox-replacement-wrapper" id="goalsTableWrapper">
                        <table id="goalsTable" class="table table-condensed table-bordered table-hover table-no-grid listbox-replacement listbox-replacement-clickable" 
                        data-value-field="#MainContent_goalsValueField" 
                        data-index-field="#MainContent_goalsIndexField" 
                        data-postback="false" 
                        data-multiple="true"
                        data-on-select="goalsUpdate"
                        data-on-dblclick-select="goalsUpdateDblclick"
                        data-on-dblclick="openBatsTube"
                        >
                        <thead>
                        <tr>
                            <th>Pd V H   Description</th>
                        </tr>
                        </thead>
                        <tbody id="goalsTableBody" runat="server"></tbody>
                        </table>
                    </div>
                    <asp:HiddenField ID="goalsValueField" runat="server" />
                    <asp:HiddenField ID="goalsIndexField" runat="server"  />
              </div>
              <div class="modal-footer">
                  <a href="#" class="btn btn-primary btn-async-request" data-action-flag="play-all" style="text-align: center">
                      <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Play All
                  </a>
                  <a href="#" class="btn btn-primary btn-async-request" data-action-flag="play-sel" style="text-align: center">
                      <span class="glyphicon glyphicon-play" aria-hidden="true"></span> Selection
                  </a>
              </div>
            </div>
          </div>
        </div>
    </div>
</asp:Content>
