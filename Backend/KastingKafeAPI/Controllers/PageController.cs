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
    public sealed class PageController : BasePageController{
        private readonly IConfiguration configuration;

        public PageController(IConfiguration configuration) :
            base(configuration)
        {
            this.configuration = configuration;
        }

        //GET:    api/Block
        [HttpGet]
        public async Task<ActionResult> Get(int? page, int? pageSize){
            if (page == null && pageSize == null)
                return Ok(new { TotalCount = Database.Page.Count(), Pages = Database.Page.ToList() });

            var pages = Database.Page.Skip(((page - 1) * pageSize).Value).Take(pageSize.Value).ToList();

            return Ok(new { TotalCount = Database.Page.Count(), Pages = pages });
        }

        //GET:    api/Block/id
        [HttpGet("{id}")]//Fonctionne
        public async Task<ActionResult> GetById(int id){
            var pages = await Database.Page.FindAsync(id);
            if (pages == null)
                return NotFound();
            return Ok(pages);
        }

        //DELETE:    api/Block/id
        [HttpDelete("{id}")] //Fonctionne
        public async Task<ActionResult<Pages>> Delete(int id){
            var pages = await Database.Page.FindAsync(id);
            var bLC = new PageLocalController(configuration);

            List<PagesLocal> pageLocals = bLC.GetPageLocals(pages.Id);
            if (pages == null)
                return NotFound();
            foreach (var pageLocal in pageLocals){
                await bLC.Delete(pageLocal.Id);
            }
            Database.Page.Remove(pages);
            await Database.SaveChangesAsync();
            return Ok(pages);
        }

        //POST:    api/Block
        [HttpPost]
        public async Task<ActionResult> Create([FromBody]Pages pages){
            var now = DateTime.Now;
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var languages = await Database.Language.ToListAsync();
            var bLC = new PageLocalController(configuration);

            pages.CreatedDateTime = now;
            pages.LastModifiedDateTime = pages.LastModifiedDateTime ?? now;

            Database.Page.Add(pages);
            await Database.SaveChangesAsync();

            return CreatedAtAction("GetById", new { id = pages.Id }, pages);
        }

        //PUT:    api/Block
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, Pages page)//Fonctionne
        {
            var now = DateTime.Now;
            if (id != page.Id)
            {
                return BadRequest();
            }

            var bLc = new PageLocalController(configuration);
            List<PagesLocal> pageLocals = bLc.GetPageLocals(page.Id);
            Console.WriteLine("Liste des blockLocals ok ");

            foreach (var pageLocal in pageLocals)
            {
                pageLocal.PageId = page.Id;
                pageLocal.IsActive = page.IsProtected;
                pageLocal.MainContent = page.MainContent;
                pageLocal.Title = page.Title;
                pageLocal.PageAdditionalMeta = page.PageAdditionalMeta;
                pageLocal.PageDescription = page.PageDescription;
                pageLocal.PageOGDescription = page.PageOGDescription;
                pageLocal.PageOGTitle = page.PageOGTitle;
                pageLocal.PageTitle = page.PageTitle;
                pageLocal.PageURL = page.PageURL;
                pageLocal.LastModifiedDateTime = now;
                await bLc.Update(pageLocal.Id, pageLocal);
            }
            page.LastModifiedDateTime = page.LastModifiedDateTime ?? now;
            Database.Entry(page).State = EntityState.Modified;
            try
            {
                await Database.SaveChangesAsync();
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
            return Database.Page.Any(x => x.Id == id);
        }
    }
}
