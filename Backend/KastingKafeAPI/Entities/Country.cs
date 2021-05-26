using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities{
    public sealed class Country{
        public int Id { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
        public int CurrencyId { get; set; }
        public string Label { get; set; }

        public Currency Currency { get; set; }
    }
}
