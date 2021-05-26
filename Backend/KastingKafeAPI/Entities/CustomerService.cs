using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace KastingKafeAPI.Entities{
    [Table("CustomerService", Schema = "dbo")]
    public sealed class CustomerService {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public int ServiceTypeId{get;set;}
        public int CityId { get; set; }
        public string Title { get; set; }
        public string? Description { get; set; }
        public decimal PriceUnit { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
        public string? ManageComment { get; set; }
        public int StatusId { get; set; }
        public Customer customer { get; set; }
        public ServiceType serviceType { get; set; }
        public City city { get; set; }
        //public CustomerServiceStatus serviceStatus { get; set; }
    }
}
