<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txbxUserName.Text;
        string password = Request.Form["txbxPassword"];

        Store s = StoreUtility.GetStore(username, password);

        if (s == null)
        {
            Label1.Text = "帳號或密碼不正確，請重新輸入";
        }
        else if (s.RoleID == 0)
        {
            Session["user"] = s;
            Session["email"] = s.Email;
            Session["store_id"] = s.Id;
            Session["role_id"] = s.RoleID;

            Session["ip"] = Common.GetIp();

            Response.Redirect("~/LoginM.aspx");

        }
        else
        {
            Session["user"] = s;
            Session["email"] = s.Email;
            Session["store_id"] = s.Id;
            Session["role_id"] = s.RoleID;

            Session["ip"] = Common.GetIp();

            Response.Redirect("~/Index.aspx");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="assets/images/favicon.png" />
    <title>U-HOME管理後台</title>
    <!-- Custom CSS -->
    <link href="dist/css/style.min.css" rel="stylesheet" />

    <style>
        .col-12 {
            padding-top: 30px;
        }
    </style>
</head>
<body>

    <div class="main-wrapper">
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <div class="preloader">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Login box.scss -->
        <!-- ============================================================== -->
        <div class="auth-wrapper d-flex no-block justify-content-center align-items-center bg-dark">
            <div class="auth-box bg-dark border-top border-secondary">
                <div id="loginform1">
                    <div class="text-center p-t-20 p-b-20">
                        <span class="db">
                            <img id="demoadmin" src="https://yuyen.s3.ap-southeast-1.amazonaws.com/Logo.png" alt="logo" /></span>
                    </div>
                    <!-- Form -->
                    <form class="form-horizontal m-t-20" id="loginform" runat="server">
                        <div class="row p-b-30">
                            <div class="col-12">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text bg-success text-white" id="basic-addon"><i id="demouser1" class="ti-user"></i></span>
                                    </div>
                                    <%--<input type="text" id="txbxUserName" name="txbxUserName" class="form-control form-control-lg" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1" required="" />--%>
                                    <asp:TextBox ID="txbxUserName" CssClass="form-control form-control-lg" placeholder="帳號" aria-label="Username" aria-describedby="basic-addon1" required="" runat="server"></asp:TextBox>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text bg-warning text-white" id="basic-addon2"><i id="demouser2" class="ti-pencil"></i></span>
                                    </div>
                                    <input type="password" id="txbxPassword" name="txbxPassword" class="form-control form-control-lg" placeholder="密碼" aria-label="Password" aria-describedby="basic-addon1" required="" />
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-eye" id="togglePassword" style="cursor: pointer"></i></span>
                                    </div>
                                </div>
                                <asp:Label ID="Label1" runat="server" ForeColor="Red" Font-Size="Large"></asp:Label>
                            </div>
                        </div>
                        <div class="row border-top border-secondary">
                            <div class="col-12">
                                <div class="form-group">
                                    <div class="p-t-20">
                                        <asp:LinkButton ID="btnRegister" runat="server" CssClass="btn btn-info" PostBackUrl="~/Register.aspx"><i class="fas fa-user-plus"></i>&nbsp 註冊</asp:LinkButton>
                                        <asp:Button ID="btnLogin" runat="server" Text="登入" CssClass="btn btn-success float-right" OnClick="btnLogin_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Login box.scss -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper scss in scafholding.scss -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper scss in scafholding.scss -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Right Sidebar -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Right Sidebar -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- All Required js -->
    <!-- ============================================================== -->
    <script src="assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- ============================================================== -->
    <!-- This page plugin js -->
    <!-- ============================================================== -->
    <script>

        $('[data-toggle="tooltip"]').tooltip();
        $(".preloader").fadeOut();

        const togglePassword = document.querySelector('#togglePassword');
        const password = document.querySelector('#txbxPassword');

        togglePassword.addEventListener('click', function (e) {
            // toggle the type attribute
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            // toggle the eye slash icon
            this.classList.toggle('fa-eye-slash');
        });

     


        $("#demoadmin").click(() => {
            $("#txbxUserName").val("admin");
            $("#txbxPassword").val("admin");
        });

        $("#demouser1").click(() => {
            $("#txbxUserName").val("nina");
            $("#txbxPassword").val("nina");
        });

        $("#demouser2").click(() => {
            $("#txbxUserName").val("puma01");
            $("#txbxPassword").val("12345678");
        });
    </script>


</body>
</html>
