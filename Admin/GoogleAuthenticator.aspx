<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>


<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        txbxUsername.Text = Session["email"].ToString();
    }




</script>

<asp:Content ID="Content1" ContentPlaceHolderID="CSSHolder" runat="Server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="assets/images/favicon.png">
    <title>U-HOME管理後台</title>
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="assets/libs/select2/dist/css/select2.min.css">
    <link rel="stylesheet" type="text/css" href="assets/libs/jquery-minicolors/jquery.minicolors.css">
    <link rel="stylesheet" type="text/css" href="assets/libs/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" type="text/css" href="assets/libs/quill/dist/quill.snow.css">
    <link href="dist/css/style.min.css" rel="stylesheet">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <div class="container">
        <br />
        <br />
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <form class="form-horizontal" runat="server">
                        <div class="card-body">
                            <h4 class="card-title">Google兩步驟驗證綁定</h4>
                            <div class="form-group row">
                                <label for="username" class="col-sm-3 text-right control-label col-form-label">使用者Email</label>
                                <div class="col-sm-9">
                                    <%--<input type="text" class="form-control" id="username">--%>
                                    <asp:TextBox ID="txbxUsername" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">

                                <label for="key" class="col-sm-3 text-right control-label col-form-label">密鑰</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="key" readonly="readonly">
                                </div>
                                <br />
                                <br />
                                <label class="col-sm-3 text-right control-label col-form-label">產生的QRCode</label>

                                <div style="margin: auto;" id="qrcode"></div>
                            </div>

                        </div>
                        <div class="border-top">
                            <div class="card-body" style="float: right">
                                <button type="button" class="btn btn-primary" id="save">產生</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="JSHolder" runat="Server">
    <script src="assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script src="assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
    <script src="assets/extra-libs/sparkline/sparkline.js"></script>
    <!--Wave Effects -->
    <script src="dist/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="dist/js/custom.min.js"></script>
    <!-- This Page JS -->
    <script src="assets/libs/inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
    <script src="dist/js/pages/mask/mask.init.js"></script>
    <script src="assets/libs/select2/dist/js/select2.full.min.js"></script>
    <script src="assets/libs/select2/dist/js/select2.min.js"></script>
    <script src="assets/libs/jquery-asColor/dist/jquery-asColor.min.js"></script>
    <script src="assets/libs/jquery-asGradient/dist/jquery-asGradient.js"></script>
    <script src="assets/libs/jquery-asColorPicker/dist/jquery-asColorPicker.min.js"></script>
    <script src="assets/libs/jquery-minicolors/jquery.minicolors.min.js"></script>
    <script src="assets/libs/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
    <script src="assets/libs/quill/dist/quill.min.js"></script>
    <script src="dist/js/jquery-qrcode.js"></script>

    <script>
        //$("#qrcode-canvas").qrcode({
        //    render: 'canvas',
        //    size: 250,
        //    text: 'https://mnya.tw/'
        //});

        $(() => {

            //jquery('#qrcode').qrcode("this plugin is great");



            $("#save").click(() => {
                //alert(123);

                $.ajax({
                    type: "POST",
                    url: "WebService.asmx/getKey",
                   /* data: JSON.stringify(mydata),*/
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        $("#qrcode").empty();
                        console.log(result.d)
                        $('#key').val(result.d);
                        $("#qrcode").qrcode({
                            render: 'image',
                            size: 250,
                            text: result.d
                        });


                    }
                });



            });

        });



    </script>

</asp:Content>

