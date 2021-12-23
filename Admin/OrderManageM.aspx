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
        /*table {
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto;
        }

        #sort-table thead {
            text-align: center;
        }

        #tdf {
            text-align: center;*/
        /*width:200px;*/
        /*}
*/
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
                <table id="sort-table" class="table table-bordered display">
                    <thead style="text-align:center;">
                        <tr>
                            <th style="width:30px;">訂單編號</th>
                            <th style="width:30px;">商家單號</th>
                            <th>訂單日期</th>
                            <th>店家資訊</th>
                            <th>使用者帳號</th>
                            <th>商品資訊</th>
                            <th style="width:30px;">數量</th>
                            <th>訂單狀態</th>
                            <th>收件者姓名</th>
                            <th>收件地址</th>
                            <th>電話</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
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



    <script>

        $(() => {
            loadAll()
        });

        //查全部
        function loadAll() {
            $.ajax({
                type: "POST",
                url: "WebService.asmx/GetOrderDataM",
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
                        var mid = $(this).find("MasterOrder_Id").text();
                        var time = new Date($(this).find("Create_time").text()).toLocaleString("zh-TW");
                        var storeid = $(this).find("Store_Id").text();
                        var storename = $(this).find("Store_Name").text();
                        var username = $(this).find("UserName").text();
                        var prodid = $(this).find("Product_Id").text();
                        var prodname = $(this).find("Name").text();
                        var count = $(this).find("Count").text();
                        var status = ($(this).find("Status").text()) == "shipping" ? "出貨" : $(this).find("Status").text() == "booking" ? "尚未出貨" : "已到貨";
                        var realname = $(this).find("RealName").text();
                        var address = $(this).find("Address").text();
                        var phone = $(this).find("Phone").text();
                        rows += `<tr><td id="tdname">${mid}</td><td id="tdname">${id}</td><td>${time}</td><td>${storeid} - ${storename}</td><td>${username}</td><td>${prodid}__${prodname}</td><td>${count}</td><td>${status}</td><td>${realname}</td><td>${address}</td><td>${phone}</td></tr>`

                    });
                    $('#sort-table').append(rows);
                    $('#sort-table').DataTable({
                        bSortClasses: true,
                        stateSave: true,
                        retrieve: true
                    });
                },
                error: function (response) {
                    var r = jQuery.parseJSON(response.responseText);
                    alert("Message: " + r.Message);
                }
            });

        };


        //按出貨按鈕
        //function status(id) {
        //    //alert(id)
        //    var data = { id: id }

        //    Swal.fire({
        //        title: `訂單編號：${id}，確定已經出貨？`,
        //        icon: 'question',
        //        showDenyButton: true,
        //        confirmButtonText: '確定',
        //        denyButtonText: `取消`,
        //    }).then((result) => {
        //        if (result.isConfirmed) {
        //            $.ajax({
        //                type: 'POST',
        //                url: "WebService.asmx/ChangeOrderStatus",
        //                data: JSON.stringify(data),
        //                contentType: "application/json;utf-8",
        //                dataType: "JSON",
        //                success: function (result) {
        //                    Swal.fire('成功', `${id}號訂單已經出貨成功`, 'success')
        //                    loadAll();
        //                }
        //            });
        //        } else if (result.isDenied) {
        //            Swal.fire('失敗', '重新再來一次喔～', 'error')
        //        }
        //    })
        //}

    </script>


</asp:Content>
