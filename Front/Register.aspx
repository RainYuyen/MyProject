<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">


    protected void Button1_Click(object sender, EventArgs e)
    {
        string userName = TextBox4.Text;
        string password = TextBox5.Text;
        string email = TextBox6.Text;
        string errormsg = "";


        if (MemberUtility.Validation(userName, password, email, out errormsg) == false)
        {
            Label2.Text = errormsg;
        }
        else
        {
            Member m = new Member(
                0,
                TextBox4.Text,
                TextBox5.Text,
                TextBox6.Text);

            MemberUtility.Add(m);

            Label2.Text = "註冊成功";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <form id="form1" runat="server">
        <div class="bg-light py-3">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 mb-0"><a href="Index.aspx">Home</a> <span class="mx-2 mb-0">/</span> <strong class="text-black">會員註冊</strong></div>
                </div>
            </div>
        </div>

        <div class="site-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h2 class="h3 mb-3 text-black">會員註冊</h2>

                        <div class="p-3 p-lg-5 border">
                            <div class="form-group row">
                                <div class="col-md-6">
                                    <label for="c_fname" class="text-black">帳號<span class="text-danger">*</span></label>
                                    <%--<input type="text" class="form-control" id="c_fname" name="c_fname">--%>
                                    <asp:TextBox ID="TextBox4" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label for="TextBox5" class="text-black">密碼<span class="text-danger">*</span></label>
                                    <%--<input type="text" class="form-control" id="c_lname" name="c_lname">--%>
                                    <asp:TextBox ID="TextBox5" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="c_email" class="text-black">Email<span class="text-danger">*</span></label>
                                    <%--<input type="email" class="form-control" id="c_email" name="c_email" placeholder="">--%>
                                    <asp:TextBox ID="TextBox6" CssClass="form-control" runat="server" TextMode="Email"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-lg-12">
                                    <%--<input type="submit" class="btn btn-primary btn-lg btn-block" value="註冊">--%>
                                    <asp:Label ID="Label2" runat="server" Text="" ForeColor="Red"></asp:Label>
                                    <asp:Button ID="Button2" CssClass="btn btn-primary btn-lg btn-block" runat="server" Text="註冊" OnClick="Button1_Click" />
                                </div>
                            </div>
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

