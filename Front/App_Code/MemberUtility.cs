using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for MemberUtility
/// </summary>
public class MemberUtility
{
    public static bool Validation(string username, string password, string email, out string msg)
    {
        msg = "";
        //1.檢查欄位是否都有輸入
        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(email))
        {
            msg = "每個欄位皆須填入資料";
            return false;
        }
        //2.檢查帳號及mail是否有重複
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("SELECT UserName,Password FROM Members WHERE UserName = @username OR Email = @email", cn);
        da.SelectCommand.Parameters.AddWithValue("@username", username);
        da.SelectCommand.Parameters.AddWithValue("@email", email);
        DataTable table = new DataTable();
        cn.Open();
        da.Fill(table);
        cn.Close();
        if (table.Rows.Count > 0)
        {
            msg = "帳號或Email已存在，請重新輸入";
            return false;
        }

        return true;
    }

    public static void Add(Member m)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand(
            "insert into Members(UserName,Password,Email) values(@userName , @password , @email)",
            cn);

        cmd.Parameters.AddWithValue("@userName", m.UserName);
        cmd.Parameters.AddWithValue("@password", Common.ToMD5(m.Password + Common.salt));
        cmd.Parameters.AddWithValue("@email", m.Email);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    //public static void Update(Member m)
    //{
    //    SqlConnection cn = new SqlConnection(Common.DBConnectionString);

    //    SqlCommand cmd = new SqlCommand("update Members set UserName = @userName, Password = @password, Email = @email where Id = @id",
    //                                    cn);

    //    cmd.Parameters.AddWithValue("@id", m.Id);
    //    cmd.Parameters.AddWithValue("@userName", m.UserName);
    //    cmd.Parameters.AddWithValue("@password", m.Password);
    //    cmd.Parameters.AddWithValue("@email", m.Email);

    //    cn.Open();
    //    cmd.ExecuteNonQuery();
    //    cn.Close();
    //}

    public static void Delete(int id)
    {
        SqlConnection cn = new SqlConnection(Common.DBConnectionString);

        SqlCommand cmd = new SqlCommand("delete Members where Id = @id",
                                        cn);

        cmd.Parameters.AddWithValue("@id", id);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static List<Member> GetMembers()
    {
        SqlDataAdapter da = new SqlDataAdapter(
                "select * from Members",
                Common.DBConnectionString);

        DataTable dt = new DataTable();

        da.Fill(dt);

        List<Member> memberList = new List<Member>();

        foreach (DataRow row in dt.Rows)
        {
            memberList.Add(new Member(
                Convert.ToInt32(row["id"]),
                row["userName"].ToString(),
                row["password"].ToString(),
                row["email"].ToString()));
        }

        return memberList;
    }

    public static Member GetMember(string userName, string password)
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Members where UserName = @name and Password = @pw",
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

            return new Member(
                Convert.ToInt32(row["Id"]),
                row["UserName"].ToString(),
                row["Email"].ToString(),
                row["Phone"].ToString(),
                row["Address"].ToString(),
                row["Gender"].ToString(),
                Convert.ToInt32(row["Status"]));
        }
    }

    public static Member GetMember(int id)
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Members where id = @id",
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

            return new Member(
                Convert.ToInt32(row["Id"]),
                row["UserName"].ToString(),
                row["Password"].ToString(),
                row["Email"].ToString());
        }


    }


}