using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Order 的摘要描述
/// </summary>
public class Order
{
    public Order(int masterOrder_Id, int order_Id, string status, string userName, string realName, string address, string phone, string productName, int count, string storeName)
    {
        MasterOrder_Id = masterOrder_Id;
        Order_Id = order_Id;
        Status = status;
        UserName = userName;
        RealName = realName;
        Address = address;
        Phone = phone;
        ProductName = productName;
        Count = count;
        StoreName = storeName;
    }

    public Order(int masterOrder_Id, int order_Id, string status, string userName, string realName, string address, string phone, string productName, int count, string storeName, DateTime create_time)
    {
        MasterOrder_Id = masterOrder_Id;
        Order_Id = order_Id;
        Status = status;
        UserName = userName;
        RealName = realName;
        Address = address;
        Phone = phone;
        ProductName = productName;
        Count = count;
        StoreName = storeName;
        Create_time = create_time;
    }

    public Order(int masterOrder_Id, int order_Id, string status, string userName, string realName, string address, string phone, string productName, int count, int price, string storeName, DateTime create_time)
    {
        MasterOrder_Id = masterOrder_Id;
        Order_Id = order_Id;
        Status = status;
        UserName = userName;
        RealName = realName;
        Address = address;
        Phone = phone;
        ProductName = productName;
        Count = count;
        Price = price;
        StoreName = storeName;
        Create_time = create_time;
    }

    public int MasterOrder_Id { get; set; }
    public int Order_Id { get; set; }
    public string Status { get; set; }
    public string UserName { get; set; }
    public string RealName { get; set; }
    public string Address { get; set; }
    public string Phone { get; set; }
    public string ProductName { get; set; }
    public int Count { get; set; }
    public int Price { get; set; }
    public string StoreName { get; set; }
    public DateTime Create_time { get; set; }

}