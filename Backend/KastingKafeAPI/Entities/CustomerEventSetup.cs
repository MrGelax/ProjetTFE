using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities{
    public sealed class CustomerEventSetup{
        public int Id { get; set; }
        public string AlertsEmail { get; set; }
        public string AlertsFrequencyType { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
    }
}
