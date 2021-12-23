<%@ WebService Language="C#" Class="WebService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Net;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Drawing;



[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{
    //Store
    [WebMethod]
    public string GetData()
    {
        string s = StoreUtility.GetXML();
        return s;
    }

    [WebMethod]
    public Store EditStore(int id)
    {
        Store s = StoreUtility.GetStore(id);
        return s;
    }

    [WebMethod]
    public void UpdateStore(int id, string storename, string username, string email, string phone, string address, int roleid)
    {
        StoreUtility.Update(id, storename, username, email, phone, address, roleid);
    }

    [WebMethod]
    public void AddStore(string Username, string Email, string StoreName, string Phone, string Address, int Role)
    {
        StoreUtility.Add(Username, Email, StoreName, Phone, Address, Role);
    }

    [WebMethod]
    public void DeleteStore(int id)
    {
        StoreUtility.Delete(id);
    }






    //Product
    [WebMethod]
    public string GetProdData()
    {
        string p = ProductUtility.GetXML();
        return p;
    }
    [WebMethod(EnableSession = true)]
    public string GetProdDataUser()
    {
        string p = ProductUtility.GetXML((Convert.ToInt32(HttpContext.Current.Session["store_id"])));
        return p;
    }

    [WebMethod]
    public Product EditProd(int id)
    {
        Product p = ProductUtility.GetProduct(id);
        return p;
    }

    [WebMethod]
    public void UpdateProd(int id, string name, int price, string imagefilename, string info, int category)
    {
        ProductUtility.Update(id, name, price, imagefilename, info, category);
    }



    [WebMethod(EnableSession = true)]
    public void AddProd(string name, int price, string imagefilename, string info, int category)
    {
        ProductUtility.Add(name, price, imagefilename, info, category, (Convert.ToInt32(HttpContext.Current.Session["store_id"])));
        //ProductUtility.Add(name, price, imagefilename, info, category, 2);
    }

    [WebMethod]
    public void DeleteProd(int id)
    {
        ProductUtility.Delete(id);
    }


    //Member
    [WebMethod]
    public string GetMemberData()
    {
        string m = MemberUtility.GetXML();
        return m;
    }
    [WebMethod]
    public void CancelMember(int id)
    {
        MemberUtility.CancelMember(id);
    }
    [WebMethod]
    public void ReopenMember(int id)
    {
        MemberUtility.ReopenMember(id);
    }
    [WebMethod]
    public Member EditMember(int id)
    {
        Member m = MemberUtility.GetMember(id);
        return m;
    }
    [WebMethod]
    public void UpdateMember(int id, string email, string phone, string address, string note)
    {
        MemberUtility.Update(id, email, phone, address, note);
    }







    //Order
    [WebMethod(EnableSession = true)]
    public string GetOrderData()
    {
        string o = OrderUtility.GetXML((Convert.ToInt32(HttpContext.Current.Session["store_id"])));
        return o;
    }
    [WebMethod]
    public string GetOrderDataM()
    {
        string o = OrderUtility.GetXML();
        return o;
    }
    [WebMethod]
    public void ChangeOrderStatus(int id)
    {
        OrderUtility.ChangeStatus(id);
    }






    //Others
    [WebMethod(EnableSession = true)]
    public Store GetStore()
    {
        Store s = StoreUtility.GetStore(Convert.ToInt32(HttpContext.Current.Session["store_id"]));
        //Store s = StoreUtility.GetStore(2);
        return s;
    }

    [WebMethod(EnableSession = true)]
    public void UpdateProfile(string email, string phone, string address)
    {
        StoreUtility.Update(Convert.ToInt32(HttpContext.Current.Session["store_id"]), email, phone, address);
        //StoreUtility.Update(2, email, phone, address);
    }

    [WebMethod(EnableSession = true)]
    public void UpdatePassword(string password)
    {
        StoreUtility.Update(Convert.ToInt32(HttpContext.Current.Session["store_id"]), password);
    }

    [WebMethod(EnableSession = true)]
    public string getKey()
    {
        return Common.CreateSecretKeyAndQrCode(HttpContext.Current.Session["email"].ToString());
    }



    //chart
    [WebMethod]
    public ChartData GetChartData()
    {

        SqlDataAdapter da = new SqlDataAdapter(
               "SELECT Stores.Store_Name,Count(1) as Count FROM Orders JOIN Stores ON Orders.Store_Id = Stores.Id Group by Store_Name",
               Common.DBConnectionString);

        DataTable dt = new DataTable();
        da.Fill(dt);

        ChartData chart = new ChartData()
        {
            StoreName = dt.AsEnumerable().Select(r => r["Store_Name"].ToString()).ToArray(),
            OrderCount = dt.AsEnumerable().Select(r => int.Parse(r["Count"].ToString())).ToArray()

            //CategoryNames = dt.AsEnumerable().Select(r => r["CategoryName"].ToString()).ToArray(),
            //CategorySales = dt.AsEnumerable().Select(r => r["CategorySales"].ToString()).ToArray()
        };

        return chart;
    }



}