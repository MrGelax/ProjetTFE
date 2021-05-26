using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;
using NetTopologySuite.Geometries;
namespace KastingKafeAPI.Entities{
    public sealed class City{
        public int Id { get; set; }
        public string Label { get; set; }
        public string Title { get; set; }
        public string Zip { get; set; }
        [NotMapped]
        public Geometry Geography { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
        public long GeoPostCodeId { get; set; }
        public int StateId { get; set; }
        public int CountryId { get; set; }
        public State State { get; set; }
        public Country Country { get; set; }

    }
}
