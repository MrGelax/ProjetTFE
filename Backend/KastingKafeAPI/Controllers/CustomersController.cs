using KastingKafeAPI.DataAccess;
using KastingKafeAPI.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
namespace KastingKafeAPI.Controllers{
    [ApiController]
    [Route("api/[controller]")]
    public sealed class CustomersController : ControllerBase{
        private readonly IConfiguration configuration;

        public CustomersController(IConfiguration configuration){
            this.configuration = configuration;
        }

        //GET:    api/Customer
        [HttpGet]
        public async Task<ActionResult> Get(){
            await using var db = new CustomersDbContext(configuration);
            var customers = await db.Customer
                .Include(x => x.Organization)
                .Include(x => x.User)
                .Include(x => x.CustomerEventSetup)
                .Include(x => x.MainRole)
                .Include(x => x.CustomerSubscription)
                .ToListAsync();

            return Ok(customers);
        }

        //GET:    api/Customer/id
        [HttpGet("{id}")]
        public async Task<ActionResult> GetById(int id){
            await using var db = new CustomersDbContext(configuration);
            var customers = await db.Customer.FindAsync(id);

            if (customers == null)
                return NotFound();

            return Ok(customers);
        }

        [HttpGet("Validation")]
        public async Task<ActionResult> GetCustomerWaitingValidation(){
            await using var db = new CustomersDbContext(configuration);
            var customers = await db.Customer
                .Include(x => x.Organization)
                .Include(x => x.User)
                .Include(x => x.CustomerEventSetup)
                .Include(x => x.MainRole)
                .Include(x => x.CustomerSubscription)
                .Where(c => c.CustomerStatus == 3)
                .ToListAsync();
            //var customers = await db.Customer.Where(c => c.CustomerStatus == 3).ToListAsync();

            Console.WriteLine(customers.ToString());
            return Ok(customers);
        }

        //DELETE:    api/Customer/id
        [HttpDelete("{id}")]
        public async Task<ActionResult<Customer>> Delete(int id){
            await using var db = new CustomersDbContext(configuration);
            var customers = await db.Customer.FindAsync(id);
            if (customers == null)
                return NotFound();

            db.Customer.Remove(customers);
            await db.SaveChangesAsync();
            return Ok(customers);
        }

        //POST:    api/Customer
        [HttpPost]
        public async Task<ActionResult> Create([FromBody]Customer customer){
            var now = DateTime.Now;
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            await using var db = new CustomersDbContext(configuration);
            customer.CreatedDateTime = now;
            customer.LastmodifiedDateTime = customer.LastmodifiedDateTime ?? now;

            db.Customer.Add(customer);
            await db.SaveChangesAsync();
            return CreatedAtAction("GetById", new { id = customer.Id }, customer);
        }

        //PUT:    api/Customer
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, Customer customer){
            var now = DateTime.Now;
            if (id != customer.Id)
                return BadRequest();

            await using var db = new CustomersDbContext(configuration);
            customer.LastmodifiedDateTime = customer.LastmodifiedDateTime ?? now;
            db.Entry(customer).State = EntityState.Modified;
            try{
                await db.SaveChangesAsync();
            }catch (DbUpdateConcurrencyException){
                if (!CustomerExists(id))
                    return NotFound();
                else
                    throw;
            }
            return Ok(customer);
        }

        private bool CustomerExists(int id){
            using var db = new CustomersDbContext(configuration);
            return db.Customer.Any(x => x.Id == id);
        }
    }
}