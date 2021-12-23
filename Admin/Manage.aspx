<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

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
    <link href="assets/libs/jquery-steps/jquery.steps.css" rel="stylesheet">
    <link href="assets/libs/jquery-steps/steps.css" rel="stylesheet">
    <link href="dist/css/style.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="assets/extra-libs/multicheck/multicheck.css">
    <link href="assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/fixedheader/3.1.3/css/fixedHeader.dataTables.min.css" rel="stylesheet" />

    <style>
        table {
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto;
        }

        #sort-table thead {
            text-align: center;
        }

        #tdf {
            text-align: center;
            /*width:200px;*/
        }

        #tdname {
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <div class="container-fluid">
        <!-- ============================================================== -->
        <!-- Start Page Content -->
        <!-- ============================================================== -->
        <div class="card">
            <div class="card-body wizard-content">
                <div align="right">
                    <button type="button" id="add" name="add" data-toggle="modal" data-target="#add_data_Modal" class="btn btn-warning">新增</button>
                </div>


                <table id="sort-table" class="table table-striped table-bordered" style="width: 100%">
                    <thead style="height: 50px">
                        <tr>
                            <th style="width:30px;">商家代號</th>
                            <th>商家名稱</th>
                            <th>使用者帳號</th>
                            <th>Email</th>
                            <th>電話</th>
                            <th>地址</th>
                            <th>後台角色</th>
                            <th>功能</th>
                        </tr>

                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div id="add_data_Modal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 id="demo" class="modal-title">新增商家</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <form method="post" id="insert_form">
                        <input type="text" name="StoreName" id="StoreName" class="form-control" placeholder="商店名稱" />
                        <br />
                        <input type="text" name="Username" id="Username" class="form-control" placeholder="帳號" />
                        <br />
                        <input type="text" name="Email" id="Email" class="form-control" placeholder="Email" />
                        <br />
                        <input type="text" name="Phone" id="Phone" class="form-control" placeholder="電話" />
                        <br />
                        <label>地址</label>
                        <textarea name="Address" id="Address" class="form-control"></textarea>
                        <br />
                        <label>請選擇使用者後台角色</label>
                        <select name="Role" id="Role" class="form-control">
                            <option value="1">一般使用者</option>
                            <option value="0">管理員</option>
                        </select>
                        <br />

                        <input type="hidden" name="id" id="id" />
                        <input type="button" name="insert" id="insert" value="送出" class="btn btn-success" />
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
                </div>
            </div>
        </div>
    </div>

    <div id="edit_data_Modal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">編輯商家</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <form method="post" id="edit_form">
                        <input type="text" name="StoreName" id="editStoreName" class="form-control" placeholder="商店名稱" />
                        <br />
                        <input type="text" name="Username" id="editUsername" class="form-control" placeholder="帳號" />
                        <br />
                        <input type="text" name="Email" id="editEmail" class="form-control" placeholder="Email" />
                        <br />
                        <input type="text" name="Phone" id="editPhone" class="form-control" placeholder="電話" />
                        <br />
                        <label>地址</label>
                        <textarea name="Address" id="editAddress" class="form-control"></textarea>
                        <br />
                        <label>請選擇使用者後台角色</label>
                        <select name="Role" id="editRole" class="form-control">
                            <option value="1">一般使用者</option>
                            <option value="0">管理員</option>
                        </select>
                        <br />

                        <input type="hidden" name="id" id="editId" />
                        <input type="button" name="insert" id="btnEdit" value="送出" class="btn btn-success" />
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="JSHolder" runat="Server">

    <script src="Scripts/jquery-3.6.0.js"></script>
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
    <!-- this page js -->
    <script src="assets/libs/jquery-steps/build/jquery.steps.min.js"></script>
    <script src="assets/libs/jquery-validation/dist/jquery.validate.min.js"></script>
    <!-- this page js -->
    <script src="assets/extra-libs/multicheck/datatable-checkbox-init.js"></script>
    <script src="assets/extra-libs/multicheck/jquery.multicheck.js"></script>
    <script src="assets/extra-libs/DataTables/DataTables-1.10.16/jquery.dataTables.min.js"></script>
    <script src="assets/extra-libs/DataTables/datatables.min.js"></script>
    <script src="https://cdn.datatables.net/fixedheader/3.1.3/js/dataTables.fixedHeader.min.js"></script>



    <script type="text/javascript">

        //編輯
        function edit(id) {
            var data = { id: id }
            $.ajax({
                type: 'POST',
                url: "WebService.asmx/EditStore",
                data: JSON.stringify(data),
                contentType: "application/json;utf-8",
                dataType: "JSON",
                success: function (result) {

                    $('#editStoreName').val(result.d.StoreName);
                    $('#editUsername').val(result.d.UserName);
                    $('#editEmail').val(result.d.Email);
                    $('#editPhone').val(result.d.Phone);
                    $('#editAddress').val(result.d.Address);
                    $('#editRole').val(result.d.RoleID);
                    $('#editId').val(result.d.Id);

                    $('#edit_data_Modal').modal('show');
                }
            });
        };

        //編輯資料送回DB
        $('#btnEdit').click(function () {

            var data = {
                id: $("#editId").val(),
                storename: $('#editStoreName').val(),
                username: $('#editUsername').val(),
                email: $("#editEmail").val(),
                phone: $("#editPhone").val(),
                address: $("#editAddress").val(),
                roleid: $("#editRole").val()
            }

            $.ajax({
                type: 'POST',
                url: "WebService.asmx/UpdateStore",
                data: JSON.stringify(data),
                contentType: "application/json;utf-8",
                dataType: "JSON",
                success: function (result) {
                    //alert("done");
                    Swal.fire(
                        '修改完成',
                        '資料已成功修改',
                        'success'
                    )
                    load();
                    $('#edit_data_Modal').modal('hide');
                    $('body').removeClass('modal-open');
                    $('.modal-backdrop').remove();


                }
            });

        });

        //刪除
        function deleteStore(id) {

            var data = { id: id }

            Swal.fire({
                title: '確定要刪除嗎？',
                showDenyButton: true,
                confirmButtonText: '刪除',
                denyButtonText: `取消`,
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: 'POST',
                        url: "WebService.asmx/DeleteStore",
                        data: JSON.stringify(data),
                        contentType: "application/json;utf-8",
                        dataType: "JSON",
                        success: function (result) {
                            Swal.fire('成功', '資料已經刪除', 'success')
                            load();
                        }
                    });
                } else if (result.isDenied) {
                    Swal.fire('失敗', '資料沒有刪除喔( ×ω× )', 'error')
                }
            })



        }

        //新增
        $("#insert").click(() => {
            var data = {
                Username: $('#Username').val(),
                Email: $('#Email').val(),
                StoreName: $("#StoreName").val(),
                Phone: $("#Phone").val(),
                Address: $("#Address").val(),
                Role: $("#Role").val()
            }

            if ($('#StoreName').val() == "" || $('#Username').val() == '' || $('#Email').val() == '') {

                Swal.fire(
                    '必填項目未填',
                    '商店名稱、使用者名稱跟Email三項為必填欄位',
                    'warning'
                )
                $('#add_data_Modal').modal('show');

            } else {
                $.ajax({
                    type: 'POST',
                    url: "WebService.asmx/AddStore",
                    data: JSON.stringify(data),
                    contentType: "application/json;utf-8",
                    dataType: "JSON",
                    success: function (result) {
                        Swal.fire(
                            '新增成功',
                            '預設密碼12345678，請提醒商家盡快進入後台修改',
                            'success'
                        )

                        $('#add_data_Modal').modal('hide');
                        $('body').removeClass('modal-open');
                        $('.modal-backdrop').remove();
                        load();
                    }
                });
            }
        });


    </script>

    <script type="text/javascript">

        $(document).ready(load);

        //查全部
        function load() {
            $.ajax({
                type: "POST",
                url: "WebService.asmx/GetData",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //console.log(response.d);
                    var xmlDoc = $.parseXML(response.d);
                    var xml = $(xmlDoc);
                    var customers = xml.find("Table");
                    var rows = '';
                    $('#sort-table tbody').empty();
                    $.each(customers, function () {
                        var id = $(this).find("Id").text();
                        var storename = $(this).find("Store_Name").text();
                        var username = $(this).find("UserName").text();
                        var email = $(this).find("Email").text();
                        var phone = $(this).find("Phone").text();
                        var address = $(this).find("Address").text();
                        var rolename = $(this).find("Role_Name").text() == "Admin" ? "管理員" : "一般使用者";
                        rows += `<tr><td id="tdname">${id}</td><td>${storename}</td><td>${username}</td><td>${email}</td><td>${phone}</td><td>${address}</td><td id="tdname">${rolename}</td><td id="tdf"><input type="button" id="${id}" name="btnEdit" data-toggle="modal" data-target="#edit_data_Modal" class="btn btn-info" onclick="edit(${id})" value="編輯" />  <input type="button" id="btnDel" name="btnDel" class="btn btn-danger" onclick="deleteStore(${id})" value="刪除" /></td></tr>`
                    });
                    $('#sort-table').append(rows);
                    $('#sort-table').DataTable({
                        //bSortClasses: true,
                        stateSave: true,
                        retrieve: true,
                        "bInfo": false

                    });
                },
                error: function (response) {
                    var r = jQuery.parseJSON(response.responseText);
                    alert("Message: " + r.Message);
                }
            });

        }



        $("#demo").click(() => {
            //alert(123)
            $('#StoreName').val('PUMA');
            $('#Username').val('puma01');
            $('#Email').val('puma@msn.com');
            $('#Phone').val('0282629999');
            $('#Address').val('桃園市中壢區永昌路21號');

        });

    </script>


</asp:Content>
