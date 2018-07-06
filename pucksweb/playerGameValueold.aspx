<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="playerGameValueold.aspx.cbl" Inherits="pucksweb.playerGameValue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/playerGameValue.js"></script> 
    <link type="text/css" href="/Styles/playerGameValue.css" rel="stylesheet" />
    <link type="text/css" href="/dist/styles/dataTables.bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="/dist/scripts/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/dist/scripts/dataTables.bootstrap.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="row">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <strong><asp:label id="lblVis" runat="server" Text="Visitors"></asp:label></strong>
                    </div>
                    <div class='panel-body'>
                        <div class="row">
                            <div class="col-md-12">
                                <table id="vis" class="table table-striped table-bordered listbox-replacement-clickable"></table>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton1" onclick="visButton(1,1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton2" onclick="visButton(1,1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton3" onclick="visButton(1,2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton4" onclick="visButton(1,3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton5" onclick="visButton(1,4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton6" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton7" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton8" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton9" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton10" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton11" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton12" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton13" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton14" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton15" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton16" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton17" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton18" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton19" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton20" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton21" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton22" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton23" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton24" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton25" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton26" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton27" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton28" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton29" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton30" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton31" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton32" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton33" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton34" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton35" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton36" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton37" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton38" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton39" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton40" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton41" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton42" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton43" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton44" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton45" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton46" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton47" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton48" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton49" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton50" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton51" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton52" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton53" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton54" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton55" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton56" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton57" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton58" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton59" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton60" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton61" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton62" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton63" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton64" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton65" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton66" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton67" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton68" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton69" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton70" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton71" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton72" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton73" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton74" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton75" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton76" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton77" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton78" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton79" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton80" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton81" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton82" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton83" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton84" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton85" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton86" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton87" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton88" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton89" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton90" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton91" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton92" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton93" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton94" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton95" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton96" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton97" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton98" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton99" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton100" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton101" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton102" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton103" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton104" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton105" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton106" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton107" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton108" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton109" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton110" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton111" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton112" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton113" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton114" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton115" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton116" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton117" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton118" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton119" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton120" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton121" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton122" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton123" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton124" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton125" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton126" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton127" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton128" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton129" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton130" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton131" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton132" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton133" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton134" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton135" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton136" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton137" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton138" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton139" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton140" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton141" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton142" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton143" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton144" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton145" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton146" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton147" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton148" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton149" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton150" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton151" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton152" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton153" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton154" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton155" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton156" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton157" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton158" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton159" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton160" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton161" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton162" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton163" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton164" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton165" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton166" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton167" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton168" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton169" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton170" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton171" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton172" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton173" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton174" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton175" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton176" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton177" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton178" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton179" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton180" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton181" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton182" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton183" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton184" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton185" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton186" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton187" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton188" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton189" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton190" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton191" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton192" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton193" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton194" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton195" onclick="visButton(5)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton196" onclick="visButton(1)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton197" onclick="visButton(2)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton198" onclick="visButton(3)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton199" onclick="visButton(4)" style="display:none;" class="btn btn-default"> Button1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton200" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton201" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton202" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton203" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton204" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton205" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton206" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton207" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton208" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton209" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton210" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton211" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton212" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton213" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton214" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton215" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton216" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton217" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton218" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton219" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton220" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton221" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton222" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton223" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton224" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton225" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton226" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton227" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton228" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton229" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton230" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton231" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton232" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton233" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton234" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton235" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton236" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton237" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton238" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton239" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton240" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton241" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton242" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton243" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton244" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton245" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton246" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton247" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton248" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton249" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton250" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton251" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton252" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton253" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton254" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton255" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton256" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton257" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton258" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton259" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton260" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton261" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton262" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton263" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton264" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton265" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton266" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton267" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton268" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton269" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton270" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton271" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton272" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton273" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton274" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton275" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton276" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton277" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton278" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton279" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton280" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton281" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton282" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton283" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton284" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton285" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton286" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton287" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton288" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton289" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton290" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton291" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton292" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton293" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton294" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton295" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton296" onclick="visButton(1)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton297" onclick="visButton(2)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton298" onclick="visButton(3)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton299" onclick="visButton(4)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="visButton300" onclick="visButton(5)" style="display:none;" class="btn btn-default"> visButton1</button>
                                    </div>
                                </div>
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
                                <table id="home" class="table table-striped table-bordered listbox-replacement-clickable"></table>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton1" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton2" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton3" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton4" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton5" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton6" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton7" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton8" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton9" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton10" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton11" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton12" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton13" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton14" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton15" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton16" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton17" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton18" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton19" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton20" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton21" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton22" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton23" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton24" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton25" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton26" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton27" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton28" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton29" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton30" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton31" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton32" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton33" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton34" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton35" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton36" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton37" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton38" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton39" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton40" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton41" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton42" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton43" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton44" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton45" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton46" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton47" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton48" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton49" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton50" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton51" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton52" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton53" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton54" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton55" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton56" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton57" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton58" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton59" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton60" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton61" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton62" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton63" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton64" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton65" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton66" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton67" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton68" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton69" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton70" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton71" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton72" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton73" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton74" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton75" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton76" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton77" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton78" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton79" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton80" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton81" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton82" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton83" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton84" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton85" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton86" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton87" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton88" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton89" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton90" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton91" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton92" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton93" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton94" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton95" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton96" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton97" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton98" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton99" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton100" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton101" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton102" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton103" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton104" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton105" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton106" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton107" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton108" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton109" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton110" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton111" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton112" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton113" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton114" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton115" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton116" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton117" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton118" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton119" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton120" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton121" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton122" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton123" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton124" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton125" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton126" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton127" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton128" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton129" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton130" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton131" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton132" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton133" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton134" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton135" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton136" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton137" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton138" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton139" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton140" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton141" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton142" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton143" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton144" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton145" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton146" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton147" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton148" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton149" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton150" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton151" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton152" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton153" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton154" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton155" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton156" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton157" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton158" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton159" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton160" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton161" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton162" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton163" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton164" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton165" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton166" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton167" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton168" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton169" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton170" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton171" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton172" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton173" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton174" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton175" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton176" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton177" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton178" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton179" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton180" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton181" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton182" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton183" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton184" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton185" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton186" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton187" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton188" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton189" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton190" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton191" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton192" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton193" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton194" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton195" onclick="playerhomeButton(5)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton196" onclick="playerhomeButton(1)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton197" onclick="playerhomeButton(2)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton198" onclick="playerhomeButton(3)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton199" onclick="playerhomeButton(4)" style="display:none;" class="btn btn-default"> homeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton200" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton201" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton202" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton203" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton204" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton205" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton206" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton207" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton208" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton209" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton210" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton211" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton212" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton213" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton214" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton215" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton216" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton217" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton218" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton219" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton220" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton221" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton222" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton223" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton224" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton225" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton226" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton227" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton228" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton229" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton230" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton231" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton232" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton233" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton234" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton235" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton236" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton237" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton238" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton239" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton240" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton241" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton242" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton243" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton244" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton245" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton246" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton247" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton248" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton249" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton250" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton251" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton252" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton253" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton254" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton255" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton256" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton257" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton258" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton259" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton260" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton261" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton262" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton263" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton264" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton265" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton266" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton267" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton268" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton269" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton270" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton271" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton272" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton273" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton274" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton275" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton276" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton277" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton278" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton279" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton280" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                       <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton281" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton282" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton283" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton284" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton285" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton286" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton287" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton288" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton289" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton290" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton291" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton292" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton293" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton294" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton295" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton296" onclick="playervishomeButton(1)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton297" onclick="playervishomeButton(2)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton298" onclick="playervishomeButton(3)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton299" onclick="playervishomeButton(4)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                    <div class="btn-group" role="group">
                                        <button type="button" id="homeButton300" onclick="playervishomeButton(5)" style="display:none;" class="btn btn-default"> vishomeButton1</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <asp:HiddenField ID="homeField" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

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