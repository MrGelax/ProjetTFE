using System;
using System;
using System.ComponentModel.DataAnnotations.Schema;
namespace KastingKafeAPI.Entities{
    [Table("Review", Schema = "dbo")]
    public sealed class Review {
        public int Id { get; set; }
        public string Title { get; set; }
        public int SenderCustomerId { get; set;}
        public int RecipientCustomerId { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
        public int Rating { get; set; }
        public string Comment { get; set; }
        public int ReviewStatusId { get; set; }

        public Customer senderCustomer { get; set; }
        public Customer recipientCustomer { get; set; }
        public ReviewStatus reviewStatus { get; set; }
    }
}
