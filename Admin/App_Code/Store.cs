using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Store
/// </summary>
public class Store
{
    public Store(string userName, string password, string email)
    {
        UserName = userName;
        Password = password;
        Email = email;
    }
    public Store(int id, string userName, string password, string email)
    {
        Id = id;
        UserName = userName;
        Password = password;
        Email = email;
    }

    public Store(string storeName, string userName, string email,string phone, string address,int roleID)
    {
        StoreName = storeName;
        UserName = userName;
        Email = email;
        Phone = phone;
        Address = address;
        RoleID = roleID;
    }

    public Store(int id, string storeName, string userName, string email, string phone, string address, int roleID)
    {
        Id = id;
        StoreName = storeName;
        UserName = userName;
        Email = email;
        Phone = phone;
        Address = address;
        RoleID = roleID;
    }

    public Store(int id, string userName, string password, string email, string storeName, string phone, string address, int roleID)
    {
        Id = id;
        UserName = userName;
        Password = password;
        Email = email;
        StoreName = storeName;
        Phone = phone;
        Address = address;
        RoleID = roleID;
    }

    public int Id { get; set; }
    public string UserName { get; set; }
    public string Password { get; set; }
    public string Email { get; set; }
    public string StoreName { get; set; }
    public string Phone { get; set; }
    public string Address { get; set; }
    public int RoleID { get; set; }
    public string Qrcodekey { get; set; }
    public Store() { }

    public Store(int id, string qrcodekey)
    {
        Id = id;
        Qrcodekey = qrcodekey;
    }
}