using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Cart
/// </summary>
public class Cart
{

    public Cart(int id, string name, int price, int count, string imageFileName)
    {
        Id = id;
        Name = name;
        Price = price;
        Count = count;
        ImageFileName = imageFileName;
    }

    public Cart(int id, string name, int price, int count, string imageFileName, int store_Id, int product_id)
    {
        Id = id;
        Name = name;
        Price = price;
        Count = count;
        ImageFileName = imageFileName;
        Store_Id = store_Id;
        Product_Id = product_id;
    }

    public int Id { get; set; }
    public string Name { get; set; }
    public int Price { get; set; }
    public int Count { get; set; }
    public string ImageFileName { get; set; }
    public int Total => Price * Count;
    public int Store_Id { get; set; }
    public int Product_Id { get; set; }


}