using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.DTOs
{
    public class Filters
    {
        public string Username { get; set; }
        public long CityId { get; set; }
        public long StateId { get; set; }
        public long PincodeId { get; set; }
        public string Sort { get; set; }
    }
}
