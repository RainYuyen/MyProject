<%@ Page Language="C#" %>

<%@ Import Namespace="Google.Authenticator" %>

<!DOCTYPE html>

<script runat="server">

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        //string s = Common.GetKey(1);
        //string s = "GEZDGNBVGY";
        //List<string> strings = Common.GeneratorCurrentCode();

        //foreach (var item in strings)
        //{
        //    TextBox1.Text += item + "/";
        //}

        var isRight = false;
        TwoFactorAuthenticator tfA = new TwoFactorAuthenticator();
        isRight = tfA.ValidateTwoFactorPIN("123456", txbxKey.Text);
        string ss = isRight ? "驗證正確" : "錯誤";
        if (ss == "驗證正確")
        {
            Response.Redirect("~/Index.aspx");
        }
        else
        {
            Label1.Text = "驗證碼錯誤，請重新輸入！";
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
                            <img src="https://yuyen.s3.ap-southeast-1.amazonaws.com/Logo.png" alt="logo" /></span>
                    </div>
                    <!-- Form -->
                    <form class="form-horizontal m-t-20" id="loginform" runat="server">
                        <div class="row p-b-30">
                            <div class="col-12">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text bg-success text-white" id="basic-addon"><i class="ti-user"></i></span>
                                    </div>
                                    <asp:TextBox ID="txbxKey" CssClass="form-control form-control-lg" placeholder="請輸入Google兩步驟驗證碼" aria-label="Username" aria-describedby="basic-addon1" required="" runat="server"></asp:TextBox>
                                </div>
                                <asp:Label ID="Label1" runat="server" ForeColor="Red" Font-Size="Large"></asp:Label>
                            </div>
                        </div>
                        <div class="row border-top border-secondary">
                            <div class="col-12">
                                <div class="form-group">
                                    <div class="p-t-20">
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
        // ============================================================== 
        // Login and Recover Password 
        // ============================================================== 
        //$('#to-recover').on("click", function () {
        //    $("#loginform").slideUp();
        //    $("#recoverform").fadeIn();
        //});
        //$('#to-login').click(function () {

        //    $("#recoverform").hide();
        //    $("#loginform").fadeIn();
        //});

        const togglePassword = document.querySelector('#togglePassword');
        const password = document.querySelector('#id_password');

        togglePassword.addEventListener('click', function (e) {
            // toggle the type attribute
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            // toggle the eye slash icon
            this.classList.toggle('fa-eye-slash');
        });
    </script>


</body>
</html>
