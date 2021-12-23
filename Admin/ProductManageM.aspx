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
                    <div>

                    </div>
                    <br />
                    <table id="sort-table" class="table table-bordered display">
                        <thead>
                            <tr>
                                <th style="width:20px;">#</th>
                                <th>商品名稱</th>
                                <th>價格</th>
                                <th>商品圖片</th>
                                <th>商品敘述</th>
                                <th>店家資訊</th>
                                <th>分類</th>
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
                    <h4 class="modal-title">新增商品</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <form method="post" id="insert_form">
                        <input type="text" name="Name" id="Name" class="form-control" placeholder="商品名稱" />
                        <br />
                        <input type="number" name="Price" id="Price" class="form-control" placeholder="價格" />
                        <br />
                        <input type="text" name="ImageFileName" id="ImageFileName" class="form-control" placeholder="商品圖片" />
                        <br />
                        <label>商品敘述</label>
                        <textarea name="Info" id="Info" class="form-control"></textarea>
                        <br />
                        <label>商品分類</label>
                        <select name="Category" id="Category" class="form-control">
                            <option value="1">衣著服飾</option>
                            <option value="2">日用品</option>
                        </select>
                        <br />

                        <input type="hidden" name="id" id="Id" />
                        <input type="submit" name="insert" id="btnAdd" value="Add" class="btn btn-success" />
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
                            <option value="1">衣著服飾</option>
                            <option value="2">日用品</option>
                        </select>
                        <br />

                        <input type="hidden" name="id" id="editId" />
                        <input type="submit" name="insert" id="btnEdit" value="Edit" class="btn btn-success" />
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
        $(document).ready(load);

        //查全部
        function load() {

            $.ajax({
                type: "POST",
                url: "WebService.asmx/GetProdData",
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
                        var name = $(this).find("Name").text();
                        var price = $(this).find("Price").text();
                        var imgfilename = $(this).find("ImageFileName").text();
                        var info = $(this).find("Info").text();
                        var storeid = $(this).find("Store_Id").text();
                        var storename = $(this).find("Store_Name").text();
                        var category = $(this).find("Category_Name").text();
                        rows += `<tr><td id="tdname">${id}</td><td>${name}</td><td>${price}</td><td><img width="150" src="https://yuyen.s3.ap-southeast-1.amazonaws.com/${imgfilename}"></td><td>${info}</td><td>${storeid} - ${storename}</td><td>${category}</td></tr>`
                    });
                    $('#sort-table').append(rows);

                    $('#sort-table').DataTable({
                        //"searching": false, // 顯示搜尋
                        fixedHeader: { header: true },
                        bSortClasses: true,
                        stateSave: true,
                        //destroy:true,
                        retrieve: true,
                    });


                },
                error: function (response) {
                    var r = jQuery.parseJSON(response.responseText);
                    alert("Message: " + r.Message);
                }
            });

        }






    </script>


</asp:Content>
