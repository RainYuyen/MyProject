<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">


    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Session["user"] == null)
        {
            Response.Redirect("~/Login.aspx");
            return;
        }

        List<Cart> cartList = (List<Cart>)Session["ShoppingCart"];
        if (string.IsNullOrEmpty(txbxRealname.Text) || string.IsNullOrEmpty(txbxPhone.Text) || string.IsNullOrEmpty(txbxAddress.Text))
        {
            Label1.Text = "請輸入收件資訊";
            return;
        }
        else if (string.IsNullOrEmpty(TextBox1.Text) || string.IsNullOrEmpty(TextBox2.Text) || string.IsNullOrEmpty(TextBox3.Text) || string.IsNullOrEmpty(TextBox4.Text))
        {
            Label1.Text = "請輸入卡號";
            return;
        }

        string username = Session["username"].ToString();
        bool flag = OrderUtility.CreateOrder(cartList, username, txbxRealname.Text, txbxPhone.Text, txbxAddress.Text);

        if (flag == true)
        {
            Session["ShoppingCart"] = null;
            Label1.Text = "結帳成功";
        }

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <form id="form1" runat="server">
        <div class="bg-light py-3">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 mb-0"><a href="Index.aspx">Home</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">結帳</strong></div>
                </div>
            </div>
        </div>

        <div class="site-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <h2 id="demo" class="h3 mb-3 text-black">結帳</h2>

                        <div class="p-3 p-lg-5 border">

                            <div class="form-group row">
                                <div class="col-md-3">
                                    <label class="">請輸入收件人姓名</label>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txbxRealname" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="">請輸入收件人電話</label>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txbxPhone" CssClass="form-control" runat="server" TextMode="Number" MaxLength="10"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-3">
                                    <label class="">請輸入收件地址</label>
                                </div>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txbxAddress" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>


                            <div class="form-group row">

                                <div class="col-md-12">
                                    <label class="">請輸入信用卡號</label>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server" MaxLength="4"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" MaxLength="4"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server" MaxLength="4"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="TextBox4" CssClass="form-control" runat="server" MaxLength="4"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-lg-12">
                                    <asp:Label ID="Label1" runat="server" Text="" ForeColor="Red"></asp:Label>
                                    <asp:Button ID="Button2" CssClass="btn btn-primary btn-lg btn-block" runat="server" Text="結帳" OnClick="Button1_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>

<asp:Content ContentPlaceHolderID="JSPlaceHolder" ID="Js" runat="server">

    <script>

        $(() => {

            $("#demo").click(() => {
                $("#ContentPlaceHolder1_txbxRealname").val("蔡語嫣");
                $("#ContentPlaceHolder1_txbxPhone").val("0911000999");
                $("#ContentPlaceHolder1_txbxAddress").val("新北市林口區工八路20號");
                $("#ContentPlaceHolder1_TextBox1").val("1234");
                $("#ContentPlaceHolder1_TextBox2").val("0000");
                $("#ContentPlaceHolder1_TextBox3").val("5678");
                $("#ContentPlaceHolder1_TextBox4").val("9999");
                
            });

        });

    </script>

</asp:Content>
