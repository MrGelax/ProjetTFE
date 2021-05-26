using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace KastingKafeAPI.Entities{
    [Table("PortfoliosItems", Schema = "dbo")]
    public sealed class PortfoliosItems{
        public int Id { get; set; }
        public int PortfoliosId { get; set; }
        public string? Description { get; set; }
        public int MediaTypeId { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
        public string MediaValue { get; set; }
        public MediaType mediaType { get; set; }
        //public Portfolios portfolios { get; set; }
    }
}
