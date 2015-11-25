<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="summaryatbatdetail.aspx.cbl" Inherits="batsweb.atbatdetail" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="Scripts/callBatstube.js"></script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Panel ID="Panel6" runat="server" >
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="row"><div class="col-md-12"><h4><asp:Literal ID="gameDateAt" runat="server"></asp:Literal></h4></div></div>
                            <div class="row">
                                <div class="col-md-6">
                                    <table class="table table-bordered table-hover">
                                      <thead>
                                          <tr>
                                              <th>Inning: <asp:Literal ID="inning" runat="server"></asp:Literal></th>
                                              <th>R</th>
                                              <th>H</th>
                                              <th>E</th>
                                          </tr>
                                      </thead>  
                                      <tbody>
                                          <tr>
                                            <th scope="row"><asp:Literal ID="homeTeam" runat="server"></asp:Literal></th>
                                            <td><asp:Literal ID="homeScore" runat="server"></asp:Literal></td>
                                            <td></td>
                                            <td></td>
                                          </tr>
                                          <tr>
                                            <th scope="row"><asp:Literal ID="visTeam" runat="server"></asp:Literal></th>
                                            <td><asp:Literal ID="visScore" runat="server"></asp:Literal></td>
                                            <td></td>
                                            <td></td>                                          
                                          </tr>
                                      </tbody>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <dl class="dl-horizontal">
                                        <dt>Currently Batting:</dt>
                                        <dd><asp:Literal id="currentlyBatting" runat="server"></asp:Literal></dd>

                                        <dt>Pitcher:</dt>
                                        <dd><asp:Literal ID="pitcher" runat="server"></asp:Literal></dd>

                                        <dt>Batter:</dt>
                                        <dd><asp:Literal ID="batter" runat="server"></asp:Literal></dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-md-3"><h4>Date: <asp:Literal ID="gameDateB" runat="server"></asp:Literal> </h4></div>
                                <div class="col-md-5"><h4><asp:Literal ID="visTeamB" runat="server"></asp:Literal> (<asp:Literal ID="visScoreB" runat="server"></asp:Literal>) at <asp:Literal ID="homeTeamB" runat="server"></asp:Literal> (<asp:Literal ID="homeScoreB" runat="server"></asp:Literal>)</h4></div>
                                <div class="col-md-2">
                                    <dl class="dl-horizontal">
                                        <dt>Inning:</dt>
                                        <dd><asp:Literal runat="server" id="inningB"></asp:Literal></dd>
                                        <dt>Currently Batting:</dt>
                                        <dd><asp:Literal runat="server" ID="currentlyBattingB"></asp:Literal></dd>
                                    </dl>
                                </div>
                            </div>
                        </div> 
                    
                    </div>


                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class='form-horizontal'>
                                <div class='row'>

                                    <label class='control-label col-md-2'>Pitcher:</label>
                                    <div class='col-md-4'> <asp:TextBox ID="pitcherTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox></div>                                    
                                    <label class='control-label col-md-2'>Batter:</label>
                                    <div class='col-md-4'> <asp:TextBox ID="batterTextBox" runat="server" class="form-control" ReadOnly="true"></asp:TextBox></div>
                                </div>
                            </div>                            

                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-4">
                                    <asp:ImageButton ID="szoneImageButton" runat="server" OnClick="szoneImageButton_Click" src="gamesummaryszone.aspx" alt="image could not be displayed refresh"/>
                                </div>
                                <div class="col-lg-4">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <asp:Label ID="headerLabel" runat="server" BorderStyle="Groove" Text="## Type Location K Vel * Vid" Font-Bold="True" Font-Names="Consolas" Font-Size="Medium" class="form-control"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <asp:ListBox ID="ListBox1" runat="server" Height="160px" Font-Bold="True" Font-Names="Consolas" Font-Size="Medium" class="form-control"></asp:ListBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-lg-offset-1">
                                    <asp:Image ID="runnersImage" runat="server" src="summaryrunners.aspx" alt="image could not be displayed refresh"/>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="row">
                                        <div class="col-lg-3 text-right" >
                                            <strong><asp:Label ID="Label1" runat="server" Text="Outs:"></asp:Label></strong>
                                        </div>
                                        <div class="col-lg-9">
                                            <asp:Label ID="outsLabel" runat="server" ></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3  text-right">
                                            <strong>Hit Type:</strong>
                                        </div>
                                        <div class="col-lg-9">
                                            <asp:Label ID="hitLabel" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3 text-right" >
                                            <strong>Result:</strong>
                                        </div>
                                        <div class="col-lg-9">
                                            <asp:Label ID="resultLabel" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3 text-right" >
                                            <strong>Final Count:</strong>
                                        </div>
                                        <div class="col-lg-9">
                                            <asp:Label ID="countLabel" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3 text-right" >
                                            <strong>RBI:</strong>
                                        </div>
                                        <div class="col-lg-9">
                                            <asp:Label ID="rbiLabel" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3 text-right" >
                                            <strong>Fielded By(1):</strong>
                                        </div>
                                        <div class="col-lg-1" >
                                            <asp:Label ID="posLabel1" runat="server"></asp:Label>       
                                        </div>
                                        <div class="col-lg-3" >
                                            &vert;
                                            <asp:Label ID="fieldedLabel1" runat="server"></asp:Label>
                                        </div>
                                        <div class="col-lg-5" >
                                            &vert;
                                            <asp:Label ID="flagLabel1" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3 text-right" >
                                            <strong>Fielded By(2):</strong>
                                        </div>
                                        <div class="col-lg-1" >
                                            <asp:Label ID="posLabel2" runat="server"></asp:Label>
                                        </div>
                                        <div class="col-lg-3" >
                                            &vert;
                                            <asp:Label ID="fieldedLabel2" runat="server"></asp:Label>
                                        </div>
                                        <div class="col-lg-5" >
                                            &vert;
                                            <asp:Label ID="flagLabel2" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3 text-right" >
                                            <strong>Catcher:</strong>
                                        </div>
                                        <div class="col-lg-9" >
                                            <asp:Label ID="catcherLabel" runat="server"></asp:Label>  
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <asp:Image ID="parkImage" runat="server" src="summarypark.aspx" alt="image could not be displayed refresh"/>
                                </div>
                            </div>
                        </div>
                    </div>
            </asp:Panel>
        </form>
    </div>
</asp:Content>
