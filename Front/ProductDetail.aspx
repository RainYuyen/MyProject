<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            int id = int.Parse(Request.QueryString["id"]);
            Product p = ProductUtility.GetProduct(id);

            Image1.ImageUrl = $"https://yuyen.s3.ap-southeast-1.amazonaws.com/{p.ImageFileName}";
            Label1.Text = p.Name;
            Label2.Text = ProductUtility.GetPrice(p.Price);
            lbInfo.Text = p.Info;

            HiddenField1.Value = id.ToString();
        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        uint o = 0;
        if (!uint.TryParse(TextBox1.Text, out o) || int.Parse(TextBox1.Text) == 0)
        {
            Label3.Text = "數量最少須為1，請重新選擇";
            return;
        }

        int id = int.Parse(HiddenField1.Value);

        Product p = ProductUtility.GetProduct(id);

        Cart c = new Cart(p.Id, p.Name, p.Price, int.Parse(TextBox1.Text), p.ImageFileName, p.Store_Id, p.Id);

        List<Cart> cartList = null;

        if (Session["ShoppingCart"] == null)
        {
            cartList = new List<Cart>();
            Session["ShoppingCart"] = cartList;
        }
        else
        {
            cartList = (List<Cart>)Session["ShoppingCart"];
        }

        cartList.Add(c);
        Response.Redirect("~/Cart.aspx");
    }
</script>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<%# Eval("Name") %>--%>

    <form id="form1" runat="server">

        <div class="bg-light py-3">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 mb-0"><a href="Index.aspx">Home</a></div>
                </div>
            </div>
        </div>

        <div class="site-section">
            <div class="container">
                <div class="row">

                    <div class="col-md-6">
                        <asp:Image Width="480px" ID="Image1" runat="server" />
                        <%--<img src='<%# Eval("ImageFileName","/Images/{0}") %>' alt="Image placeholder"></a>--%>
                    </div>
                    <div class="col-md-6">
                        <h2 class="text-black">
                            <asp:Label ID="Label1" runat="server" Text=""><%# Eval("Name") %></asp:Label></h2>

                        <div>
                            <asp:Label ID="lbInfo" runat="server" Text=""><%# Eval("Info") %></asp:Label>
                        </div>

                        <p>
                            <strong class="text-primary h4">$&nbsp<asp:Label ID="Label2" runat="server" Text=""><%# Eval("Price") %></asp:Label></strong>
                        </p>
                        <div class="mb-5">
                            <div class="input-group mb-3" style="max-width: 120px;">
                                <div class="input-group-prepend">
                                    <button class="btn btn-outline-primary js-btn-minus" type="button">&minus;</button>
                                </div>
                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control text-center" Text="1"></asp:TextBox>
                                <div class="input-group-append">
                                    <button class="btn btn-outline-primary js-btn-plus" type="button">&plus;</button>
                                </div>
                            </div>
                        </div>
                        <asp:Button ID="Button1" runat="server" Text="加入購物車" CssClass="buy-now btn btn-sm btn-primary" OnClick="Button1_Click" />
                        <br />
                        <asp:Label ID="Label3" runat="server" Text="" ForeColor="Red"></asp:Label>
                    </div>
                    <asp:HiddenField ID="HiddenField1" runat="server" />


                </div>
            </div>
        </div>

    </form>
</asp:Content>
