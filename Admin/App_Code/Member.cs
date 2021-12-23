using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Member
/// </summary>
public class Member
{
    public Member(int id,  string email, string phone, string address, string note)
    {
        Id = id;
        Email = email;
        Phone = phone;
        Address = address;
        Note = note;
    }

    public Member(int id, string password, string email, string phone, string address, string gender, int status, string note)
    {
        Id = id;
        Password = password;
        Email = email;
        Phone = phone;
        Address = address;
        Gender = gender;
        Status = status;
        Note = note;
    }

    public int Id { get; set; }
    public string Password { get; set; }
    public string Email { get; set; }
    public string Phone { get; set; }
    public string Address { get; set; }
    public string Gender { get; set; }
    public int Status { get; set; }
    public string Note { get; set; }
}