using System;
using System.Collections.Generic;
using System.Linq;
using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace KastingKafeAPI.Entities{
    [Table("ReviewStatus", Schema = "dbo")]
    public sealed class ReviewStatus{
        public int Id { get; set; }
        public string SystemName { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModdifiedDateTime { get; set; }
    }
}
