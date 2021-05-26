using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities{
    public sealed class ServiceType{
        public int Id { get; set; }
        public string SystemName { get; set; } //Title
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
    }
}
