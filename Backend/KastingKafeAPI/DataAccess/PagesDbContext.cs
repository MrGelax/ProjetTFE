using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Mvc;
using KastingKafeAPI.Entities;

namespace KastingKafeAPI.DataAccess{
    public class PagesDbContext:DbContext{
        public DbSet<Pages> Page { get; set; }
        public DbSet<PagesLocal> PageLocal { get; set; }
        public DbSet<Language> Language { get; set; }

        private readonly IConfiguration configuration;

        public PagesDbContext(IConfiguration configuration){
            this.configuration = configuration;
        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
            optionsBuilder.UseSqlServer(configuration["SqlServerConnectionString"]);
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder){
            modelBuilder.Entity<Pages>()
                .HasKey(x => x.Id);
            modelBuilder.Entity<Language>()
               .HasKey(x => x.Code);
        }
    }
    public abstract class BasePageController : ControllerBase{
        private readonly IConfiguration _configuration;
        protected PagesDbContext Database { get; set; }
        public BasePageController(IConfiguration configuration){
            _configuration = configuration;
            Database = new PagesDbContext(configuration);
        }
    }
}
