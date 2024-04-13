using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.Models;

namespace CharityAPI.IServices
{
    public interface IOrganisationData : IGenericInterface<OrganisationData>
    {
        public bool Create(OrganisationData user, Image file, string fileName);
        //public bool Update(long id, OrganisationData user, Image file);
        public Organisations GetOrgInfoByUser(string name);
        public IEnumerable GetAllVerifiedOrgs();
        public IEnumerable GetAllUnVerifiedOrgs();
        public bool VerifyOrg(long id, OrganisationData organisationData);
        public OrganisationData GetByUserId(long id);
        public OrganisationData GetByUserName(string username);
        public OrganisationData GetByOrganisationName(string name);
        public OrganisationData GetByContactNo(string contact);
        //public IEnumerable GetByCity(long id);
    }
}
