using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using KastingKafeAPI.Entities;

namespace KastingKafeAPI.DataAccess{
    public class PagesLocalDbContext:DbContext{
        public DbSet<PagesLocal> PageLocal { get; set; }
        public DbSet<Pages> Page { get; set; }
        public DbSet<Language> Language { get; set; }

        private readonly IConfiguration configuration;

        public PagesLocalDbContext(IConfiguration configuration){
            this.configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
            optionsBuilder.UseSqlServer(configuration["SqlServerConnectionString"]);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder){
            modelBuilder.Entity<Pages>()
                .HasKey(x => x.Id);
        }
    }
}
