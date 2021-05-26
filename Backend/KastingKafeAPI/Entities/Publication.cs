using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace KastingKafeAPI.Entities{
    [Table("Publication", Schema = "dbo")]
    public sealed class Publication{
        public int Id { get; set; }
        public string SystemName { get; set; }
        public string Description { get; set; }
        public int CustomerId { get; set; }
        public string PublicationName { get; set; }
        public int MediaTypeId { get; set; }
        public string MediaValue { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
        public DateTime? PublicationDate { get; set; }
        public string ManageComment { get; set; }
        public int StatusId { get; set; }


        public Customer customer { get; set; }
        public MediaType mediatype { get; set; }
        //public PublicationStatus PublicationStatus { get; set; }
    }
}
