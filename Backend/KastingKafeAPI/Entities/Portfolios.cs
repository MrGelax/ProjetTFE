using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace KastingKafeAPI.Entities{
    [Table("Portfolios", Schema = "dbo")]
    public sealed class Portfolios {
        public int Id { get; set; }
        public string Title { get; set; }
        public string? Description { get; set; }
        public int CustomerId { get; set; }
        public int StatusId { get; set; }
        public int? OrderId { get; set; }
        public string? ManageComment { get; set; }

        public Customer customer { get; set; }
        //public PortfoliosStatus portfoliosStatus { get; set; }
        public List<PortfoliosItems> portfoliosItems{get;set;}
    }
}
