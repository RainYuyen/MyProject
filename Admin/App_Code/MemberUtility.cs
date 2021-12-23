using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MemberUtility
/// </summary>
public class MemberUtility
{


    public static void Update(int id, string email, string phone, string address, string note)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "update Members set Email = @email, Phone = @phone, Address = @address, Note = @note where Id = @id", cn);

        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@email", email);
        cmd.Parameters.AddWithValue("@phone", phone);
        cmd.Parameters.AddWithValue("@address", address);
        cmd.Parameters.AddWithValue("@note", note);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static Member GetMember(int id)
    {
        SqlDataAdapter da = new SqlDataAdapter(
                "select * from Members where Id = @id",
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

            return new Member(
                Convert.ToInt32(row["Id"]),
                row["Email"].ToString(),
                row["Phone"].ToString(),
                row["Address"].ToString(),
                row["Note"].ToString()
                );
        }

    }


    public static string GetXML()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "SELECT * FROM Members", Common.DBConnectionString);

        DataSet ds = new DataSet();
        da.Fill(ds);

        return ds.GetXml();
    }

    public static void CancelMember(int id)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "update Members set Status = @status where Id = @id", cn);

        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@Status", 0);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static void ReopenMember(int id)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "update Members set Status = @status where Id = @id", cn);

        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@Status", 1);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }


}