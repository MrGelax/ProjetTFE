using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace KastingKafeAPI.Entities{
    [Table("CustomerEvent", Schema = "dbo")]
    public sealed class Event {
        public int Id { get; set; }
        public string SystemName { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
        public int CustomerId { get; set; }
        public Customer customer { get; set; }

        public int? EventStatusId { get; set; }

        public EventStatus eventStatus { get; set; }
    }
}
