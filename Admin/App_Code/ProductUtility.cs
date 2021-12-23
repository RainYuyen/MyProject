using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// ProductUtility 的摘要描述
/// </summary>
public class ProductUtility
{
    public static void Add(string name, int price, string imagefilename, string info, int category, int storeid)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand(
            "insert into Products(Name, Price, ImageFileName, Info, Category_Id, Store_Id) values(@name, @price, @imagefilename,@info,@category,@storeid)", cn);

        cmd.Parameters.AddWithValue("@name", name);
        cmd.Parameters.AddWithValue("@price", price);
        cmd.Parameters.AddWithValue("@imagefilename", imagefilename);
        cmd.Parameters.AddWithValue("@info", info);
        cmd.Parameters.AddWithValue("@category", category);
        cmd.Parameters.AddWithValue("@storeid", storeid);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void Update(int id, string name, int price, string imagefilename, string info, int category)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "update Products set Name = @name, Price = @price, ImageFileName = @imagefilename, Info = @info, Category_Id = @category where Id = @id", cn);

        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@name", name);
        cmd.Parameters.AddWithValue("@price", price);
        cmd.Parameters.AddWithValue("@imagefilename", imagefilename);
        cmd.Parameters.AddWithValue("@info", info);
        cmd.Parameters.AddWithValue("@category", category);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void Delete(int id)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "delete Products where Id = @id", cn);

        cmd.Parameters.AddWithValue("@id", id);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }



    public static List<Product> GetProducts()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Products;", Common.DBConnectionString);

        DataTable dt = new DataTable();
        da.Fill(dt);

        List<Product> prodList = new List<Product>();

        foreach (DataRow row in dt.Rows)
        {
            prodList.Add(new Product(
                Convert.ToInt32(row["Id"]),
                row["Name"].ToString(),
                Convert.ToInt32(row["Price"]),
                row["ImageFileName"].ToString(),
                row["Info"].ToString(),
                Convert.ToInt32(row["Store_Id"]),
                Convert.ToInt32(row["Category_Id"])
                ));
        }

        return prodList;
    }

    public static Product GetProduct(int id)
    {
        SqlDataAdapter da = new SqlDataAdapter(
                "select * from Products where Id = @id",
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

            return new Product(
               Convert.ToInt32(row["Id"]),
                row["Name"].ToString(),
                Convert.ToInt32(row["Price"]),
                row["ImageFileName"].ToString(),
                row["Info"].ToString(),
                Convert.ToInt32(row["Store_Id"]),
                Convert.ToInt32(row["Category_Id"])
                );
        }

    }


    public static string GetXML()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "SELECT * FROM Products JOIN Categorys ON Categorys.Id = Products.Category_Id JOIN Stores ON Products.Store_Id = Stores.Id", Common.DBConnectionString);

        DataSet ds = new DataSet();
        da.Fill(ds);

        return ds.GetXml();
    }
    public static string GetXML(int storeid)
    {
        //SqlDataAdapter da = new SqlDataAdapter(
        //    "select * from Products where Store_Id = @storeid", Common.DBConnectionString);
        SqlDataAdapter da = new SqlDataAdapter(
           "SELECT* FROM Products JOIN Categorys ON Categorys.Id = Products.Category_Id WHERE Store_Id = @storeid", Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@storeid", storeid);

        DataSet ds = new DataSet();
        da.Fill(ds);

        return ds.GetXml();
    }

}