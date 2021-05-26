using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace KastingKafeAPI.Entities{
    [Table("PortfoliosStatus", Schema = "dbo")]
    public sealed class PortfoliosStatus{
        public int Id { get; set; }
        public string SystemName { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
    }
}
