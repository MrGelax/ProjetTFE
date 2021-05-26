using System;
using KastingKafeAPI.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace KastingKafeAPI.DataAccess{
    public sealed class CustomerServiceDbContext : DbContext{
        public DbSet<CustomerService> CustomerService { get; set; }
        public DbSet<Customer> Customer { get; set; }
        //public DbSet<CustomerServiceStatus> CustomerServiceStatus { get; set; }
        public DbSet<State> State { get; set; }
        public DbSet<Country> Country { get; set; }
        public DbSet<Currency> Currency { get; set; }
        public DbSet<City> City { get; set; }

        private readonly IConfiguration configuration;

        public CustomerServiceDbContext(IConfiguration configuration){
            this.configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
            optionsBuilder.UseSqlServer(configuration["SqlServerConnectionString"]);

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder){
            modelBuilder.Entity<CustomerService>()
                .HasKey(x => x.Id);

        }
    }
}
