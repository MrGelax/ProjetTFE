using KastingKafeAPI.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace KastingKafeAPI.DataAccess{
    public sealed class CustomersDbContext : DbContext{
        public DbSet<Customer> Customer { get; set; }
        public DbSet<Organization> Organization { get; set; }
        public DbSet<AspNetUsers> AspNetUsers { get; set; }
        public DbSet<CustomerEventSetup> CustomerEventSetup { get; set; }
        public DbSet<CustomerSubscription> CustomerSubscription { get; set; }
        private readonly IConfiguration configuration;

        public CustomersDbContext(IConfiguration configuration) {
            this.configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
            optionsBuilder.UseSqlServer(configuration["SqlServerConnectionString"]);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder){
            modelBuilder.Entity<AspNetUsers>()
            .HasKey(x => x.Id);

            modelBuilder.Entity<Customer>()
                .Property(x => x.Email)
                .HasComputedColumnSql("[dbo].[GetEmail]([UserId])");

            modelBuilder.Entity<Customer>()
                    .Property(x => x.CreatedDateTime)
                    .HasDefaultValueSql("(getdate())");

            modelBuilder.Entity<Customer>()
                    .Property(x => x.LastmodifiedDateTime)
                    .HasDefaultValueSql("(getdate())");
        }
    }
}
