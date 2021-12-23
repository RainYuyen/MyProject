using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OrderUtility
/// </summary>
public class OrderUtility
{
    public static void ChangeStatus(int orderId)
    {
        //booking change to shipping 
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
       
        SqlCommand cmd = new SqlCommand(
          "UPDATE Orders SET Status = @status, Update_time = @uptime WHERE Id = @orderid", cn);

        cmd.Parameters.AddWithValue("@status", "shipping");
        cmd.Parameters.AddWithValue("@orderid", orderId);
        cmd.Parameters.AddWithValue("@uptime", DateTime.Now);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();

    }

    //public static List<Order> GetOrders(int storeid)
    //{
    //    SqlDataAdapter da = new SqlDataAdapter(
    //        "SELECT * FROM Orders JOIN Order_Logs ON Orders.Id = Order_Logs.Order_Id " +
    //        "JOIN Order_Detail ON Orders.Id = Order_Detail.Order_Id WHERE Orders.Store_Id = @id", Common.DBConnectionString);


    //    da.SelectCommand.Parameters.AddWithValue("@id", storeid);

    //    DataTable dt = new DataTable();
    //    da.Fill(dt);

    //    List<Order> prodList = new List<Order>();

    //    foreach (DataRow row in dt.Rows)
    //    {
    //        prodList.Add(new Order(
    //            Convert.ToInt32(row["Id"]),
    //            row["UserName"].ToString(),
    //            row["RealName"].ToString(),
    //            row["Address"].ToString(),
    //            row["Phone"].ToString(),
    //            row["Status"].ToString(),
    //            Convert.ToInt32(row["Product_Id"]),
    //            Convert.ToInt32(row["Count"]),
    //            Convert.ToDateTime(row["Create_time"])
    //            ));
    //    }

    //    return prodList;
    //}

    public static string GetXML()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "SELECT * FROM Orders JOIN Order_Detail ON Orders.Id = Order_Detail.Order_Id " +
            "JOIN Products ON Products.Id = Order_Detail.Product_Id " +
            "JOIN Stores ON Stores.Id = Orders.Store_Id", Common.DBConnectionString);


        DataSet ds = new DataSet();
        da.Fill(ds);

        return ds.GetXml();
    }
    public static string GetXML(int storeid)
    {
        //SqlDataAdapter da = new SqlDataAdapter(
        //    "SELECT * FROM Orders JOIN Order_Logs ON Orders.Id = Order_Logs.Order_Id " +
        //    "JOIN Order_Detail ON Orders.Id = Order_Detail.Order_Id WHERE Orders.Store_Id = @id", Common.DBConnectionString);

        SqlDataAdapter da = new SqlDataAdapter(
            " SELECT * FROM Orders JOIN Order_Detail ON Orders.Id = Order_Detail.Order_Id " +
            "JOIN Products ON Order_Detail.Product_Id = Products.Id WHERE Orders.Store_Id = @id", Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@id", storeid);

        DataSet ds = new DataSet();
        da.Fill(ds);

        return ds.GetXml();
    }
}