using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace KastingKafeAPI.Entities{
    [Table("CustomerServiceStatus", Schema = "dbo")]
    public sealed class CustomerServiceStatus
    {
        public int Id { get; set; }
        public string SystemName { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
    }
}
