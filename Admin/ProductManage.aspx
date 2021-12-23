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
                    <button type="button" id="add" name="add" data-toggle="modal" data-target="#add_data_Modal" class="btn btn-warning">新增商品</button>
                </div>


                <table id="sort-table" class="table table-bordered display" style="width: 100%">
                    <thead style="height: 50px">
                        <tr>
                            <th style="width: 20px;">#</th>
                            <th>商品名稱</th>
                            <th>價格</th>
                            <th>商品圖片</th>
                            <th>商品敘述</th>
                            <th>商品分類</th>
                            <th style="width: 120px;">功能</th>
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
                    <h4 id="demo" class="modal-title">新增商品</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <form method="post" id="insert_form">
                        <input type="text" name="Name" id="Name" class="form-control" placeholder="商品名稱" />
                        <br />
                        <input type="number" name="Price" id="Price" class="form-control" placeholder="價格" />
                        <br />
                        <input type="text" name="ImageFileName" id="ImageFileName" hidden="hidden" />

                        <div class="row form-group">&nbsp&nbsp&nbsp
                            <input type="file" name="file" id="file" />
                            <div id="fileName"></div>
                            <div id="fileSize"></div>
                            <div id="fileType"></div>
                            <div class="row">
                                <input type="button" onclick="uploadFile()" value="上傳" />
                            </div>
                        </div>

                        <br />
                        <label>商品敘述</label>
                        <textarea name="Info" id="Info" class="form-control"></textarea>
                        <br />
                        <label>商品分類</label>
                        <select name="Category" id="Category" class="form-control">
                            <option value="1">男鞋</option>
                            <option value="2">女鞋</option>
                            <option value="3">童鞋</option>
                        </select>
                        <br />

                        <input type="hidden" name="id" id="Id" />
                        <input type="button" name="insert" id="btnAdd" value="確認" class="btn btn-success" />
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
                    <h4 class="modal-title">編輯商品</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <form method="post" id="edit_form">
                        <input type="text" name="Name" id="editName" class="form-control" placeholder="商品名稱" />
                        <br />
                        <input type="number" name="Price" id="editPrice" class="form-control" placeholder="價格" />
                        <br />
                        <input type="text" name="ImageFileName" id="editImageFileName" class="form-control" placeholder="商品圖片" />
                        <br />
                        <label>商品敘述</label>
                        <textarea name="Info" id="editInfo" class="form-control"></textarea>
                        <br />
                        <label>商品分類</label>
                        <select name="Category" id="editCategory" class="form-control">
                            <option value="1">男鞋</option>
                            <option value="2">女鞋</option>
                            <option value="3">童鞋</option>
                        </select>
                        <br />

                        <input type="hidden" name="id" id="editId" />
                        <input type="button" name="insert" id="btnEdit" value="確認" class="btn btn-success" />
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

        //編輯
        function edit(id) {
            var data = { id: id }
            $.ajax({
                type: 'POST',
                url: "WebService.asmx/EditProd",
                data: JSON.stringify(data),
                contentType: "application/json;utf-8",
                dataType: "JSON",
                success: function (result) {

                    $('#editName').val(result.d.Name);
                    $('#editPrice').val(result.d.Price);
                    $('#editImageFileName').val(result.d.ImageFileName);

                    //$('#editInfo').val(result.d.Info);
                    $('#editInfo').trumbowyg('html', result.d.Info);

                    $('#editCategory').val(result.d.Category_Id);
                    $('#editId').val(result.d.Id);

                    $('#edit_data_Modal').modal('show');
                }
            });
        };

        //編輯資料送回DB
        $('#btnEdit').click(function () {

            var data = {
                id: $("#editId").val(),
                name: $("#editName").val(),
                price: $('#editPrice').val(),
                imagefilename: $('#editImageFileName').val(),
                info: $("#editInfo").val(),
                category: $("#editCategory").val()
            }

            $.ajax({
                type: 'POST',
                url: "WebService.asmx/UpdateProd",
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
                        url: "WebService.asmx/DeleteProd",
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
        $("#btnAdd").click(() => {
            $("#modal-body").empty();
            var data = {
                name: $('#Name').val(),
                price: $('#Price').val(),
                imagefilename: document.getElementById("ImageFileName").value,
                info: $("#Info").val(),
                category: $("#Category").val()
            }

            if ($('#Name').val() == "" || $('#Price').val() == '' || $('#ImageFileName').val() == '' || $('#Info').val() == '' || $('#Category').val() == '') {

                Swal.fire(
                    '必填項目未填',
                    '每一項皆為必填欄位',
                    'warning'
                )
                $('#add_data_Modal').modal('show');

            } else {
                $.ajax({
                    type: 'POST',
                    url: "WebService.asmx/AddProd",
                    data: JSON.stringify(data),
                    contentType: "application/json;utf-8",
                    dataType: "JSON",
                    success: function (result) {
                        Swal.fire(
                            '新增成功',
                            '資料新增成功',
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

        //上傳圖片
        function uploadFile() {
            //https://yuyen.s3.ap-southeast-1.amazonaws.com/1639577651560-6.jpg
            var file = document.getElementById('file').files[0];
            var fd = new FormData();

            var key = (new Date).getTime() + '-' + file.name;

            document.getElementById("ImageFileName").value = key;

            fd.append('key', key);
            fd.append('Content-Type', file.type);

            fd.append("file", file);

            var xhr = new XMLHttpRequest();

            xhr.addEventListener("load", uploadComplete, false);

            xhr.open('POST', 'https://yuyen.s3.ap-southeast-1.amazonaws.com/', true); //MUST BE LAST LINE BEFORE YOU SEND
            xhr.setRequestHeader('Access-Control-Allow-Origin', '*');
            xhr.setRequestHeader('Access-Control-Allow-Headers', '*');
            xhr.send(fd);
        }
        //Helper
        function uploadComplete(evt) {
            Swal.fire('成功', '圖片上傳成功', 'success')
        }

    </script>

    <script type="text/javascript">

        $(document).ready(load);

        //查全部
        function load() {
            $.ajax({
                type: "POST",
                url: "WebService.asmx/GetProdDataUser",
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
                        var name = $(this).find("Name").text();
                        var price = $(this).find("Price").text();
                        var imgfilename = $(this).find("ImageFileName").text();
                        var info = $(this).find("Info").text();
                        //var storeid = $(this).find("Store_Id").text();
                        var category = $(this).find("Category_Name").text();
                        rows += `<tr><td id="tdname">${id}</td><td>${name}</td><td>${price}</td><td><img width="150" src="https://yuyen.s3.ap-southeast-1.amazonaws.com/${imgfilename}"></td><td>${info}</td><td>${category}</td><td id="tdf"><input type="button" id="${id}" name="btnEdit" data-toggle="modal" data-target="#edit_data_Modal" class="btn btn-info" onclick="edit(${id})" value="編輯" />  <input type="button" id="btnDel" name="btnDel" class="btn btn-danger" onclick="deleteStore(${id})" value="刪除" /></td></tr>`
                    });
                    $('#sort-table').append(rows);
                    $('#sort-table').DataTable({
                        fixedHeader: { header: true },
                        bSortClasses: true,
                        stateSave: true,
                        retrieve: true,
                        "info": false
                    });
                },
                error: function (response) {
                    var r = jQuery.parseJSON(response.responseText);
                    alert("Message: " + r.Message);
                }
            });

        }
        $('#editInfo').trumbowyg({
            btns: [
                ['viewHTML'],
                ['formatting'],
                ['strong', 'em', 'del'],
                ['justifyLeft', 'justifyCenter', 'justifyRight'],
                ['unorderedList', 'orderedList'],
                ['fullscreen']
            ]
        });

        $('#Info').trumbowyg({
            btns: [
                ['viewHTML'],
                ['formatting'],
                ['strong', 'em', 'del'],
                ['justifyLeft', 'justifyCenter', 'justifyRight'],
                ['unorderedList', 'orderedList'],
                ['fullscreen']
            ]
        });


        $("#demo").click(() => {
            //alert(123)
            $('#Name').val('Puma 慢跑鞋 Enzo 2 Uncaged 運動 男鞋');
            $('#Price').val('1980');
            $('#Info').trumbowyg('html', '品牌: PUMA<br/>型號: 19510501<br/>品名: Enzo 2 Uncaged<br/>配色: BLACK WHITE<br/>特點: 襪套 輕量 透氣 舒適 避震 球鞋 穿搭 黑 白');

        });
    </script>


</asp:Content>
