using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities{
    public class Pages{
        public int Id { get; set; }
        public string Label { get; set; }
        public string Title { get; set; }
        public string MainContent { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
        public DateTime? DeletedDateTime { get; set; }
        public bool IsProtected { get; set; }
        public string SystemName { get; set; }
        public string PageAdditionalMeta { get; set; }
        public string PageDescription { get; set; }
        public string PageTitle { get; set; }
        public string PageURL { get; set; }
        public string PageOGDescription { get; set; }
        public string PageOGImage { get; set; }
        public string PageOGTitle { get; set; }
    }
}
