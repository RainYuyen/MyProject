<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">
    //Session["ShoppingCart"]

    protected void Page_Load(object sender, EventArgs e)
    {
        List<Cart> cartList = Session["ShoppingCart"] as List<Cart>;

        Repeater1.DataSource = cartList;
        Repeater1.DataBind();

        int allTotal = 0;

        if (cartList != null)

            foreach (Cart c in cartList)
                allTotal += c.Total;

        Label1.Text = $"{allTotal.ToString("N0")} 元";


    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        List<Cart> cartList = Session["ShoppingCart"] as List<Cart>;

        if (Session["user"]==null)
        {
            Response.Redirect("~/Login.aspx");
        }
        else
        {
            Response.Redirect("~/Checkout.aspx");
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <form runat="server">
    <div class="bg-light py-3">
        <div class="container">
            <div class="row">
                <div class="col-md-12 mb-0"><a href="Index.aspx">Home</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">購物車</strong></div>
            </div>
        </div>
    </div>

    <div class="site-section">
        <div class="container">
            <div class="row mb-5">
                <div class="col-md-12" method="post" runat="server">
                    <div class="site-blocks-table">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <%--<th class="product-thumbnail">Image</th>--%>
                                    <th colspan="2" class="product-name">產品資訊</th>
                                    <th class="product-price">單價</th>
                                    <th class="product-quantity">數量</th>
                                    <th class="product-total">小計</th>
                                    <th class="product-remove">移除</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="Repeater1" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="product-thumbnail">
                                                <%--<img src="images/cloth_1.jpg" alt="Image" class="img-fluid">--%>
                                                <img src="https://yuyen.s3.ap-southeast-1.amazonaws.com/<%# Eval("ImageFileName") %>" class="img-fluid"></a>
                                            </td>
                                            <td class="product-name">
                                                <%--<h2 class="h5 text-black">Top Up T-Shirt</h2>--%>
                                                <h2 class="h5 text-black"><%# Eval("Name") %></h2>
                                                <%--<h2><asp:Label ID="Label2" CssClass="h5 text-black" runat="server" Text='<%# Eval("Name") %>'></asp:Label></h2>--%>
                                            </td>
                                            <%--<td>$49.00</td>--%>
                                            <td><%# ProductUtility.GetPrice(Eval("Price")) %></td>

                                            <td>

                                                <%#Eval("Count") %>
                                                <%--<asp:Label ID="Label3" runat="server" Text='<%# Eval("Count") %>'></asp:Label>--%>

                                                <%--<div class="input-group-prepend">
                                                        <button class="btn btn-outline-primary js-btn-minus" type="button">&minus;</button>
                                                    </div>
                                                    <input type="text" class="form-control text-center" value="1" placeholder="" aria-label="Example text with button addon" aria-describedby="button-addon1">
                                                    <div class="input-group-append">
                                                        <button class="btn btn-outline-primary js-btn-plus" type="button">&plus;</button>
                                                    </div>--%>
                                                

                                            </td>
                                            <%--<td>$49.00</td>--%>
                                            <td><%#ProductUtility.GetPrice(Eval("Total")) %></td>
                                            <%--<td><a href='<%#Eval("id","/CartDelete.aspx?id={0}") %>' class="btn btn-primary btn-sm">X</a></td>--%>
                                            <%--<td><a href='<%# String.Format("/CartDelete.aspx?id={0}&count={1}", Eval("id"), Eval("count")) %>' class="btn btn-primary btn-sm">X</a></td>--%>
                                                <%--<form id="form1" runat="server">
                                                    <asp:Button ID="Button1" CssClass="btn btn-primary btn-sm" runat="server" Text="X" OnClick="Button1_Click" UseSubmitBehavior="False" />
                                                </form>--%>

                                            <td>
                                                <asp:HyperLink ID="HyperLink2" CssClass="btn btn-primary btn-sm" runat="server" 
                                                    NavigateUrl='<%# String.Format("/CartDelete.aspx?id={0}&count={1}", Eval("id"), Eval("count")) %>'>X</asp:HyperLink>
                                            </td>

                                        </tr>


                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="row mb-5">
                        <%--<div class="col-md-6 mb-3 mb-md-0">
                            <button class="btn btn-primary btn-sm btn-block">Update Cart</button>
                        </div>--%>
                        <div class="col-md-12">
                            <%--<button class="btn btn-outline-primary btn-sm btn-block">Continue Shopping</button>--%>
                            <%--<form id="form1" runat="server">--%>
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/ProductListShow.aspx" CssClass="btn btn-outline-primary btn-sm btn-block">繼續購物</asp:HyperLink>
                            <%--<asp:Button ID="Button1" runat="server" Text="繼續購物" CssClass="btn btn-outline-primary btn-sm btn-block" OnClick="Button1_Click" />--%>
                            <%--</form>--%>
                        </div>
                    </div>
                    <%--<div class="row">
                        <div class="col-md-12">
                            <label class="text-black h4" for="coupon">Coupon</label>
                            <p>Enter your coupon code if you have one.</p>
                        </div>
                        <div class="col-md-8 mb-3 mb-md-0">
                            <input type="text" class="form-control py-3" id="coupon" placeholder="Coupon Code">
                        </div>
                        <div class="col-md-4">
                            <button class="btn btn-primary btn-sm">Apply Coupon</button>
                        </div>
                    </div>--%>
                </div>
                <div class="col-md-6 pl-5">
                    <div class="row justify-content-end">
                        <div class="col-md-7">
                            <div class="row">
                                <div class="col-md-12 text-right border-bottom mb-5">
                                    <h3 class="text-black h4 text-uppercase">商品金額總計</h3>
                                </div>
                            </div>
                            <%--<div class="row mb-3">
                                <div class="col-md-6">
                                    <span class="text-black">Subtotal</span>
                                </div>
                                <div class="col-md-6 text-right">
                                    <strong class="text-black">$230.00</strong>
                                </div>
                            </div>--%>
                            <div class="row mb-5">
                                <div class="col-md-6">
                                    <span class="text-black">共</span>
                                </div>
                                <div class="col-md-6 text-right">
                                    <%--<strong class="text-black">$230.00</strong>--%>
                                    <asp:Label ID="Label1" runat="server" Text="Label" CssClass="text-black"></asp:Label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <%--<button class="btn btn-primary btn-lg py-3 btn-block" onclick="window.location='/Checkout.aspx'">結帳去</button>--%>
                                    <asp:Button ID="Button1" runat="server" Text="結帳去" CssClass="btn btn-primary btn-lg py-3 btn-block" OnClick="Button1_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        </form>
</asp:Content>

