using System;
using KastingKafeAPI.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace KastingKafeAPI.DataAccess{
    public sealed class PortfoliosDbContext : DbContext
    {
        public DbSet<Portfolios> Portfolios { get; set; }
        public DbSet<Customer> Customer { get; set; }
        public DbSet<PortfoliosStatus> PortfoliosStatus { get; set; }
        public DbSet<PortfoliosItems> PortfoliosItems { get; set; }
        public DbSet<MediaType> Mediatype { get; set; }

        private readonly IConfiguration configuration;

        public PortfoliosDbContext(IConfiguration configuration){
            this.configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
            optionsBuilder.UseSqlServer(configuration["SqlServerConnectionString"]);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder){
            modelBuilder.Entity<Portfolios>()
                .HasKey(x => x.Id);
        }
    }
}
