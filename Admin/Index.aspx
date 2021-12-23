<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] != null)
        {
            Store s = (Store)Session["user"];
            LabelShow.Text = $"{s.UserName}，您好";
            lbIP.Text = Session["ip"].ToString();
            //TimeZoneInfo.ConvertTimeBySystemTimeZoneId(DateTime.Now.ToString("G"), TimeZoneInfo.Local.Id, "China Standard Time")
            lbTime.Text = (TimeZoneInfo.ConvertTimeBySystemTimeZoneId(DateTime.Now, TimeZoneInfo.Local.Id, "China Standard Time")).ToString();

            LiteralAdmin.Visible = Convert.ToInt32(Session["role_id"]) == 0 ? true : false;
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }
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
    <link href="assets/libs/flot/css/float-chart.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="dist/css/style.min.css" rel="stylesheet">
    <link href="assets/libs/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

    <style>
    </style>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">

    <!-- ============================================================== -->
    <!-- Container fluid  -->
    <!-- ============================================================== -->
    <%--<div class="container-fluid">--%>


    <%--</div>--%>

    <div class="container">

        <h1>
            <asp:Label ID="LabelShow" runat="server" Text=""></asp:Label>
        </h1>
        <hr />
        <h4>此次登入IP為：<asp:Label runat="server" ID="lbIP"></asp:Label></h4>
        <h4>此次登入時間為：<asp:Label runat="server" ID="lbTime"></asp:Label></h4>
        <asp:Literal ID="LiteralAdmin" runat="server" Visible="false">
        <div>
            <canvas id="myChart"></canvas>
        </div>
        </asp:Literal>
    </div>


    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->

</asp:Content>



<asp:Content ID="Content3" ContentPlaceHolderID="JSHolder" runat="Server">
    <script src="assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    <script>

        $(() => {

            $.ajax({
                type: 'POST',
                url: "WebService.asmx/GetChartData",
                contentType: "application/json;utf-8",
                dataType: "json",
                async: false,
                success: function (result) {
                    console.log(result.d);
                    StoreName = result.d.StoreName;
                    OrderCount = result.d.OrderCount;

                    var ctx = document.getElementById("myChart");
                    var myChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: StoreName,
                            datasets: [
                                {
                                    label: '訂單數量',
                                    backgroundColor: [
                                        'rgba(255, 99, 132, 0.2)',
                                        'rgba(255, 159, 64, 0.2)',
                                        'rgba(255, 205, 86, 0.2)',
                                        'rgba(75, 192, 192, 0.2)',
                                        'rgba(54, 162, 235, 0.2)',
                                        'rgba(153, 102, 255, 0.2)',
                                        'rgba(201, 203, 207, 0.2)'
                                    ],
                                    borderColor: [
                                        'rgb(255, 99, 132)',
                                        'rgb(255, 159, 64)',
                                        'rgb(255, 205, 86)',
                                        'rgb(75, 192, 192)',
                                        'rgb(54, 162, 235)',
                                        'rgb(153, 102, 255)',
                                        'rgb(201, 203, 207)'
                                    ],
                                    data: OrderCount,
                                    fill: false
                                }
                            ]
                        },
                        options: {
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true,
                                    }
                                }]
                            }
                        }
                    });

                }
            });


        });


    </script>

</asp:Content>

