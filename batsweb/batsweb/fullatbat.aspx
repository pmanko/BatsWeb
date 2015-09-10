<%@ Page AutoEventWireup="true" CodeBehind="fullatbat.aspx.cbl" Inherits="batsweb.fullatbat" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>
<html lang="'en">
<head runat="server">
    <title></title>
    <link type="text/css" href="Content/bootstrap_original.css" rel="stylesheet" />
    <link type="text/css" href="Styles/revamp.css" rel="stylesheet" />


    <script type="text/javascript" src="Scripts/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.js"></script>
    <script type="text/javascript" src="Scripts/angular.js"></script>
    <script type="text/javascript" src="Scripts/fullatbat.js"></script>
</head>
<body>
    <div class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#"><strong>BatsWeb</strong></a>
            </div>

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="mainmenu.aspx">Main Menu<span class="sr-only">(current)</span></a></li>
                    <li class="active"><a href="mainmenu.aspx">Full At-Bat</a></li>
                    <li><a href="#">Videos</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">pmanko<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">Log Out</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
    </div>

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
                                    <asp:RadioButton ID="RadioButton1" runat="server" GroupName="startDate" Text="All Games" />
                                    <asp:RadioButton ID="RadioButton2" runat="server" GroupName="startDate" Text="Start Date:" />
                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTime" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="list-group-item">
                                    <h4>End Date</h4>
                                    <asp:RadioButton ID="RadioButton3" runat="server" GroupName="endDate" Text="All Games" />
                                    <asp:RadioButton ID="RadioButton4" runat="server" GroupName="endDate" Text="End Date:" />
                                    <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:Button ID="Button3" runat="server" Text="Date One-Clicks" CssClass="btn btn-sm btn-primary" />
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
                                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:Button ID="Button1" runat="server" Text="Select Pitcher" OnClick="Button1_Click" CssClass="btn btn-primary" />

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
                                <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:Button ID="Button2" runat="server" Text="Select Batter" CssClass="btn btn-primary"/>
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
                                    <asp:CheckBoxList ID="CheckBoxList1" runat="server" CssClass="">
                                        <asp:ListItem>Maximum At Bats:</asp:ListItem>
                                        <asp:ListItem>Sort At Bats by Inning</asp:ListItem>
                                        <asp:ListItem>Sort At Bats by Batter</asp:ListItem>
                                        <asp:ListItem>Sort At Bats Oldest - Newest</asp:ListItem>
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                            
                        </div>

                    </div>
                    <div class="col-lg-9">
                        <div class="row">
                            <div class="col-lg-4">
                                <label>Result1:</label>
                                <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-lg-4">
                                <label>Runners:</label>
                                <asp:DropDownList ID="DropDownList3" runat="server" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-lg-4">
                                <label>Inn:</label>
                                <asp:DropDownList ID="DropDownList5" runat="server" OnSelectedIndexChanged="DropDownList5_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-4">
                                <label>Result2:</label>
                                <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-lg-4">
                                <label>Outs:</label>
                                <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-lg-2">
                            
                                <%--<asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>--%>
                                <asp:Button ID="Button5" runat="server" Text="Show At Bats" OnClick="Button5_Click" class="btn btn-primary"/>
                            </div>
                            <div class="col-lg-2">
                                <%--<asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>--%>
                                <asp:Button ID="Button4" runat="server" Text="Reset" class="btn btn-danger" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                    <asp:Panel ID="Panel8" runat="server" GroupingText="List of At Bats">
                        <%--<h3><strong>Double-click an at bat to show its detail</strong></h3>--%>
                        <%--<asp:Label ID="Label1" runat="server" BorderStyle="Groove" Text="Label"></asp:Label>--%>
                        <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged" CssClass="form-control"></asp:ListBox>
                        <asp:BulletedList ID="BulletedList2" runat="server" CssClass="list-group"></asp:BulletedList>

                        <asp:HiddenField ID="vid_paths" runat="server" />
                        <asp:HiddenField ID="vid_titles" runat="server" />
                        <button id="show_videos" class="btn btn-lg btn-primary">Show Videos in BatsTube</button>

                    </asp:Panel>
                    </div>
                </div>
            </asp:Panel>
        </form>
    </div>
</body>
</html>
