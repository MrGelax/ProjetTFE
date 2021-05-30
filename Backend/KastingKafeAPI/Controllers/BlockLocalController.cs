using KastingKafeAPI.DataAccess;
using KastingKafeAPI.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Controllers{

    [ApiController]
    [Route("api/[controller]")]
    public sealed class BlockLocalController : ControllerBase{
        private readonly IConfiguration configuration;

        public BlockLocalController(IConfiguration configuration){
            this.configuration = configuration;
        }

        //GET:    api/BlockLocal
        [HttpGet]
        public async Task<ActionResult> Get(){
            await using var db = new BlockLocalDBContext(configuration);
            var blocks = await db.BlockLocal
                .ToListAsync();
            return Ok(blocks);
        }
        ////GET:    api/BlockLocal
        //[HttpGet]
        //public async Task<BlockLocal> Get(Block block)//Fonctionne
        //{
        //    await using var db = new BlockLocalDBContext(configuration);
        //    List<BlockLocal> res = new List<BlockLocal>();
        //    var blockLocals = db.BlockLocal
        //        .ToListAsync();
        //    foreach (var blockLocal in blockLocals)
        //    {
        //        if (blockLocal.BlockId == block.Id)
        //        {
        //            res.Add(blockLocal);
        //        }
        //    }
        //    return Ok(res);
        //}

        /**
         * 
         */
        [HttpGet("Block/{blockId}")]
        public async Task<ActionResult> GetByBlockId(int blockId){
            await using var db = new BlockLocalDBContext(configuration);
            //var blocks = db.BlockLocal.FromSqlRaw("SELECT * FROM BlockLocal b WHERE b.BlockId={0}", blockId).ToListAsync();
            var blocks = db.BlockLocal.Where(b => b.BlockId == blockId).ToListAsync();
            return Ok(blocks.Result);
        }

        public List<BlockLocal> GetBlockLocals(int blockid) {
            var db = new BlockLocalDBContext(configuration);
            List<BlockLocal> res = new List<BlockLocal>();
            var blcs = db.BlockLocal.ToList();
            foreach (var blockLocal in blcs){
                if (blockLocal.BlockId == blockid) {
                    res.Add(blockLocal);
                    Console.WriteLine("Je suis dans la liste local et je suis dans le local " + blockLocal.LanguageCode);
                }
            }
            return res;
        }

        //GET:    api/BlockLocal/id
        [HttpGet("{id}")]//Fonctionne
        public async Task<ActionResult> GetById(int id){
            await using var db = new BlockLocalDBContext(configuration);
            var blocks = await db.BlockLocal.FindAsync(id);
            if (blocks == null)
                return NotFound();

            return Ok(blocks);

        }

        //DELETE:    api/BlockLocal/id
        [HttpDelete("{id}")]//Fonctionne
        public async Task<ActionResult<BlockLocal>> Delete(int id){
            await using var db = new BlockLocalDBContext(configuration);
            var blocks = await db.BlockLocal.FindAsync(id);
            if (blocks == null)
                return NotFound();

            db.BlockLocal.Remove(blocks);
            await db.SaveChangesAsync();

            return Ok(blocks);
        }

        //POST:    api/BlockLocal
        [HttpPost] //fonctionne
        public async Task<ActionResult> Create([FromBody]BlockLocal blocks){
            var now = DateTime.Now;
            if (!ModelState.IsValid){
                return BadRequest(ModelState);
            }

            await using var db = new BlockLocalDBContext(configuration);

            blocks.CreatedDateTime = now;
            blocks.LastModifiedDateTime = blocks.LastModifiedDateTime ?? now;

            db.BlockLocal.Add(blocks);
            await db.SaveChangesAsync();

            return CreatedAtAction("GetById", new { id = blocks.Id }, blocks);
        }

        //PUT:    api/BlockLocal
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, BlockLocal blocks){
            var now = DateTime.Now;

            if (id != blocks.Id)
                return BadRequest();

            await using var db = new BlockLocalDBContext(configuration);
            blocks.LastModifiedDateTime = blocks.LastModifiedDateTime ?? now;

            db.Entry(blocks).State = EntityState.Modified;

            try{
                await db.SaveChangesAsync();
            }catch (DbUpdateConcurrencyException){
                if (!BlockExists(id))
                    return NotFound();
                else
                    throw;
            }
            return Ok(blocks);
        }

        private bool BlockExists(int id) {
            using var db = new BlockLocalDBContext(configuration);
            return db.BlockLocal.Any(x => x.Id == id);
        }
    }
}
