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

namespace KastingKafeAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PageLocalController : ControllerBase
    {
        private readonly IConfiguration configuration;

        public PageLocalController(IConfiguration configuration)
        {
            this.configuration = configuration;
        }
        //GET:    api/BlockLocal
        [HttpGet]
        public async Task<ActionResult> Get()//Fonctionne
        {
            await using var db = new PagesLocalDbContext(configuration);
            var pageLocals = await db.PageLocal
                .ToListAsync();
            return Ok(pageLocals);
        }
        public List<PagesLocal> GetPageLocals(int pageid)
        {
            var db = new PagesLocalDbContext(configuration);
            List<PagesLocal> res = new List<PagesLocal>();
            var blcs = db.PageLocal.ToList();
            foreach (var pageLocal in blcs)
            {
                if (pageLocal.PageId == pageid)
                {
                    res.Add(pageLocal);
                    Console.WriteLine("Je suis dans la liste local et je suis dans le local " + pageLocal.LanguageCode);
                }
            }
            return res;
        }

        //GET:    api/BlockLocal/id
        [HttpGet("{id}")]//Fonctionne
        public async Task<ActionResult> GetById(int id)
        {
            await using var db = new PagesLocalDbContext(configuration);
            var pages = await db.PageLocal.FindAsync(id);

            if (pages == null)
            {
                return NotFound();
            }
            return Ok(pages);
        }

        //DELETE:    api/BlockLocal/id
        [HttpDelete("{id}")]//Fonctionne
        public async Task<ActionResult<PagesLocal>> Delete(int id)
        {
            await using var db = new PagesLocalDbContext(configuration);
            var pages = await db.PageLocal.FindAsync(id);
            if (pages == null)
            {
                return NotFound();
            }
            db.PageLocal.Remove(pages);
            await db.SaveChangesAsync();
            return Ok(pages);
        }

        //POST:    api/BlockLocal
        [HttpPost] //fonctionne
        public async Task<ActionResult> Create([FromBody]PagesLocal pages)
        {
            var now = DateTime.Now;
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            await using var db = new PagesLocalDbContext(configuration);
            pages.CreatedDateTime = now;
            pages.LastModifiedDateTime = pages.LastModifiedDateTime ?? now;
            db.PageLocal.Add(pages);

            await db.SaveChangesAsync();
            return CreatedAtAction("GetById", new { id = pages.Id }, pages);
        }

        //PUT:    api/BlockLocal
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, PagesLocal page)//Fonctionne
        {
            var now = DateTime.Now;
            if (id != page.Id)
            {
                return BadRequest();
            }
            await using var db = new PagesLocalDbContext(configuration);
            page.LastModifiedDateTime = page.LastModifiedDateTime ?? now;
            db.Entry(page).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PageExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            return Ok(page);
        }
        private bool PageExists(int id)
        {
            using var db = new PagesLocalDbContext(configuration);
            return db.PageLocal.Any(x => x.Id == id);
        }
    }
}
