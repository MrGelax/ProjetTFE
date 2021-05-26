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
    public sealed class ReviewController : ControllerBase{
        private readonly IConfiguration configuration;

        public ReviewController(IConfiguration configuration){
            this.configuration = configuration;
        }

        //GET:    api/Event
        [HttpGet]
        public async Task<ActionResult> Get(){
            await using var db = new ReviewDbContext(configuration);

            var reviews = await db.Review
                .Include(x => x.recipientCustomer)
                .Include(x => x.senderCustomer)
                .Include(x=>x.reviewStatus)
                .ToListAsync();
            return Ok(reviews);
        }

        //GET:    api/Event
        [HttpGet("Validation")]
        public async Task<ActionResult> GetPublicationWaitingValidation(){
            await using var db = new ReviewDbContext(configuration);

            var reviews = await db.Review
                .Include(x => x.recipientCustomer)
                .Include(x => x.senderCustomer)
                .Include(x => x.reviewStatus)
                .Where(x => x.ReviewStatusId == 2)
                .ToListAsync();
            return Ok(reviews);
        }

        //GET:    api/Event/id
        [HttpGet("{id}")]
        public async Task<ActionResult> GetById(int id){
            await using var db = new ReviewDbContext(configuration);
            var reviews = await db.Review.FindAsync(id);

            if (reviews == null){
                return NotFound();
            }

            return Ok(reviews);

        }

        //DELETE:    api/Event/id
        [HttpDelete("{id}")]
        public async Task<ActionResult<Review>> Delete(int id){
            await using var db = new ReviewDbContext(configuration);
            var reviews = await db.Review.FindAsync(id);
            if (reviews == null){
                return NotFound();
            }

            db.Review.Remove(reviews);
            await db.SaveChangesAsync();

            return Ok(reviews);
        }

        //POST:    api/Event
        [HttpPost]
        public async Task<ActionResult> Create([FromBody]Review review){
            var now = DateTime.Now;
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            await using var db = new ReviewDbContext(configuration);
            review.CreatedDateTime = now;
            review.LastModifiedDateTime = review.LastModifiedDateTime ?? now;

            db.Review.Add(review);
            await db.SaveChangesAsync();
            return CreatedAtAction("GetById", new { id = review.Id }, review);
        }

        //PUT:    api/Event
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, Review review){
            var now = DateTime.Now;
            if (id != review.Id)
                return BadRequest();

            await using var db = new ReviewDbContext(configuration);
            review.LastModifiedDateTime = review.LastModifiedDateTime ?? now;
            db.Entry(review).State = EntityState.Modified;
            Console.WriteLine(review.ToString());
            try{
                await db.SaveChangesAsync();
            }catch (DbUpdateConcurrencyException){
                if (!ReviewExists(id))
                    return NotFound();
                else
                    throw;
            }
            return Ok(review);
        }

        private bool ReviewExists(int id){
            using var db = new ReviewDbContext(configuration);
            return db.Review.Any(x => x.Id == id);
        }

    }
}
