using KastingKafeAPI.DataAccess;
using KastingKafeAPI.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Controllers{
    [ApiController]
    [Route("api/[controller]")]
    public sealed class CustomerServiceController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public CustomerServiceController(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        //GET:    api/Event
        [HttpGet]
        public async Task<ActionResult> Get(){
            await using var db = new CustomerServiceDbContext(configuration);

            var customerServices = await db.CustomerService
                .Include(x => x.customer)
                .Include(x => x.serviceType)
                .Include(x=> x.city)
                .ToListAsync();
            return Ok(customerServices);
        }

        //GET:    api/Event
        [HttpGet("Validation")]
        public async Task<ActionResult> GetCustomerServicesWaitingValidation(){
            await using var db = new CustomerServiceDbContext(configuration);

            var publications = await db.CustomerService
                .Include(x => x.customer)
                .Include(x => x.serviceType)
                .Where(x => x.StatusId == 1)
                .ToListAsync();
            return Ok(publications);
        }

        //GET:    api/Event/id
        [HttpGet("{id}")]
        public async Task<ActionResult> GetById(int id){
            await using var db = new CustomerServiceDbContext(configuration);
            var customerServices = await db.CustomerService.FindAsync(id);

            if (customerServices == null)
                return NotFound();

            return Ok(customerServices);
        }

        //DELETE:    api/Event/id
        [HttpDelete("{id}")]
        public async Task<ActionResult<Publication>> Delete(int id)
        {
            await using var db = new PublicationDBContext(configuration);
            var publications = await db.Publication.FindAsync(id);
            if (publications == null)
            {
                return NotFound();
            }

            db.Publication.Remove(publications);
            await db.SaveChangesAsync();

            return Ok(publications);
        }

        //POST:    api/Event
        [HttpPost]
        public async Task<ActionResult> Create([FromBody]Publication publication)
        {
            var now = DateTime.Now;
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            await using var db = new PublicationDBContext(configuration);
            publication.CreatedDateTime = now;
            publication.LastModifiedDateTime = publication.LastModifiedDateTime ?? now;

            db.Publication.Add(publication);
            await db.SaveChangesAsync();
            return CreatedAtAction("GetById", new { id = publication.Id }, publication);
        }

        //PUT:    api/Event
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, CustomerService customerService){
            var now = DateTime.Now;
            if (id != customerService.Id)
                return BadRequest();

            await using var db = new CustomerServiceDbContext(configuration);
            customerService.LastModifiedDateTime = customerService.LastModifiedDateTime ?? now;
            db.Entry(customerService).State = EntityState.Modified;
            try{
                await db.SaveChangesAsync();
            }catch (DbUpdateConcurrencyException){
                if (!CustomerServiceExists(id))
                    return NotFound();
                else
                    throw;
            }
            return Ok(customerService);
        }

        private bool CustomerServiceExists(int id){
            using var db = new CustomerServiceDbContext(configuration);
            return db.CustomerService.Any(x => x.Id == id);
        }

    }
}
