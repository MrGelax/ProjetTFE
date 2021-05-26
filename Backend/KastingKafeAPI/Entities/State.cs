using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities{
    public sealed class State{
        public int Id { get; set; }
        public string Label { get; set; }
        public string Title { get; set; }
        public int CountryId { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
        public Country Country { get; set; }
    }
}
