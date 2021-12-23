using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Order
/// </summary>
public class Order
{
    public Order(int id, string userName, string realName, string address, string phone, string status, int masterOrder_Id, int store_Id)
    {
        Id = id;
        UserName = userName;
        RealName = realName;
        Address = address;
        Phone = phone;
        Status = status;
        MasterOrder_Id = masterOrder_Id;
        Store_Id = store_Id;
    }

    public Order(int id, string userName, string realName, string address, string phone, string status, int product_Id, int count, DateTime create_time)
    {
        Id = id;
        UserName = userName;
        RealName = realName;
        Address = address;
        Phone = phone;
        Status = status;
        Product_Id = product_Id;
        Count = count;
        Create_time = create_time;
    }

    public Order(int id, string userName, string realName, string address, string phone, string status, int masterOrder_Id, int store_Id, int product_Id, int count)
    {
        Id = id;
        UserName = userName;
        RealName = realName;
        Address = address;
        Phone = phone;
        Status = status;
        MasterOrder_Id = masterOrder_Id;
        Store_Id = store_Id;
        Product_Id = product_Id;
        Count = count;
    }

    public Order(int id, string userName, string realName, string address, string phone, string status, int masterOrder_Id, int store_Id, int product_Id, int count, DateTime create_time)
    {
        Id = id;
        UserName = userName;
        RealName = realName;
        Address = address;
        Phone = phone;
        Status = status;
        MasterOrder_Id = masterOrder_Id;
        Store_Id = store_Id;
        Product_Id = product_Id;
        Count = count;
        Create_time = create_time;
    }

    public int Id { get; set; }
    public string UserName { get; set; }
    public string RealName { get; set; }
    public string Address { get; set; }
    public string Phone { get; set; }
    public string Status { get; set; }
    public int Product_Id { get; set; }
    public int MasterOrder_Id { get; set; }
    public int Store_Id { get; set; }
    public int Count { get; set; }
    public DateTime Create_time { get; set; }
    
    

}