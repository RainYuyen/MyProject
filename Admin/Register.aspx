<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txbxUserName.Text) || string.IsNullOrEmpty(txbxEmail.Text) || string.IsNullOrEmpty(txbxPassword.Text) || string.IsNullOrEmpty(txbxPassword2.Text))
        {
            Label1.Text = "每個欄位皆須填入資料";
        }
        else
        {
            Store s = new Store(
                txbxUserName.Text,
                txbxPassword.Text,
                txbxEmail.Text);

            StoreUtility.Add(s);
            Response.Redirect("~/Login.aspx");

        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />--%>
    <meta charset="utf-8" />
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
    <%--<form id="form1" runat="server">--%>
    <div>

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
                    <div>
                        <div class="text-center p-t-20 p-b-20">
                            <span class="db">
                                <img src="https://yuyen.s3.ap-southeast-1.amazonaws.com/Logo.png" alt="logo" /></span>
                        </div>
                        <!-- Form -->
                        <form class="form-horizontal m-t-20" runat="server">
                            <div class="row p-b-30">
                                <div class="col-12">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-success text-white" id="basic-addon1"><i class="ti-user"></i></span>
                                        </div>
                                        <asp:TextBox ID="txbxUserName" runat="server" CssClass="form-control form-control-lg" placeholder="帳號"></asp:TextBox>
                                    </div>
                                    <!-- email -->
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-danger text-white" id="basic-addon2"><i class="ti-email"></i></span>
                                        </div>
                                        <asp:TextBox ID="txbxEmail" TextMode="Email" runat="server" CssClass="form-control form-control-lg" placeholder="Email"></asp:TextBox>
                                    </div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-warning text-white" id="basic-addon3"><i class="ti-pencil"></i></span>
                                        </div>
                                        <asp:TextBox TextMode="Password" ID="txbxPassword" runat="server" CssClass="form-control form-control-lg" placeholder="密碼"></asp:TextBox>
                                    </div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-info text-white" id="basic-addon4"><i class="ti-pencil"></i></span>
                                        </div>
                                        <%--<input type="text" class="form-control form-control-lg" placeholder=" Confirm Password" aria-label="Password" aria-describedby="basic-addon1" required />--%>
                                        <asp:TextBox TextMode="Password" ID="txbxPassword2" runat="server" CssClass="form-control form-control-lg" placeholder="確認密碼"></asp:TextBox>
                                    </div>
                                    <asp:Label ID="Label1" runat="server" ForeColor="Red" Font-Size="Large"></asp:Label>
                                    <br />
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="兩次密碼輸入要一致" ControlToCompare="txbxPassword" ControlToValidate="txbxPassword2" Font-Size="Large" ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                                </div>
                            </div>
                            <div class="row border-top border-secondary">
                                <div class="col-12">
                                    <div class="form-group">
                                        <div class="p-t-20">
                                            <%--<button class="btn btn-block btn-lg btn-info" type="submit">Sign Up</button>--%>
                                            <asp:Button ID="btnSubmit" runat="server" Text="註冊" CssClass="btn btn-block btn-lg btn-info" OnClick="btnSubmit_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
        <!-- ============================================================== -->
        <!-- All Required js -->
        <!-- ============================================================== -->
        <script src="assets/libs/jquery/dist/jquery.min.js"></script>
        <!-- Bootstrap tether Core JavaScript -->
        <script src="assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="assets/libs/popper.js/dist/umd/popper.min.js"></script>
        <!-- ============================================================== -->
        <!-- This page plugin js -->
        <!-- ============================================================== -->
        <script>
            $(".preloader").fadeOut();
        </script>


    </div>
</body>
</html>
