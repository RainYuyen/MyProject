<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>

<script runat="server">


    protected void Page_Load(object sender, EventArgs e)
    {
        int id = int.Parse(Request.QueryString["id"]);
        int count = int.Parse(Request.QueryString["count"]);

        List<Cart> C = (List<Cart>)Session["ShoppingCart"];

        foreach (Cart item in C)
        {
          
            if (item.Id == id && item.Count == count)
            {
                //C.Remove((Cart)id);
                C.Remove(item);
                break;
            }
        }
        Response.Redirect("~/Cart.aspx");


        //int a, b;
        //a = 10;
        //b = a;
        //b = b - 1;

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>

