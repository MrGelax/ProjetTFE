using System;
using System.ComponentModel.DataAnnotations;

namespace KastingKafeAPI.Entities
{
    public sealed class Language
    {
        [Key]
        public string Code { get; set; }

        public DateTime CreatedDateTime { get; set; }

        public DateTime? LastModifiedDateTime { get; set; }
    }
}
