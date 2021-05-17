using KastingKafeAPI.DataAccess;
using KastingKafeAPI.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
namespace KastingKafeAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BlockController : BaseBlockController //ControllerBase 
    {

        private readonly IConfiguration configuration;
        public BlockController(IConfiguration configuration) :
            base(configuration)
        {
            this.configuration = configuration;

        }

        //GET:    api/Block
        [HttpGet]
        public async Task<ActionResult> Get(int? page, int? pageSize)//Fonctionne
        {
            if (page == null && pageSize == null)
            {
                return Ok(new { TotalCount = Database.Block.Count(), Blocks = Database.Block.ToList() });
            }

            var blocks = Database.Block.Skip(((page - 1) * pageSize).Value).Take(pageSize.Value).ToList();

            return Ok(new { TotalCount = Database.Block.Count(), Blocks = blocks });
        }


        //GET:    api/Block/id
        [HttpGet("{id}")]//Fonctionne
        public async Task<ActionResult> GetById(int id)
        {
            var blocks = await Database.Block.FindAsync(id);

            if (blocks == null)
            {
                return NotFound();
            }

            return Ok(blocks);

        }

        //DELETE:    api/Block/id
        [HttpDelete("{id}")] //Fonctionne
        public async Task<ActionResult<Block>> Delete(int id)
        {
            var blocks = await Database.Block.FindAsync(id);
            var bLC = new BlockLocalController(configuration);

            List<BlockLocal> blockLocals = bLC.GetBlockLocals(blocks.Id);
            if (blocks == null)
            {
                return NotFound();
            }
            foreach (var blockLocal in blockLocals)
            {
                await bLC.Delete(blockLocal.Id);
            }
            Database.Block.Remove(blocks);
            await Database.SaveChangesAsync();
            return Ok(blocks);
        }

        //POST:    api/Block
        [HttpPost]//Fonctionne
        public async Task<ActionResult> Create([FromBody]Block blocks)
        {
            var now = DateTime.Now;
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var languages = await Database.Language.ToListAsync();
            var bLC = new BlockLocalController(configuration);

            blocks.CreatedDateTime = now;
            blocks.LastModifiedDateTime = blocks.LastModifiedDateTime ?? now;

            Database.Block.Add(blocks);
            await Database.SaveChangesAsync();
            
            return CreatedAtAction("GetById", new { id = blocks.Id }, blocks);
        }
        

        //PUT:    api/Block
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, Block blocks)//Fonctionne
        {

            var now = DateTime.Now;

            if (id != blocks.Id)
            {
                return BadRequest();
            }

            var bLc = new BlockLocalController(configuration);
            List<BlockLocal> blockLocals = bLc.GetBlockLocals(blocks.Id);
            Console.WriteLine("Liste des blockLocals ok ");

            foreach (var blockLocal in blockLocals)
            {
                blockLocal.Body = blocks.Body;

                await bLc.Update(blockLocal.Id, blockLocal);
            }

            blocks.LastModifiedDateTime = blocks.LastModifiedDateTime ?? now;
            Database.Entry(blocks).State = EntityState.Modified;

            try
            {
                await Database.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BlockExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            return Ok(blocks);
        }
        private bool BlockExists(int id)
        {
            using var db = new BlockDbContext(configuration);
            return db.Block.Any(x => x.Id == id);
        }
    }
}
