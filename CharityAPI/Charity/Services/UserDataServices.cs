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
    public class UserDataServices : GenericRepository<UserData>, IUserData
    {
        public UserDataServices(CharityAPIContext context) : base(context)
        {

        }

       
        //get user detail from user 
        public Users GetUserInfoByUser(string name)
        {
            var userinfo=context.Users.Include(x=>x.UserData).SingleOrDefault(x => x.UserName == name);
            return userinfo;
        }

        public UserData GetDetailsByUserName(string name)
        {
            var ud = context.UserData.SingleOrDefault(x => x.UserName == name);
            return ud;
        }
        //get all UserData
        public override IEnumerable<UserData> GetAll()
        {
            //var userData = context.UserData.FromSqlRaw("exec getAllUserData").ToList();
            var userData = context.UserData.Include(x => x.Pincode).Where(x => x.IsPublished == true).ToList();

            return userData;
        }
        public UserData GetByUserId(long id)
        {
            var ud = context.UserData.Include(x => x.Post).Include(x=>x.City).Include(x => x.Urgency).Include(x => x.Spam).
                Include(x => x.PostComments).Include(x => x.PostImages).Include(x => x.State).SingleOrDefault(x => x.UserId == id && x.IsPublished == true);
            return ud;
        }

        //Create UserData
        public bool Create(UserData userData, Image file, string fileName)
        {
            if (file != null)
            {
                var p = context.UserData.Add(userData);
                var commonHelper = new CommonHelper();
                context.SaveChanges();
                var imagepath = commonHelper.GetUserPath(userData.UserId);

                // Create directory Path if not Exit
                commonHelper.CreateDirectory(imagepath);
                var imageFileName = Path.GetFileName(userData.ProfileImage);

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

        //Update UserData
        public override bool Update(long id, UserData entity)
        {
            var existingUserData = context.UserData.Find(id);

            if (existingUserData != null)
            {
                existingUserData.ProfileImage = entity.ProfileImage;
                existingUserData.FirstName = entity.FirstName;
                existingUserData.LastName = entity.LastName;
                existingUserData.Gender = entity.Gender;
                existingUserData.UserDescription = entity.UserDescription;           
                existingUserData.TotalPostCount = entity.TotalPostCount;
                existingUserData.UpdatedBy = entity.UpdatedBy;
                existingUserData.UpdatedAt = DateTime.Now;
                existingUserData.CityId = entity.CityId;
                existingUserData.StateId = entity.StateId;
                existingUserData.PincodeId = entity.PincodeId;
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }

        //Delete UserData
        public override bool Delete(long id)
        {
            var existingUserData = context.UserData.Find(id);

            if (existingUserData != null)
            {
                
                var existingChEvLike = context.CharityEventPostLike.Where(x => x.UserId == id).ToList();
                if (existingChEvLike != null)
                {
                    foreach (var like in existingChEvLike)
                        context.CharityEventPostLike.Remove(like);
                }
                var existingChEvInteract = context.CharityEventInteract.Where(x => x.UserId == id).ToList();
                if (existingChEvInteract != null)
                {
                    foreach (var interact in existingChEvInteract)
                        context.CharityEventInteract.Remove(interact);
                }
                var existingVolunteer = context.Volunteer.Where(x => x.VolunteerUserId == id).ToList();
                if (existingVolunteer != null)
                {
                    foreach (var vol in existingVolunteer)
                        context.Volunteer.Remove(vol);
                }
                var existingChEvPost = context.CharityEventPost.Where(x => x.UserId == id).ToList();
                if (existingChEvPost != null)
                {
                    foreach (var post in existingChEvPost)
                        context.CharityEventPost.Remove(post);
                }

                context.UserData.Remove(existingUserData);

                var users = context.Users.Find(existingUserData.Users);
                if(users != null)
                {
                    context.Users.Remove(users);
                }
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }

        //Get UserData by CityId
        public IEnumerable GetByCityId(long id)
        {
            var userData = context.UserData.Where(x => x.CityId == id && x.IsPublished == true).ToList();
            return userData;
        }

        //Get UserDat by CityName
        public IEnumerable GetByCityName(string name)
        {
            var userData = context.UserData.Include(x => x.City).Where(x => x.City.CityName == name && x.IsPublished == true).ToList();
            return userData;
        }

        //Get UserData by Pincode
        public IEnumerable GetByPincode(long pincode)
        {
            var userData = context.UserData.Include(x => x.Pincode).Where(x => x.Pincode.Pincode1 == pincode && x.IsPublished == true).ToList();
            return userData;
        }

        //Get UserData by StateId
        public IEnumerable GetByStateId(long id)
        {
            var userData = context.UserData.Where(x => x.StateId == id && x.IsPublished == true).ToList();
            return userData;
        }

        //Get UserData by UserName
        public UserData GetByUserName(string name)
        {
            var userData = context.UserData.SingleOrDefault(x => x.UserName == name && x.IsPublished == true);
            return userData;
        }

        //Get UserData by UsersId
        public UserData GetByUsersId(long id)
        {
            var userData = context.UserData.SingleOrDefault(x => x.Users == id && x.IsPublished == true);
            return userData;
        }

        //Get UserData by EmailId
        public UserData GetByEmailId(string email)
        {
            var userData = context.UserData.SingleOrDefault(x => x.EmailAddress == email && x.IsPublished == true);
            return userData;
        }

        //Get UserData by ContactNo
        public UserData GetByContactNo(string mob)
        {
            var userData = context.UserData.SingleOrDefault(x => x.MobileNo == mob && x.IsPublished == true);
            return userData;
        }
    }
}
