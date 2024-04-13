using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace CharityAPI.Services
{
    public class OrganisationDataServices : GenericRepository<OrganisationData>, IOrganisationData
    {
        public OrganisationDataServices(CharityAPIContext context) : base(context)
        {

        }

        //get all OrganisationData
        public override IEnumerable<OrganisationData> GetAll()
        {
            //var organisationData = context.OrganisationData.FromSqlRaw("exec getAllOrganisationDatas").ToList();
            var organisationData = context.OrganisationData.Include(x => x.OrganisationUser).ToList();

            return organisationData;
        }

        //get orgdata by orgusername
        public Organisations GetOrgInfoByUser(string name)
        {
            var userinfo = context.Organisations.Include(x => x.OrganisationData).SingleOrDefault(x => x.UserName == name);
            return userinfo;
        }

        //get all verified post
        public IEnumerable GetAllVerifiedOrgs()
        {
            //var post = context.Post.FromSqlRaw("exec getallVerifiedPost").ToList();
            var organisationData = context.OrganisationData.Include(x => x.OrganisationUser).Where(x => x.IsVerified == true).ToList();

            return organisationData;
        }

        //get all unverified post
        public IEnumerable GetAllUnVerifiedOrgs()
        {
            //var post = context.Post.FromSqlRaw("exec getallUnVerifiedPost").ToList();
            var organisationData = context.OrganisationData.Include(x => x.OrganisationUser).Where(x => x.IsVerified == false).ToList();

            return organisationData;
        }

        //verify organisation
        public virtual bool VerifyOrg(long id, OrganisationData organisationData)
        {

            var org = context.OrganisationData.Find(id);

            if (org != null)
            {
                org.IsVerified = true;
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }

        }

        //Create ClusterLocation
        public bool Create(OrganisationData organisationData, Image file, string fileName)
        {
            if (file != null)
            {
                var result = context.OrganisationData.Add(organisationData);
                var commonHelper = new CommonHelper();
                context.SaveChanges();
                var imagepath = commonHelper.GetOrganisationPath(organisationData.OrganisationDataId);

                // Create directory Path if not Exit
                commonHelper.CreateDirectory(imagepath);
                var imageFileName = Path.GetFileName(organisationData.OrganisationLogoUrl);

                if (!string.IsNullOrEmpty(imageFileName) && imageFileName.Contains("?t="))
                {
                    imageFileName = imageFileName.Split('?')[0].ToString();
                }
                if (!string.IsNullOrEmpty(imageFileName))
                {
                    // Delete file path if exit
                    commonHelper.DeleteFilePath(imagepath, imageFileName);
                }
                var fileSavePath = Path.Combine(imagepath, fileName);
                file.Save(fileSavePath);

                return true;
            }
            else
            {
                return false;
            }
        }

        //Update ClusterLocation
        public override bool Update(long id, OrganisationData entity)
        {
            var existingOrganisationData = context.OrganisationData.Find(id);

            if (existingOrganisationData != null)
            {
                existingOrganisationData.OrganisationLogoUrl = entity.OrganisationLogoUrl;
                existingOrganisationData.OrganisationUserId = entity.OrganisationUserId;
                existingOrganisationData.OrganisationName = entity.OrganisationName;
                existingOrganisationData.OrganisationAddress = entity.OrganisationAddress;
                existingOrganisationData.OrganisationDetail = entity.OrganisationDetail;
                existingOrganisationData.OrganisatioWebUrl = entity.OrganisatioWebUrl;
                existingOrganisationData.UpdatedBy = entity.UpdatedBy;
                existingOrganisationData.UpdatedAt = DateTime.Now;
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }
        //public bool Update(long id, OrganisationData entity, Image file)
        //{
        //    var existingOrganisationData = context.OrganisationData.Find(id);

        //    if (existingOrganisationData != null)
        //    {
        //        if (file != null)
        //        {
        //            var commonHelper = new CommonHelper();
        //            var imagepath = commonHelper.GetOrganisationPath(id);
        //            existingOrganisationData.OrganisationLogoUrl = entity.OrganisationLogoUrl;

        //            // Create directory Path if not Exit
        //            commonHelper.CreateDirectory(imagepath);
        //            var imageFileName = Path.GetFileName(entity.OrganisationLogoUrl);

        //            if (!string.IsNullOrEmpty(imageFileName) && imageFileName.Contains("?t="))
        //            {
        //                imageFileName = imageFileName.Split('?')[0].ToString();
        //            }
        //            if (!string.IsNullOrEmpty(imageFileName))
        //            {
        //                // Delete file path if exit
        //                commonHelper.DeleteFilePath(imagepath, imageFileName);
        //            }
        //            var fileSavePath = Path.Combine(imagepath, entity.OrganisationLogoUrl);
        //            file.Save(fileSavePath);
        //        }
        //        existingOrganisationData.OrganisationUserId = entity.OrganisationUserId;
        //        existingOrganisationData.OrganisationName = entity.OrganisationName;
        //        existingOrganisationData.OrganisationAddress = entity.OrganisationAddress;
        //        existingOrganisationData.OrganisationDetail = entity.OrganisationDetail;
        //        existingOrganisationData.OrganisatioWebUrl = entity.OrganisatioWebUrl;
        //        existingOrganisationData.UpdatedBy = entity.UpdatedBy;
        //        existingOrganisationData.UpdatedAt = DateTime.Now;
        //        context.SaveChanges();
        //        return true;
        //    }
        //    else
        //    {
        //        return false;
        //    }
        //}

        //Delete ClusterLocation
        public override bool Delete(long id)
        {
            var existingOrganisationData = context.OrganisationData.Find(id);

            if (existingOrganisationData != null)
            {
                var existingChEvOrganiser = context.CharityEventOrganiser.Where(x => x.EventOrganiserId == id).ToList();
                if (existingChEvOrganiser != null)
                {
                    foreach (var organiser in existingChEvOrganiser)
                        context.CharityEventOrganiser.Remove(organiser);
                }
                var existingVolunteer = context.Volunteer.Where(x => x.OrganisationId == id).ToList();
                if (existingVolunteer != null)
                {
                    foreach (var volunteer in existingVolunteer)
                        context.Volunteer.Remove(volunteer);
                }

                context.OrganisationData.Remove(existingOrganisationData);
                var orgs = context.Organisations.Find(existingOrganisationData.OrganisationUserId);
                if (orgs != null)
                {
                    context.Organisations.Remove(orgs);
                }
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }

        //Get OrganisationData by OrganisationName
        public OrganisationData GetByOrganisationName(string name)
        {
            var organisationData = context.OrganisationData.SingleOrDefault(x => x.OrganisationName == name && x.IsPublished == true);
            return organisationData;
        }

        //Get OrganisationData by OrganisationUserId
        public OrganisationData GetByUserId(long id)
        {
            var organisationData = context.OrganisationData.SingleOrDefault(x => x.OrganisationUserId == id && x.IsPublished == true);
            return organisationData;
        }
        public OrganisationData GetByUserName(string username)
        {
            var organisationData = context.OrganisationData.SingleOrDefault(x => x.OrganisationUserName == username && x.IsPublished == true);
            return organisationData;
        }

        //Get OrganisationData by OrganisationContactNo
        public OrganisationData GetByContactNo(string contact)
        {
            var organisationData = context.OrganisationData.SingleOrDefault(x => x.OrganisationContactNo == contact && x.IsPublished == true);
            return organisationData;
        }

        //public IEnumerable GetByCity(long id)
        //{
        //    var organisationData = context.OrganisationData.Include(x => x.UserData).ThenInclude(xy => xy.OrganisationData)
        //    return organisationData;
        //}
    }
}
