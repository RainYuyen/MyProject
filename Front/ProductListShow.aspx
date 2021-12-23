<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        List<Product> products = ProductUtility.GetProducts();

        Repeater1.DataSource = products;
        Repeater1.DataBind();


    }



    protected void Button1_Click(object sender, EventArgs e)
    {
        if (int.Parse(DropDownList1.SelectedValue) != 0 && int.Parse(DropDownList2.SelectedValue) != 0)
        {
            List<Product> products = ProductUtility.GetProducts2(int.Parse(DropDownList1.SelectedValue), int.Parse(DropDownList2.SelectedValue));
            Repeater1.DataSource = products;
            Repeater1.DataBind();
        }
        else if (int.Parse(DropDownList1.SelectedValue) != 0 || int.Parse(DropDownList2.SelectedValue) != 0)
        {
            List<Product> products = ProductUtility.GetProducts(int.Parse(DropDownList1.SelectedValue), int.Parse(DropDownList2.SelectedValue));
            Repeater1.DataSource = products;
            Repeater1.DataBind();
        }




    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <form id="form1" runat="server">


        <div class="bg-light py-3">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 mb-0"><a href="Index.aspx">Home</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">Shop</strong></div>
                </div>
            </div>
        </div>

        <div class="site-section">
            <div class="container">

                <div class="row mb-5">
                    <div class="col-md-12 order-2">

                        <div class="row">
                            <div class="col-md-12 mb-5">
                                <div class="float-md-left mb-4">
                                    <h2 class="text-black h5">Shop All</h2>
                                </div>

                                <div class="float-md-right mb-4">
                                    <asp:DropDownList ID="DropDownList2" runat="server">
                                        <asp:ListItem Text="--請選擇品牌--" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="NIKE" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="ADIDAS" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="PUMA" Value="4"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="DropDownList1" runat="server">
                                        <asp:ListItem Text="--請選擇類型--" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="男鞋" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="女鞋" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="童鞋" Value="3"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:Button ID="Button1" runat="server" Text="查詢" OnClick="Button1_Click" CssClass="btn btn-primary btn-rounded" />
                                </div>


                                <%--<div class="d-flex">
                                <div class="dropdown mr-1 ml-md-auto">
                                    <button type="button" class="btn btn-secondary btn-sm dropdown-toggle" id="dropdownMenuOffset" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        Latest
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuOffset">
                                        <a class="dropdown-item" href="#">Men</a>
                                        <a class="dropdown-item" href="#">Women</a>
                                        <a class="dropdown-item" href="#">Children</a>
                                    </div>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-secondary btn-sm dropdown-toggle" id="dropdownMenuReference" data-toggle="dropdown">Reference</button>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuReference">
                                        <a class="dropdown-item" href="#">Relevance</a>
                                        <a class="dropdown-item" href="#">Name, A to Z</a>
                                        <a class="dropdown-item" href="#">Name, Z to A</a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="#">Price, low to high</a>
                                        <a class="dropdown-item" href="#">Price, high to low</a>
                                    </div>
                                </div>
                            </div>--%>
                            </div>
                        </div>

                        <div class="row mb-5" id="sort-table">
                            <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>


                                    <div class="col-sm-6 col-lg-3 mb-4" data-aos="fade-up">
                                        <div class="block-4 text-center border">
                                            <figure class="block-4-image">
                                                <a href='ProductDetail.aspx?id=<%# Eval("Id") %>'>
                                                    <img src="https://yuyen.s3.ap-southeast-1.amazonaws.com/<%# Eval("ImageFileName") %>" class="img-fluid"></a>
                                            </figure>
                                            <div class="block-4-text p-4">
                                                <a href='ProductDetail.aspx?id=<%# Eval("Id") %>' class="text-primary font-weight-bold"><%# Eval("Name") %></a>
                                                <br />
                                                <span>$&nbsp <%# ProductUtility.GetPrice(Eval("Price")) %></span>
                                            </div>
                                        </div>
                                    </div>


                                </ItemTemplate>
                            </asp:Repeater>

                        </div>




                        <%--<div class="row" data-aos="fade-up">
                            <div class="col-md-12 text-center">
                                <div class="site-block-27">
                                    <ul>
                                        <li><a href="#">&lt;</a></li>
                                        <li class="active"><span>1</span></li>
                                        <li><a href="#">2</a></li>
                                        <li><a href="#">3</a></li>
                                        <li><a href="#">4</a></li>
                                        <li><a href="#">5</a></li>
                                        <li><a href="#">&gt;</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>--%>
                    </div>

                    <%--<div class="col-md-3 order-1 mb-5 mb-md-0">
                    <div class="border p-4 rounded mb-4">
                        <h3 class="mb-3 h6 text-uppercase text-black d-block">Categories</h3>
                        <ul class="list-unstyled mb-0">
                            <li class="mb-1"><a href="#" class="d-flex"><span>Men</span> <span class="text-black ml-auto">(2,220)</span></a></li>
                            <li class="mb-1"><a href="#" class="d-flex"><span>Women</span> <span class="text-black ml-auto">(2,550)</span></a></li>
                            <li class="mb-1"><a href="#" class="d-flex"><span>Children</span> <span class="text-black ml-auto">(2,124)</span></a></li>
                        </ul>
                    </div>--%>

                    <%--<div class="border p-4 rounded mb-4">
                        <div class="mb-4">
                            <h3 class="mb-3 h6 text-uppercase text-black d-block">Filter by Price</h3>
                            <div id="slider-range" class="border-primary"></div>
                            <input type="text" name="text" id="amount" class="form-control border-0 pl-0 bg-white" disabled="" />
                        </div>

                        <div class="mb-4">
                            <h3 class="mb-3 h6 text-uppercase text-black d-block">Size</h3>
                            <label for="s_sm" class="d-flex">
                                <input type="checkbox" id="s_sm" class="mr-2 mt-1">
                                <span class="text-black">Small (2,319)</span>
                            </label>
                            <label for="s_md" class="d-flex">
                                <input type="checkbox" id="s_md" class="mr-2 mt-1">
                                <span class="text-black">Medium (1,282)</span>
                            </label>
                            <label for="s_lg" class="d-flex">
                                <input type="checkbox" id="s_lg" class="mr-2 mt-1">
                                <span class="text-black">Large (1,392)</span>
                            </label>
                        </div>--%>

                    <%--<div class="mb-4">
                            <h3 class="mb-3 h6 text-uppercase text-black d-block">Color</h3>
                            <a href="#" class="d-flex color-item align-items-center">
                                <span class="bg-danger color d-inline-block rounded-circle mr-2"></span><span class="text-black">Red (2,429)</span>
                            </a>
                            <a href="#" class="d-flex color-item align-items-center">
                                <span class="bg-success color d-inline-block rounded-circle mr-2"></span><span class="text-black">Green (2,298)</span>
                            </a>
                            <a href="#" class="d-flex color-item align-items-center">
                                <span class="bg-info color d-inline-block rounded-circle mr-2"></span><span class="text-black">Blue (1,075)</span>
                            </a>
                            <a href="#" class="d-flex color-item align-items-center">
                                <span class="bg-primary color d-inline-block rounded-circle mr-2"></span><span class="text-black">Purple (1,075)</span>
                            </a>
                        </div>--%>
                </div>
            </div>
        </div>

        <%--<div class="row">
                <div class="col-md-12">
                    <div class="site-section site-blocks-2">
                        <div class="row justify-content-center text-center mb-5">
                            <div class="col-md-7 site-section-heading pt-4">
                                <h2>Categories</h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6 col-lg-4 mb-4 mb-lg-0" data-aos="fade" data-aos-delay="">
                                <a class="block-2-item" href="#">
                                    <figure class="image">
                                        <img src="images/women.jpg" alt="" class="img-fluid">
                                    </figure>
                                    <div class="text">
                                        <span class="text-uppercase">Collections</span>
                                        <h3>Women</h3>
                                    </div>
                                </a>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-4 mb-5 mb-lg-0" data-aos="fade" data-aos-delay="100">
                                <a class="block-2-item" href="#">
                                    <figure class="image">
                                        <img src="images/children.jpg" alt="" class="img-fluid">
                                    </figure>
                                    <div class="text">
                                        <span class="text-uppercase">Collections</span>
                                        <h3>Children</h3>
                                    </div>
                                </a>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-4 mb-5 mb-lg-0" data-aos="fade" data-aos-delay="200">
                                <a class="block-2-item" href="#">
                                    <figure class="image">
                                        <img src="images/men.jpg" alt="" class="img-fluid">
                                    </figure>
                                    <div class="text">
                                        <span class="text-uppercase">Collections</span>
                                        <h3>Men</h3>
                                    </div>
                                </a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>--%>
        </div>
    </div>
    </form>
</asp:Content>



