using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities{
    public sealed class CustomerSubscription{
        public int Id { get; set; }
        public int Quantity { get; set; }
        public int? Credits { get; set; } //computed column
        public int SubscriptionId { get; set; } //FK 
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
    }
}
