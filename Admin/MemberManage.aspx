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
    <link href="dist/css/trumbowyg.min.css" rel="stylesheet" />


    <style>

        thead, #tdname, #tdgender, #status, #tdfunctuon {
            text-align: center;
        }
        #tdfunctuon{
            width:250px;
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
                <table id="sort-table" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th style="width:30px;">會員編號</th>
                            <th>會員帳號</th>
                            <th>Email</th>
                            <th>電話</th>
                            <th>地址</th>
                            <th style="width:30px">性別</th>
                            <th>使用狀態</th>
                            <th>備註</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <div id="edit_data_Modal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 id="demo" class="modal-title">編輯會員</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <form method="post" id="edit_form">
                        <input type="text" name="id" id="editId" class="form-control" readonly="readonly" />
                        <br />
                        <input type="text" name="Email" id="editEmail" class="form-control" placeholder="Email" />
                        <br />
                        <input type="text" name="Phone" id="editPhone" class="form-control" placeholder="電話" />
                        <br />
                        <label>地址</label>
                        <textarea name="Address" id="editAddress" class="form-control"></textarea>
                        <br />
                        <label>備註</label>
                        <textarea name="Note" id="editNote" class="form-control"></textarea>
                        <br />

                        <input type="button" name="insert" id="btnEdit" value="儲存" class="btn btn-success" />
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
    <script src="dist/js/trumbowyg.min.js"></script>
    <script src="dist/js/trumbowyg.allowtagsfrompaste.min.js"></script>
    <script src="dist/js/trumbowyg.preformatted.min.js"></script>




    <script type="text/javascript">
        $.trumbowyg.svgPath = '/dist/ui/icons.svg';


        $(document).ready(load);

        //查全部
        function load() {
            $.ajax({
                type: "POST",
                url: "WebService.asmx/GetMemberData",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(response.d);
                    var xmlDoc = $.parseXML(response.d);
                    var xml = $(xmlDoc);
                    var customers = xml.find("Table");
                    var rows = '';
                    $('#sort-table tbody').empty();
                    $.each(customers, function () {
                        var id = $(this).find("Id").text();
                        var username = $(this).find("UserName").text();
                        var email = $(this).find("Email").text();
                        var phone = $(this).find("Phone").text();
                        var address = $(this).find("Address").text();
                        var gender = $(this).find("Gender").text();
                        //var status = $(this).find("Status").text();
                        var status = $(this).find("Status").text() == 0 ? "註銷" : "正常使用中";
                        var note = $(this).find("Note").text();
                        rows += `<tr><td id="tdname">${id}</td>
                                     <td id="tdusername">${username}</td>
                                     <td id="tdemail">${email}</td>
                                     <td id="tdphone">${phone}</td>
                                     <td id="tdaddress">${address}</td>
                                     <td id="tdgender">${gender}</td>
                                     <td id="tdstatus">${status}</td>
                                     <td id="tdnote">${note}</td>
                                     <td id="tdfunctuon"><input type="button" class="btn btn-danger" style="border-radius: 20px" value="註銷" onclick="cancelled(${id})"> 
                                                         <input type="button" class="btn btn-success" style="border-radius: 20px" value="開啟" onclick="reopen(${id})"> 
                                                         <input type="button" class="btn btn-primary" style="border-radius: 20px" value="編輯" onclick="edit(${id})"></td></tr>`
                    });
                    $('#sort-table').append(rows);
                    $('#sort-table').DataTable({
                        //bSortClasses: true,
                        stateSave: true,
                        retrieve: true
                    });
                },
                error: function (response) {
                    var r = jQuery.parseJSON(response.responseText);
                    alert("Message: " + r.Message);
                }
            });

        }

        //編輯
        function edit(id) {
            var data = { id: id }
            $.ajax({
                type: 'POST',
                url: "WebService.asmx/EditMember",
                data: JSON.stringify(data),
                contentType: "application/json;utf-8",
                dataType: "JSON",
                success: function (result) {
                    console.log(result.d);
                    $('#editId').val(result.d.Id);
                    $('#editEmail').val(result.d.Email);
                    $('#editPhone').val(result.d.Phone);
                    $('#editAddress').val(result.d.Address);
                    //$('#editNote').val(result.d.Note);
                    $('#editNote').trumbowyg('html', result.d.Note);


                    $('#edit_data_Modal').modal('show');
                }
            });
        };

        //編輯資料送回DB
        $('#btnEdit').click(function () {

            var data = {
                id: $("#editId").val(),
                email: $('#editEmail').val(),
                phone: $('#editPhone').val(),
                address: $("#editAddress").val(),
                note: $("#editNote").val(),
            }

            $.ajax({
                type: 'POST',
                url: "WebService.asmx/UpdateMember",
                data: JSON.stringify(data),
                contentType: "application/json;utf-8",
                dataType: "JSON",
                success: function (result) {
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


        //註銷
        function cancelled(id) {
            var data = { id: id }

            Swal.fire({
                title: `確定要註銷${id}號帳號嗎？`,
                showDenyButton: true,
                confirmButtonText: '確定',
                denyButtonText: '取消',
                icon: 'question',
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: 'POST',
                        url: "WebService.asmx/CancelMember",
                        data: JSON.stringify(data),
                        contentType: "application/json;utf-8",
                        dataType: "JSON",
                        success: function (result) {
                            Swal.fire('成功註銷', '帳號已經註銷（請提醒客戶登出後無法登入）', 'success')
                            load();
                        }
                    });
                } else if (result.isDenied) {
                    Swal.fire('失敗', '沒有註銷成功喔( ×ω× )', 'error')
                }
            })

        };
        //開啟
        function reopen(id) {
            var data = { id: id }

            Swal.fire({
                title: `確定要開啟${id}號帳號嗎？`,
                showDenyButton: true,
                confirmButtonText: '確定',
                denyButtonText: '取消',
                icon: 'question',
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: 'POST',
                        url: "WebService.asmx/ReopenMember",
                        data: JSON.stringify(data),
                        contentType: "application/json;utf-8",
                        dataType: "JSON",
                        success: function (result) {
                            Swal.fire('成功開啟', '帳號已經重新開啟（請提醒客戶3-5分鐘後再登入）', 'success')
                            load();
                        }
                    });
                } else if (result.isDenied) {
                    Swal.fire('失敗', '沒有開啟成功喔( ×ω× )', 'error')
                }
            })

        };

        $("#editNote").trumbowyg({
            btns: [
                ['viewHTML'],
                ['strong', 'em', 'del'],
                ['unorderedList', 'orderedList'],
                ['fullscreen']
            ]
        });



        $("#demo").click(() => {
            //alert(123)
            $('#editEmail').val("user1224@gmail.com");
            $('#editPhone').val("0912999999");
            $('#editAddress').val("苗栗縣三義鄉復興路19號");
            $('#editNote').trumbowyg("html","黃金會員<br/> 可以介紹童鞋");
        });
    </script>


</asp:Content>
