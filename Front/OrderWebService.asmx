<%@ WebService Language="C#" Class="OrderWebService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class OrderWebService : System.Web.Services.WebService
{

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }
    [WebMethod(enableSession: true)]
    public string GetData()
    {
        Member m = (Member)HttpContext.Current.Session["user"];
        string o = OrderUtility.GetXML(m.UserName);
        return o;
    }

    [WebMethod]
    public string GetStatus(int id)
    {
            return OrderUtility.GetStatusXML(id);
    }

}