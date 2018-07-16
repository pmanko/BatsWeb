﻿<%@ Page Title="Home Page" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cbl" Inherits="pucksweb._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
      <script type="text/javascript" >
          (function (a, b) { if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) window.location = b })(navigator.userAgent || navigator.vendor || window.opera, 'https://mpucks.sydexsports.net');
        </script>
    <style>
        .input-group-addon {
    min-width:105px;
    text-align:right;
}
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
                <br />
                <br />
    <div class="container">
        <div id="sign-in">
            <h1 align="center">Welcome to Pucks Online!</h1>
            <h4>Please sign in</h4>
            <asp:label ID="Msg" CssClass="text-danger" runat="server"></asp:label>
            <div class='form-group'>
                <label for="teamDropDownList" class="sr-only">Team:</label>
                <asp:DropDownList ID="teamDropDownList" runat="server" AutoPostBack="false" class="form-control" >
                    <asp:ListItem>HALTEST</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class='form-group'>
                <label for="first_name" class="sr-only">Username:</label>
                <asp:TextBox ID="first_name" runat="server" CssClass="form-control" placeholder="Username" ></asp:TextBox>
            </div>
<%--            <div class='form-group'>
                <label for="password" class="sr-only">Last Name:</label>
                <asp:TextBox ID="last_name" runat="server" CssClass="form-control" placeholder="Last Name" ></asp:TextBox>
            </div>--%>
            <div class='form-group'>
                <label for="password" class="sr-only">Password:</label>
                <asp:TextBox ID="password" runat="server" type="password" CssClass="form-control" placeholder="Password" ></asp:TextBox>
            </div>
            <div class='checkbox checkbox-primary'><asp:CheckBox ID="rememberCheckBox" runat="server" AutoPostBack="False" Text="Remember Me" /></div>         
            <asp:Button ID="loginButton" runat="server" OnClick="loginButton_Click" Text="Sign In" class="btn btn-lg btn-primary btn-block"/>

<%--			<button type="button" class="btn btn-secondary btn-md" data-toggle="modal" data-target="#freeTrialModal">
				<span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Free Trial
			</button>--%>
            <%--<a href="#" id="login" class="btn btn-lg btn-primary btn-block">Log In</a>--%>
            <a href="/freeTrial.aspx" class="btn btn-lg btn-success btn-block">
                Sign Up For A Free Trial
            </a>
        </div>
        <div class="modal fade" id="freeTrialModal" tabindex="-1" role="dialog" aria-labelledby="freeTrialModalLabel">
          <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addClipsModalLabel">Free Trial</h4>
                <small><label>Enter your name, desired username, and email for a 30 day free trial!</label></small>
              </div>
              <div class="modal-body">
                  <div class="row">
                      <div class="col-xs-12">
                          <div class="input-group" style="width:100%">
                              <span class="input-group-addon">Name:</span>
                              <asp:TextBox ID="tbName" runat="server" CssClass="form-control" ></asp:TextBox>
                          </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-xs-12">
                          <div class="input-group" style="width:100%">
                              <span class="input-group-addon">Username:</span>
                              <asp:TextBox ID="tbUser" runat="server" CssClass="form-control" ></asp:TextBox>
                          </div>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-xs-12">
                          <div class="input-group" style="width:100%">
                              <span class="input-group-addon">Email:</span>
                              <asp:TextBox ID="tbEmail" runat="server" CssClass="form-control" ></asp:TextBox>
                          </div>
                      </div>
                  </div>
                  <div class="row">
                      <div class="col-xs-12">
                        <asp:Button ID="btnTrial" runat="server" OnClick="btnTrial_Click" Text="Submit" class="btn btn-lg btn-secondary btn-block"/>
                      </div>
                  </div>
              </div>
            </div>
          </div>
        </div>

    </div> <!-- /container -->
</asp:Content>
