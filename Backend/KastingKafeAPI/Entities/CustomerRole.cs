using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities{
    public sealed class CustomerRole{
        public int Id { get; set; }
        public string SystemName { get; set; }
        public bool CanBeChild { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? DeletedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
    }
}
