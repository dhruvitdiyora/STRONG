using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.Models;

namespace CharityAPI.IServices
{
    public interface IVolunteer : IGenericInterface<Volunteer>
    {
        public IEnumerable GetByUserId(long id);
        public IEnumerable<Volunteer> GetByOrganisationId(long id);
        public IEnumerable GetByOrganisationName(string name);
        public Volunteer IsVolunteer(long userid, long organisationId);
    }
}
