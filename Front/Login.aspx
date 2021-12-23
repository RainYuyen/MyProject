<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        Member m = MemberUtility.GetMember(TextBox1.Text, TextBox2.Text);

        if (m == null)
        {
            Label1.Text = "帳號或密碼不正確，請重新輸入";
        }
        else if (m.Status == 0)
        {
            Label1.Text = "此帳號已註銷，請聯繫客服開啟";
        }
        else
        {
            Session["user"] = m;
            Session["username"] = m.UserName;

            Response.Redirect("~/Index.aspx");
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <form id="form1" runat="server">
        <div class="bg-light py-3">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 mb-0"><a href="Index.aspx">Home</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">會員登入</strong></div>
                </div>
            </div>
        </div>

        <div class="site-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <h2 id="demo" class="h3 mb-3 text-black">會員登入</h2>

                        <div class="p-3 p-lg-5 border">
                            <div class="form-group row">

                                <div class="col-md-6">
                                    <label for="c_fname" class="text-black">帳號<span class="text-danger">*</span></label>
                                    <%--<input type="text" class="form-control" id="c_fname" name="c_fname">--%>
                                    <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label for="c_lname" class="text-black">密碼<span class="text-danger">*</span></label>
                                    <%--<input type="text" class="form-control" id="c_lname" name="c_lname">--%>
                                    <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-lg-12">
                                    <asp:Label ID="Label1" runat="server" Text="" ForeColor="Red"></asp:Label>
                                    <asp:Button ID="Button1" CssClass="btn btn-primary btn-lg btn-block" runat="server" Text="登入" OnClick="Button1_Click" />
                                </div>
                            </div>
                            <a href="Register.aspx" style="float: right;">會員註冊</a>

                        </div>
                    </div>
                    <%--<div class="col-md-5 ml-auto">
                        <div class="p-4 border mb-3">
                            <span class="d-block text-primary h6 text-uppercase">New York</span>
                            <p class="mb-0">203 Fake St. Mountain View, San Francisco, California, USA</p>
                        </div>
                        <div class="p-4 border mb-3">
                            <span class="d-block text-primary h6 text-uppercase">London</span>
                            <p class="mb-0">203 Fake St. Mountain View, San Francisco, California, USA</p>
                        </div>
                        <div class="p-4 border mb-3">
                            <span class="d-block text-primary h6 text-uppercase">Canada</span>
                            <p class="mb-0">203 Fake St. Mountain View, San Francisco, California, USA</p>
                        </div>

                    </div>--%>
                </div>
            </div>
        </div>
    </form>

</asp:Content>

<asp:Content ContentPlaceHolderID="JSPlaceHolder" ID="Js" runat="server">

    <script>

        $(() => {

            $("#demo").click(() => {

                $("#ContentPlaceHolder1_TextBox1").val("user1");
                $("#ContentPlaceHolder1_TextBox2").val("user1");

            });

        });

    </script>

</asp:Content>

