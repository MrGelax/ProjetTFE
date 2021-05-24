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
    public sealed class EventController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public EventController(IConfiguration configuration)
        {
            this.configuration = configuration;

        }

        //GET:    api/Event
        [HttpGet]
        public async Task<ActionResult> Get(){
            await using var db = new EventDbContext(configuration);

            var events = await db.Event
                .Include(x => x.customer)
                .Include(x => x.eventStatus)
                .ToListAsync();
            return Ok(events);
        }

        //GET:    api/Event
        [HttpGet("Validation")]
        public async Task<ActionResult> GetEventWaitingValidation(){
            await using var db = new EventDbContext(configuration);

            var events = await db.Event
                .Include(x => x.customer)
                .Include(x => x.eventStatus)
                .Where(x => x.EventStatusId==2)
                .ToListAsync();
            return Ok(events);
        }

        //GET:    api/Event/id
        [HttpGet("{id}")]
        public async Task<ActionResult> GetById(int id)
        {
            await using var db = new EventDbContext(configuration);
            var events = await db.Event.FindAsync(id);

            if (events == null)
            {
                return NotFound();
            }

            return Ok(events);

        }

        //DELETE:    api/Event/id
        [HttpDelete("{id}")]
        public async Task<ActionResult<Event>> Delete(int id)
        {
            await using var db = new EventDbContext(configuration);
            var events = await db.Event.FindAsync(id);
            if (events == null)
            {
                return NotFound();
            }

            db.Event.Remove(events);
            await db.SaveChangesAsync();

            return Ok(events);
        }

        //POST:    api/Event
        [HttpPost]
        public async Task<ActionResult> Create([FromBody]Event @event)
        {
            var now = DateTime.Now;
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            await using var db = new EventDbContext(configuration);

            @event.CreatedDateTime = now;
            @event.LastModifiedDateTime = @event.LastModifiedDateTime ?? now;

            db.Event.Add(@event);

            await db.SaveChangesAsync();

            return CreatedAtAction("GetById", new { id = @event.Id }, @event);
        }

        //PUT:    api/Event
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, Event @event)
        {

            var now = DateTime.Now;

            if (id != @event.Id)
            {
                return BadRequest();
            }

            await using var db = new EventDbContext(configuration);


            @event.LastModifiedDateTime = @event.LastModifiedDateTime ?? now;

            db.Entry(@event).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!EventExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            return Ok(@event);
        }

        private bool EventExists(int id)
        {
            using var db = new EventDbContext(configuration);
            return db.Event.Any(x => x.Id == id);
        }

    }
}
