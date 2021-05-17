using KastingKafeAPI.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace KastingKafeAPI.DataAccess
{
    public sealed class BlockDbContext : DbContext
    {
        public DbSet<Block> Block { get; set; }
        public DbSet<BlockLocal> BlockLocal { get; set; }
        public DbSet<Language> Language { get; set; }

        private readonly IConfiguration configuration;

        public BlockDbContext(IConfiguration configuration)
        {
            this.configuration = configuration;
        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(configuration["SqlServerConnectionString"]);
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Block>()
                .HasKey(x => x.Id);
            modelBuilder.Entity<Language>()
               .HasKey(x => x.Code);

        }
    }
    public abstract class BaseBlockController : ControllerBase
    {

        private readonly IConfiguration _configuration;
        protected BlockDbContext Database { get; set; }
        public BaseBlockController(IConfiguration configuration)
        {
            _configuration = configuration;
            Database = new BlockDbContext(configuration);
        }

    }
}
