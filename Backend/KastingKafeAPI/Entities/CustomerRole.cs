using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace KastingKafeAPI.Entities{
    [Table("CustomerRole", Schema = "dbo")]
    public sealed class CustomerRole{
        public int Id { get; set; }
        public string SystemName { get; set; }
        public string Title { get; set; }
        public bool CanBeChild { get; set; }
        public DateTime CreatedDateTime { get; set; }
        public DateTime? DeletedDateTime { get; set; }
        public DateTime? LastModifiedDateTime { get; set; }
        public int RoleType { get; set; }
        public int EntityStatus { get; set; }
        public bool IsIncludedInSearch { get; set; }
        public bool SkipBookStep { get; set; }
    }
}