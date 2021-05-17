using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities
{
    public sealed class BlockLocal
    {
        public int Id { get; set; }
        public string Body { get; set; }
        public int BlockId { get; set; }
        public string LanguageCode { get; set; }
        public DateTime? CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
    }
}
