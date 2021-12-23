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
    //public static Order GetStatus(int id)
    //{

    //}
    public static List<Order> GetMasterOrders(string username)
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "SELECT * FROM MasterOrders JOIN Orders ON MasterOrders.Id = Orders.MasterOrder_Id WHERE Orders.UserName = @username", Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@username", username);

        DataTable dt = new DataTable();
        da.Fill(dt);

        List<Order> orders = new List<Order>();

        foreach (DataRow row in dt.Rows)
        {
            //orders.Add(new Order(
            //    Convert.ToInt32(row["MasterOrder_Id"]),
            //    Convert.ToInt32(row["Order_Id"]),
            //    row["Status"].ToString(),
            //    row["UserName"].ToString(),
            //    row["RealName"].ToString(),
            //    row["Address"].ToString(),
            //    row["Phone"].ToString(),
            //    row["Name"].ToString(),
            //    Convert.ToInt32(row["Count"]),
            //    Convert.ToInt32(row["Price"]),
            //    row["Store_Name"].ToString(),
            //    Convert.ToDateTime(row["Create_time"].ToString())
            //    ));
        }

        return orders;
    }

    public static List<Order> GetOrders(string username)
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "SELECT * FROM Orders JOIN Order_Detail ON Orders.Id = Order_Detail.Order_Id " +
            "JOIN Products ON Order_Detail.Product_Id = Products.Id " +
            "JOIN Stores ON Orders.Store_Id = Stores.Id WHERE Orders.UserName = @username ", Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@username", username);

        DataTable dt = new DataTable();
        da.Fill(dt);

        List<Order> orders = new List<Order>();

        foreach (DataRow row in dt.Rows)
        {
            orders.Add(new Order(
                Convert.ToInt32(row["MasterOrder_Id"]),
                Convert.ToInt32(row["Order_Id"]),
                row["Status"].ToString(),
                row["UserName"].ToString(),
                row["RealName"].ToString(),
                row["Address"].ToString(),
                row["Phone"].ToString(),
                row["Name"].ToString(),
                Convert.ToInt32(row["Count"]),
                Convert.ToInt32(row["Price"]),
                row["Store_Name"].ToString(),
                Convert.ToDateTime(row["Create_time"].ToString())
                ));
        }

        return orders;
    }

    public static string GetXML(string username)
    {

        SqlDataAdapter da = new SqlDataAdapter(
                "SELECT o.*, od.Count, p.Price, p.Name FROM Orders AS o JOIN Order_Detail AS od ON o.Id = od.Order_Id" +
                " JOIN Products AS p ON od.Product_Id = p.Id" +
                " JOIN MasterOrders AS m ON m.Id = o.MasterOrder_Id WHERE o.UserName = @username", Common.DBConnectionString);


        da.SelectCommand.Parameters.AddWithValue("@username", username);


        DataSet ds = new DataSet();
        da.Fill(ds);

        return ds.GetXml();
    }
    public static string GetStatusXML(int id)
    {

        SqlDataAdapter da = new SqlDataAdapter(
                "SELECT * FROM Order_Logs WHERE Order_Id = @id", Common.DBConnectionString);


        da.SelectCommand.Parameters.AddWithValue("@id", id);


        DataSet ds = new DataSet();
        da.Fill(ds);

        return ds.GetXml();
    }



    public static bool CreateOrder(List<Cart> cartList,string username, string realname, string phone, string address)
    {
        bool flag = true;
        //建立主單ID => 單號取回
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        cn.Open();

        SqlTransaction st;
        st = cn.BeginTransaction();

        try
        {
            SqlCommand cmd = new SqlCommand(
                "insert into MasterOrders(Status, Create_time, Update_time ) values (@status, @createtime, @uptime);SELECT @@IDENTITY as id", cn);


            cmd.Parameters.AddWithValue("@status", "booking");
            cmd.Parameters.AddWithValue("@createtime", Common.GetDateTime());
            cmd.Parameters.AddWithValue("@uptime", Common.GetDateTime());

            cmd.Transaction = st;

            int i = int.Parse(cmd.ExecuteScalar().ToString());
            List<int> StoreIdList = new List<int>();

            for (int k = 0; k < cartList.Count; k++)
            {
                if (!StoreIdList.Contains(cartList[k].Store_Id))
                {
                    StoreIdList.Add(cartList[k].Store_Id);
                }
            }
            for (int l = 0; l < StoreIdList.Count; l++)
            {
                SqlCommand cmd3 = new SqlCommand(
                    "insert into Orders(UserName, RealName, Address, Phone, Status, MasterOrder_Id, Store_Id, Create_time, Update_time) values (@UserName, @RealName, @Address, @Phone, @Status, @MasterOrder_Id, @Store_Id, @createtime, @uptime);SELECT SCOPE_IDENTITY()", cn);

                cmd3.Parameters.AddWithValue("@UserName", username);
                cmd3.Parameters.AddWithValue("@RealName", realname);
                cmd3.Parameters.AddWithValue("@Address", address);
                cmd3.Parameters.AddWithValue("@Phone", phone);
                cmd3.Parameters.AddWithValue("@Status", "booking");
                cmd3.Parameters.AddWithValue("@MasterOrder_Id", i);
                cmd3.Parameters.AddWithValue("@Store_Id", StoreIdList[l]);
                cmd3.Parameters.AddWithValue("@createtime", Common.GetDateTime());
                cmd3.Parameters.AddWithValue("@uptime", Common.GetDateTime());

                cmd3.Transaction = st;
                int orderid = int.Parse(cmd3.ExecuteScalar().ToString());

                for (int m = 0; m < cartList.Count; m++)
                {
                    if (cartList[m].Store_Id == StoreIdList[l])
                    {
                        SqlCommand cmd5 = new SqlCommand(
                            "insert into Order_Detail values (@Order_Id, @Store_Id, @Product_Id, @Count)", cn);

                        cmd5.Parameters.AddWithValue("@Order_Id", orderid);
                        cmd5.Parameters.AddWithValue("@Store_Id", cartList[m].Store_Id);
                        cmd5.Parameters.AddWithValue("@Product_Id", cartList[m].Id);
                        cmd5.Parameters.AddWithValue("@Count", cartList[m].Count);

                        cmd5.Transaction = st;
                        cmd5.ExecuteNonQuery();
                    }
                }

            }
            st.Commit();


        }
        catch (Exception ex)
        {
            st.Rollback();
            flag = false;
        }
        finally
        {
            cn.Close();
        }
        return flag;
    }

}