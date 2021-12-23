using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Member
{
    public Member(int  id , string userName, string password, string email)
    {
        Id = id;
        UserName = userName;
        Password = password;
        Email = email;
    }

    public Member(int id, string userName,  string email, string phone, string address, string gender, int status)
    {
        Id = id;
        UserName = userName;
        Email = email;
        Phone = phone;
        Address = address;
        Gender = gender;
        Status = status;
    }

    public Member(int id, string userName, string password, string email, string phone, string address, string gender)
    {
        Id = id;
        UserName = userName;
        Password = password;
        Email = email;
        Phone = phone;
        Address = address;
        Gender = gender;
    }

    public Member(int id, string userName, string password, string email, string phone, string address, string gender, int status)
    {
        Id = id;
        UserName = userName;
        Password = password;
        Email = email;
        Phone = phone;
        Address = address;
        Gender = gender;
        Status = status;
    }

    public int Id { get; set; }
    public string UserName { get; set; }
    public string Password { get; set; }
    public string Email { get; set; }
    public string Phone { get; set; }
    public string Address { get; set; }
    public string Gender { get; set; }
    public int Status { get; set; }
}