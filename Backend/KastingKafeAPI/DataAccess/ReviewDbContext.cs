using System;
using KastingKafeAPI.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace KastingKafeAPI.DataAccess{
    public sealed class ReviewDbContext : DbContext{
        public DbSet<Review> Review { get; set; }
        public DbSet<Customer> Customer { get; set; }
        public DbSet<ReviewStatus> ReviewStatus { get; set; }

        private readonly IConfiguration configuration;

        public ReviewDbContext(IConfiguration configuration){
            this.configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
            optionsBuilder.UseSqlServer(configuration["SqlServerConnectionString"]);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder){
            modelBuilder.Entity<Event>()
                .HasKey(x => x.Id);

            modelBuilder.Entity<Event>()
                    .Property(x => x.CreatedDateTime)
                    .HasDefaultValueSql("(getdate())");

            modelBuilder.Entity<Event>()
                    .Property(x => x.LastModifiedDateTime)
                    .HasDefaultValueSql("(getdate())");

        }
    }
}
