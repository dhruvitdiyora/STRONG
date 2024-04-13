using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.DTOs
{
    public class PostDTO
    {

        public long PostId { get; set; }
        public long UserId { get; set; }
        public string UserName { get; set; }
        public string PostDescription { get; set; }
       public string ProfileImage { get; set; }
        public long RequirementTypeId { get; set; }
        public string LocationName { get; set; }
        public decimal Longitude { get; set; }
        public decimal Latitude { get; set; }
        public long HelpRequiredCount { get; set; }
        public long CityId { get; set; }
        public long StateId { get; set; }
        public string ImageUrl { get; set; }
        public DateTime CreatedAt { get; set; }
        public long PincodeId { get; set; }
        public long UrgencyCount { get; set; }
        public long SpamCount { get; set; }
        public long CommentsCount { get; set; }
        public bool? IsSpam { get; set; }
        public bool? IsUrgency { get; set; }
        public bool? IsBookmark { get; set; }
    }
}
