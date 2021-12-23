using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Web;
using Google.Authenticator;
using QRCoder;

/// <summary>
/// Summary description for Common
/// </summary>
public class Common
{
    public static string DBConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["MyDBConnectionString1"].ConnectionString;
        }
    }

    public static string GetIp()
    {
        string ip = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (string.IsNullOrEmpty(ip))
        {
            ip = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }
        return ip;
    }

    public static string salt = "ASDJKLQWEUIOZXCNMB";
    public static string ToMD5(string str)
    {
        using (var cryptoMD5 = System.Security.Cryptography.MD5.Create())
        {

            //將字串編碼成 UTF8 位元組陣列
            var bytes = Encoding.UTF8.GetBytes(str);

            //取得雜湊值位元組陣列
            var hash = cryptoMD5.ComputeHash(bytes);

            //取得 MD5
            var md5 = BitConverter.ToString(hash)
              .Replace("-", String.Empty)
              .ToUpper();

            return md5;
        }
    }

    public static string CreateSecretKeyAndQrCode(string email)
    {
        TwoFactorAuthenticator tfA = new TwoFactorAuthenticator();
        var setupCode = tfA.GenerateSetupCode(email, email, "123456", false, 3);

        SqlConnection cn = new SqlConnection(Common.DBConnectionString);
        SqlCommand cmd = new SqlCommand(
            "update Stores set Qrcodekey = @key where Email = @email", cn);

        cmd.Parameters.AddWithValue("@key", setupCode.ManualEntryKey);
        cmd.Parameters.AddWithValue("@email", email);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();

        //2. 產生的金鑰與資訊
        return setupCode.ManualEntryKey;
    }


    //public static string GetKey(int id)
    //{
    //    SqlConnection connection = new SqlConnection(Common.DBConnectionString);

    //    SqlCommand Command = new SqlCommand("SELECT Stores.Qrcodekey FROM Stores WHERE Id = @id", connection);

    //    Command.Parameters.AddWithValue("@id", id);

    //    connection.Open();
    //    SqlDataReader Reader = Command.ExecuteReader();

    //    string s = "";

    //    if (Reader.HasRows)
    //    {
    //        if (Reader.Read())
    //        {

    //            s = Reader["Qrcodekey"].ToString();

    //        }
    //    }

    //    connection.Close();

    //    return s;
    //}

    public static List<string> GeneratorCurrentCode()
    {
        var resultArray = new TwoFactorAuthenticator().GetCurrentPINs("123456");
        var resultList = new List<string>(resultArray);
        return resultList;
    }

}

public class ChartData
{
    public string[] StoreName { get; set; }
    public int[] OrderCount { get; set; }
}
