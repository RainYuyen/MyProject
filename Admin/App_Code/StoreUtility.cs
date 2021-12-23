using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Providers.Entities;

/// <summary>
/// Summary description for StoreUtility
/// </summary>
public class StoreUtility
{
    public static void Add(Store s)
    {

        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand(
            "insert into Stores(UserName, Password, Email) values(@UserName, @Password, @Email)", cn);

        cmd.Parameters.AddWithValue("@UserName", s.UserName);
        cmd.Parameters.AddWithValue("@Password", Common.ToMD5(s.Password + Common.salt));
        cmd.Parameters.AddWithValue("@Email", s.Email);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void Add(string Username, string Email, string StoreName, string Phone, string Address, int Role)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand(
            "insert into Stores(UserName, Email, Store_Name, Phone, Address, Roles_Id) values(@userName, @email, @storeName,@phone,@address,@roleID)", cn);

        cmd.Parameters.AddWithValue("@UserName", Username);
        cmd.Parameters.AddWithValue("@email", Email);
        cmd.Parameters.AddWithValue("@storeName", StoreName);
        cmd.Parameters.AddWithValue("@phone", Phone);
        cmd.Parameters.AddWithValue("@address", Address);
        cmd.Parameters.AddWithValue("@roleID", Role);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void Update(int id, string password)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "update Stores set  Password = @password where Id = @id", cn);

        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@password", Common.ToMD5(password + Common.salt));


        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void Update(int id, string email, string phone, string address)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "update Stores set  Email = @email, Phone = @phone, Address = @address where Id = @id", cn);

        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@email", email);
        cmd.Parameters.AddWithValue("@phone", phone);
        cmd.Parameters.AddWithValue("@address", address);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void Update(int id, string storename, string username, string email, string phone, string address, int roleid)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "update Stores set Store_Name = @storeName, UserName = @userName, Email = @email, Phone = @phone, Address = @address, Roles_Id = @roleid where Id = @id", cn);

        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@storeName", storename);
        cmd.Parameters.AddWithValue("@userName", username);
        cmd.Parameters.AddWithValue("@email", email);
        cmd.Parameters.AddWithValue("@phone", phone);
        cmd.Parameters.AddWithValue("@address", address);
        cmd.Parameters.AddWithValue("@roleid", roleid);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void Delete(int id)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "delete Stores where Id = @id", cn);

        cmd.Parameters.AddWithValue("@id", id);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static List<Store> GetStores()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Stores;", Common.DBConnectionString);

        DataTable dt = new DataTable();
        da.Fill(dt);

        List<Store> storeList = new List<Store>();

        foreach (DataRow row in dt.Rows)
        {
            storeList.Add(new Store(
                Convert.ToInt32(row["Id"]),
                row["UserName"].ToString(),
                row["Password"].ToString(),
                row["Email"].ToString(),
                row["Store_Name"].ToString(),
                row["Phone"].ToString(),
                row["Address"].ToString(),
                Convert.ToInt32(row["Roles_ID"])
                ));
        }

        return storeList;
    }

    public static Store GetStore(string userName, string password)
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Stores where UserName = @name and Password = @pw",
            Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@name", userName);
        da.SelectCommand.Parameters.AddWithValue("@pw", Common.ToMD5(password + Common.salt));

        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count == 0)
        {
            return null;
        }
        else
        {
            DataRow row = dt.Rows[0];

            return new Store(
                Convert.ToInt32(row["Id"]),
                row["UserName"].ToString(),
                row["Password"].ToString(),
                row["Email"].ToString(),
                row["Store_Name"].ToString(),
                row["Phone"].ToString(),
                row["Address"].ToString(),
                Convert.ToInt32(row["Roles_Id"]));
        }
    }

    public static Store GetStore(int id)
    {
        SqlDataAdapter da = new SqlDataAdapter(
                "select * from Stores where Id = @id",
                Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@id", id);

        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count == 0)
        {
            return null;
        }
        else
        {
            DataRow row = dt.Rows[0];

            return new Store(
                Convert.ToInt32(row["Id"]),
                row["UserName"].ToString(),
                row["Password"].ToString(),
                row["Email"].ToString(),
                row["Store_Name"].ToString(),
                row["Phone"].ToString(),
                row["Address"].ToString(),
                Convert.ToInt32(row["Roles_Id"])
                );
        }

    }

    public static string GetXML()
    {
        //SqlDataAdapter da = new SqlDataAdapter(
        //    "select * from Stores", Common.DBConnectionString);

        SqlDataAdapter da = new SqlDataAdapter(
            "SELECT * FROM Stores JOIN Roles ON Stores.Roles_Id = Roles.Id", Common.DBConnectionString);

        DataSet ds = new DataSet();
        da.Fill(ds);

        return ds.GetXml();
    }

}