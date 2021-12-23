<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<%@ Import Namespace="System.Data" %>
<script runat="server">

</script>

<asp:Content ID="C2" ContentPlaceHolderID="CSSPlaceHolder" runat="server">
    <style>
        thead, tbody {
            text-align: center;
        }

        #th1 {
            background-color: lightpink;
            border-left: none;
        }

        #td00 {
            width: 50px;
        }

        #td01 {
            width: 50px;
        }

        #td1 {
            width: 90px;
        }

        #td2 {
            width: 100px;
        }

        #td3 {
            width: 200px;
        }

        #tdstatus {
            width: 100px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bg-light py-3">
        <div class="container">
            <div class="row">
                <div class="col-md-12 mb-0"><a href="Index.aspx">Home</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">訂單查詢</strong></div>
            </div>
        </div>
    </div>

    <div class="site-section">
        <div class="container">
            <div class="row">

                <div class="col-md-12">
                    <h2 class="h3 mb-3 text-black">訂單查詢</h2>
                </div>
            </div>

            <div class="container">

                <div id="tablediv"></div>
            </div>

            <div id="data_Modal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">運送狀態</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <table id="modaltable" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>商家單號</th>
                                        <th>狀態</th>
                                        <th>時間</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="C3" ContentPlaceHolderID="JSPlaceHolder" runat="server">

    <script>
        $(() => {

            $.ajax({
                type: "POST",
                url: "OrderWebService.asmx/GetData",
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
                    var current_mid = "";
                    var htmltext = "";

                    $.each(customers, function () {
                        var mid = $(this).find("MasterOrder_Id").text();

                        var time = new Date($(this).find("Create_time").text()).toLocaleString("zh-TW").split(" ")[0];
                        var id = $(this).find("Id").text();
                        var prodname = $(this).find("Name").text();
                        var count = $(this).find("Count").text();
                        var price = $(this).find("Price").text();
                        var status = ($(this).find("Status").text()) == "shipping" ? "已出貨" : $(this).find("Status").text() == "booking" ? "尚未出貨" : "已到貨";
                        var realname = $(this).find("RealName").text();

                        if (current_mid == "") {
                            // htmltext += `<tr><td>宅配</td><td>${time}</td><td>${id}</td><td>${prodname}</td><td>${count}</td><td>${price * count}</td><td>信用卡</td></tr>`
                            htmltext += `<table class="table table-bordered" align = "center" >
                                            <thead>
                                                <tr>
                                                    <th id="th1" colspan="2">訂單編號：${mid}</th>
                                                    <th>訂單日期</th>
                                                    <th>商家單號</th>
                                                    <th>品名</th>
                                                    <th>數量</th>
                                                    <th>訂購總額</th>
                                                    <th>收件人資訊</th>
                                                    <th>出貨狀態</th>
                                                </tr>
                                            </thead>`
                            current_mid = mid;
                        } else if (current_mid != mid) {
                            htmltext += `</table>`
                            htmltext += `<table class="table table-bordered" align = "center" >
                                            <thead>
                                                <tr>
                                                    <th id="th1" colspan="2">訂單編號：${mid}</th>
                                                    <th>訂單日期</th>
                                                    <th>商家單號</th>
                                                    <th>品名</th>
                                                    <th>數量</th>
                                                    <th>訂購總額</th>
                                                   <th>收件人資訊</th>
                                                    <th>出貨狀態</th>
                                                </tr>
                                            </thead>`
                            current_mid = mid;
                        }
                        htmltext += `<tbody><tr><td id="td00">宅配</td>
                                            <td id="td01">信用卡</td>
                                            <td id="td2">${time}</td>
                                            <td id="td1">${id}</td>
                                            <td id="td3">${prodname}</td>
                                            <td id="td1">${count}</td>
                                            <td id="td2">${price * count}</td>
                                            <td id="td2">${realname}</td>
                                            <td id="tdstatus"><input class="btn btn-outline-dark" value="${status}" onclick="show(${id})" /></td>

</tr></tbody>`


                    });
                    $('#tablediv').append(htmltext + '</table>');

                }
            });

            function showStatus(id) {
                alert(id);
            };
        });

        function show(id) {
            $('#data_Modal').modal('show');
            //alert(id);
            var data = { id: id }
            $.ajax({
                type: 'POST',
                url: "OrderWebService.asmx/GetStatus",
                data: JSON.stringify(data),
                contentType: "application/json;utf-8",
                dataType: "JSON",
                success: function (result) {
                    //console.log(result.d);
                    var xmlDoc = $.parseXML(result.d);
                    var xml = $(xmlDoc);
                    var customers = xml.find("Table");
                    var rows = '';
                    $('#modaltable tbody').empty();
                    $.each(customers, function () {
                        var id = $(this).find("Order_Id").text();
                        var status = ($(this).find("Status").text()) == "shipping" ? "商家出貨" : $(this).find("Status").text() == "booking" ? "訂單成立" : "已到貨";
                        var time = new Date($(this).find("Create_time").text()).toLocaleString("zh-TW");
                        rows += `<tr><td>${id}</td><td>${status}</td><td>${time}</td></tr>`
                    });
                    $('#modaltable').append(rows);



                }
            });
        };

    </script>

</asp:Content>
