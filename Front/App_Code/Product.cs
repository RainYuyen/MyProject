using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Product 的摘要描述
/// </summary>
public class Product
{
    public Product(int id, string name, int price, string imageFileName, string info, int store_Id, int category_Id)
    {
        Id = id;
        Name = name;
        Price = price;
        ImageFileName = imageFileName;
        Info = info;
        Store_Id = store_Id;
        Category_Id = category_Id;
    }
    public int Id { get; set; }
    public string Name { get; set; }
    public int Price { get; set; }
    public string ImageFileName { get; set; }
    public string Info { get; set; }
    public int Store_Id { get; set; }
    public int Category_Id { get; set; }
    public Product() { }
}