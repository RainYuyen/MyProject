using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for ProductUtility
/// </summary>
public class ProductUtility
{
    //private static string FilePath = HttpContext.Current.Server.MapPath("products.csv");

    public static void Add(Product p)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "insert into Products values (@name, @price, @imageFileName)", cn);

        cmd.Parameters.AddWithValue("@name", p.Name);
        cmd.Parameters.AddWithValue("@price", p.Price);
        cmd.Parameters.AddWithValue("@imageFileName", p.ImageFileName);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void Update(Product p)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "update Products set name = @name, price = @price, ImageFileName = @imageFileName where id = @id", cn);

        cmd.Parameters.AddWithValue("@id", p.Id);
        cmd.Parameters.AddWithValue("@name", p.Name);
        cmd.Parameters.AddWithValue("@price", p.Price);
        cmd.Parameters.AddWithValue("@imageFileName", p.ImageFileName);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void Delete(int id)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "delete Products where id = @id", cn);

        cmd.Parameters.AddWithValue("@id", id);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }


    public static List<Product> GetProducts()
    {
        SqlDataAdapter da = new SqlDataAdapter(
        "select * from Products",
        Common.DBConnectionString);

        DataTable dt = new DataTable();

        da.Fill(dt);

        List<Product> ProdList = new List<Product>();

        foreach (DataRow row in dt.Rows)
        {
            ProdList.Add(new Product(
                Convert.ToInt32(row["Id"]),
                row["Name"].ToString(),
                Convert.ToInt32(row["Price"]),
                row["ImageFileName"].ToString(),
                row["Info"].ToString(),
                Convert.ToInt32(row["Store_Id"]),
                Convert.ToInt32(row["Category_Id"])
                ));
        }

        return ProdList;
    }

    public static List<Product> GetProducts(int id,int storeid)
    {
        SqlDataAdapter da = new SqlDataAdapter(
        "select * from Products where Category_Id = @id OR Store_Id = @storeid",
        Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("id", id);
        da.SelectCommand.Parameters.AddWithValue("storeid", storeid);

        DataTable dt = new DataTable();

        da.Fill(dt);

        List<Product> ProdList = new List<Product>();

        foreach (DataRow row in dt.Rows)
        {
            ProdList.Add(new Product(
                Convert.ToInt32(row["Id"]),
                row["Name"].ToString(),
                Convert.ToInt32(row["Price"]),
                row["ImageFileName"].ToString(),
                row["Info"].ToString(),
                Convert.ToInt32(row["Store_Id"]),
                Convert.ToInt32(row["Category_Id"])
                ));
        }

        return ProdList;
    }

    public static List<Product> GetProducts2(int id, int storeid)
    {
        SqlDataAdapter da = new SqlDataAdapter(
        "select * from Products where Category_Id = @id AND Store_Id = @storeid",
        Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("id", id);
        da.SelectCommand.Parameters.AddWithValue("storeid", storeid);

        DataTable dt = new DataTable();

        da.Fill(dt);

        List<Product> ProdList = new List<Product>();

        foreach (DataRow row in dt.Rows)
        {
            ProdList.Add(new Product(
                Convert.ToInt32(row["Id"]),
                row["Name"].ToString(),
                Convert.ToInt32(row["Price"]),
                row["ImageFileName"].ToString(),
                row["Info"].ToString(),
                Convert.ToInt32(row["Store_Id"]),
                Convert.ToInt32(row["Category_Id"])
                ));
        }

        return ProdList;
    }


    public static Product GetProduct(int id)
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Products where id = @id",
            Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("id", id);

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

    public static string GetPrice(object o)
    {
        int p = (int)o;

        return p.ToString("N0");
    }



    public static string GetXML()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "SELECT * FROM Products", Common.DBConnectionString);

        DataSet ds = new DataSet();
        da.Fill(ds);

        return ds.GetXml();
    }


}