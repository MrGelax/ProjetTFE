using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities{
    public sealed class Currency{
        public int Id { get; set; }
        public string SystemName { get; set; }
        public string Code { get; set; }
        public string Symbol { get; set; }
        public int CodeSIPS { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
    }
}
