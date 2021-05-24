using System;
using KastingKafeAPI.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace KastingKafeAPI.DataAccess{
    public sealed class PublicationDBContext : DbContext{
        public DbSet<Publication> Publication { get; set; }
        public DbSet<Customer> Customer { get; set; }
        public DbSet<PublicationStatus> PublicationStatus { get; set; }
        public DbSet<MediaType> Mediatype { get; set; }

        private readonly IConfiguration configuration;

        public PublicationDBContext(IConfiguration configuration){
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
