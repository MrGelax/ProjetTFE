using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities{
    public class PagesLocal{
        public int Id { get; set; }
        public int PageId { get; set; }
        public string LanguageCode { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
        public string Title { get; set; }
        public string MainContent { get; set; }
        public bool IsActive { get; set; }
        public string PageURL { get; set; }
        public string PageTitle { get; set; }
        public string PageDescription { get; set; }
        public string PageAdditionalMeta { get; set; }
        public string PageOGDescription { get; set; }
        public string PageOGImage { get; set; }
        public string PageOGTitle { get; set; }
    }
}
