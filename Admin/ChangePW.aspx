﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

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
                    <form class="form-horizontal">
                        <div class="card-body">
                            <h4 id="demo" class="card-title">修改密碼</h4>
                            <div class="form-group row">
                                <label for="storename" class="col-sm-3 text-right control-label col-form-label">商家名稱</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="storename" readonly="readonly">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="username" class="col-sm-3 text-right control-label col-form-label">帳號</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="username" readonly="readonly">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="password" class="col-sm-3 text-right control-label col-form-label">密碼</label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" id="password" placeholder="如不修改請忽略">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="password2" class="col-sm-3 text-right control-label col-form-label">確認密碼</label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" id="password2" placeholder="如不修改請忽略">
                                </div>
                            </div>

                        </div>
                        <div class="border-top">
                            <div class="card-body" style="float: right">
                                <button type="button" class="btn btn-primary" id="save">儲存</button>
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

    <script>

        $(() => {
            load()
        });


        $("#save").click(() => {
            var data = {
                password: $("#password").val(),
            }

            if ($("#password").val() == "") {
                Swal.fire(
                    '請輸入密碼',
                    '(つ´ω`)つ如果要修改密碼，要記得輸入喔',
                    'warning'
                )
            } else if ($("#password").val() !== $("#password2").val()) {
                Swal.fire(
                    '兩次密碼要相同',
                    '兩次密碼要一樣（連大小寫都要喔）♡(｡•ㅅ•｡)',
                    'warning'
                )
            } else {
                $.ajax({
                    type: 'POST',
                    url: "WebService.asmx/UpdatePassword",
                    data: JSON.stringify(data),
                    contentType: "application/json;utf-8",
                    dataType: "JSON",
                    success: function (result) {
                        Swal.fire(
                            '修改成功',
                            "",
                            'success'
                        )
                        load();
                    }
                });
            }

        });


        //查回storename跟username
        function load() {
            $.ajax({
                type: 'POST',
                url: "WebService.asmx/GetStore",
                contentType: "application/json;utf-8",
                dataType: "JSON",
                success: function (result) {
                    $('#storename').val(result.d.StoreName);
                    $('#username').val(result.d.UserName);
                }
            });
        }

        $("#demo").click(() => {
        });
    </script>

</asp:Content>

