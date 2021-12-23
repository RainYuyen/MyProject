using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using StarterM.Data;
using StarterM.Models;

namespace StarterM.Controllers
{
    public class OrdersController : Controller
    {
        private readonly MydbContext _context;

        public OrdersController(MydbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> getResult(int? id, string phone)
        {
            if (id != null && phone !=null)
            {

                return Json(await _context.Orders.SingleOrDefaultAsync(o => o.Id == id && o.Phone == phone));
            }
            else
            {
                return View();
            }
        }

        [HttpPost]
        public async Task<IActionResult> SaveStatus(int id)
        {
 
            if (ModelState.IsValid)
            {
                var up = await _context.Orders.SingleOrDefaultAsync(o => o.Id == id);
                up.Status = "arrive";
                up.UpdateTime = DateTime.Now;

                _context.Update(up);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Search));
            }
            return View(nameof(Search));


        }




        public IActionResult Search()
        {
            return View();
        }




        // GET: Orders
        public async Task<IActionResult> Index()
        {
            return View(await _context.Orders.ToListAsync());
        }













    }
}
