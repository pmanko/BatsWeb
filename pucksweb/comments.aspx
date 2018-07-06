<%@ Page MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="comments.aspx.cbl" Inherits="pucksweb.comments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .input-group-addon {
            min-width:105px;
            text-align:right;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main-container">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="panel panel-primary" id="selectionPanel">
            <div class="panel-heading">
                Comments
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="input-group">
                            <span class="input-group-addon">Name:</span>
                            <asp:TextBox ID="tbName" runat="server" class="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="input-group">
                            <span class="input-group-addon">Email:</span>
                            <asp:TextBox ID="tbEmail" runat="server" class="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="input-group">
                            <span class="input-group-addon">Comment:</span>
                            <asp:TextBox ID="tbComment" runat="server" class="form-control" Textmode="MultiLine" Rows="20"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <div class="row">
                    <div class="col-xs-12">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" class="btn btn-lg center-block btn-primary"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
