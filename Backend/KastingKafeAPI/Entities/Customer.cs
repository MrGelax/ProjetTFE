using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace KastingKafeAPI.Entities
{
    public sealed class Customer
    {
        public int Id { get; set; }

        public string UserId { get; set; }

        public string ProfessionnalName { get; set; }

        public string Email { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public DateTime Birthdate { get; set; }

        public string Avatar { get; set; }

        public string NationalRegistrationNumber { get; set; }

        public string Phone { get; set; }

        public bool IsChild { get; set; }

        public string ParentFirstName { get; set; }

        public string ParentLastName { get; set; }

        public bool? IsBillingAddressSameAsAddress { get; set; }

        public string VAT { get; set; }

        public string IBAN { get; set; }

        public string BIC { get; set; }

        public int? CustomerStatus { get; set; }

        public DateTime CreatedDateTime { get; set; }

        public DateTime? LastmodifiedDateTime { get; set; }

        public int? Rating { get; set; }

        public DateTime? LastProfileModification { get; set; }

        public int ProfileViews { get; set; }

        public string CoverFile { get; set; }

        public string AddressStreet { get; set; }

        public string BillingAddressStreet { get; set; }

        public string AddressNumber { get; set; }

        public string AddressBox { get; set; }

        public string BillingAddressBox { get; set; }

        public string BillingAddressNumber { get; set; }

        public int? OrganizationId { get; set; }

        public int? MainRoleId { get; set; }

        public int? CustomerSubscriptionId { get; set; }

        public int? CustomerEventSetupId { get; set; }

        public AspNetUsers User { get; set; }

        public Organization Organization { get; set; }

        public CustomerRole MainRole { get; set; }

        public CustomerSubscription CustomerSubscription { get; set; }

        public CustomerEventSetup CustomerEventSetup { get; set; }
    }
}
