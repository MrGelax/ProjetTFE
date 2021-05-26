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
    public sealed class PortfoliosController : ControllerBase{
        private readonly IConfiguration configuration;

        public PortfoliosController(IConfiguration configuration){
            this.configuration = configuration;
        }
        [HttpGet]
        public async Task<ActionResult> Get(){
            await using var db = new PortfoliosDbContext(configuration);

            var portfolios = await db.Portfolios
                .Include(x => x.customer)
                .Include(x=>x.portfoliosItems)
                .ToListAsync();
            return Ok(portfolios);
        }

        //GET:    api/Event
        [HttpGet("Validation")]
        public async Task<ActionResult> GetPublicationWaitingValidation(){
            await using var db = new PortfoliosDbContext(configuration);

            var portfolios = await db.Portfolios
                .Include(x => x.customer)
                .Include(x => x.portfoliosItems)
                .Where(x => x.StatusId == 1)
                .ToListAsync();
            return Ok(portfolios);
        }

        //GET:    api/Event/id
        [HttpGet("{id}")]
        public async Task<ActionResult> GetById(int id){
            await using var db = new PortfoliosDbContext(configuration);
            var portfolios = await db.Portfolios.FindAsync(id);

            if (portfolios == null)
                return NotFound();

            return Ok(portfolios);

        }

        //DELETE:    api/Event/id
        [HttpDelete("{id}")]
        public async Task<ActionResult<Publication>> Delete(int id){
            await using var db = new PublicationDBContext(configuration);
            var publications = await db.Publication.FindAsync(id);
            if (publications == null)
                return NotFound();

            db.Publication.Remove(publications);
            await db.SaveChangesAsync();

            return Ok(publications);
        }

        //POST:    api/Event
        [HttpPost]
        public async Task<ActionResult> Create([FromBody]Publication publication){
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
        public async Task<IActionResult> Update(int id, Portfolios portfolios){
            var now = DateTime.Now;
            if (id != portfolios.Id)
                return BadRequest();


            await using var db = new PortfoliosDbContext(configuration);
            db.Entry(portfolios).State = EntityState.Modified;
            try{
                await db.SaveChangesAsync();
            }catch (DbUpdateConcurrencyException){
                if (!PortfoliosExists(id))
                    return NotFound();
                else
                    throw;
            }
            return Ok(portfolios);
        }

        private bool PortfoliosExists(int id){
            using var db = new PortfoliosDbContext(configuration);
            return db.Portfolios.Any(x => x.Id == id);
        }

    }
}
