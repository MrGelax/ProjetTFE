using System;
using KastingKafeAPI.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace KastingKafeAPI.DataAccess{
    public sealed class EventDbContext: DbContext{
        public DbSet<Event> Event { get; set; }
        public DbSet<Customer> Customer { get; set; }
        public DbSet<EventStatus> EventStatus { get; set; }

        private readonly IConfiguration configuration;

        public EventDbContext(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(configuration["SqlServerConnectionString"]);
        }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
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
