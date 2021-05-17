using KastingKafeAPI.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace KastingKafeAPI.DataAccess
{
    public sealed class BlockLocalDBContext : DbContext
    {
        public DbSet<BlockLocal> BlockLocal { get; set; }
        public DbSet<Block> Block { get; set; }
        public DbSet<Language> Language { get; set; }

        private readonly IConfiguration configuration;

        public BlockLocalDBContext(IConfiguration configuration)
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

        }
    }
}
