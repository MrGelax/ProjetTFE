using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities
{
    public sealed class Block
    {
        public int Id { get; set; }

        public string Label { get; set; }

        public string Body { get; set; }

        public string SystemName { get; set; }

        public DateTime CreatedDateTime { get; set; }

        public DateTime? DeletedDateTime { get; set; }

        public DateTime? LastModifiedDateTime { get; set; }

        //public List<BlockLocal> BlockLocals { get; set; }
    }
}
