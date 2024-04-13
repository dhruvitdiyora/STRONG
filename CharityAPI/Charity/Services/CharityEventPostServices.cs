using CharityAPI.IServices;
using CharityAPI.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.Services
{
    public class CharityEventPostServices : GenericRepository<CharityEventPost>, ICharityEventPost 
    {
        public CharityEventPostServices(CharityAPIContext context) : base(context)
        {

        }

        //Get All EventPosts
        public override IEnumerable<CharityEventPost> GetAll()
        {
            //var cities = context.Cities.FromSqlRaw("exec getAllcities").ToList();
            var eventPosts = context.CharityEventPost.Include(x => x.User).Include(x => x.Event).ThenInclude(x => x.EventOrganiser).Where(x => x.IsPublished == true).ToList();

            return eventPosts;
        }

        // Create Charity Event Post
        //public bool Create(CharityEventPost post)
        //{
        //    if (file != null)
        //    {
        //        var p = context.CharityEventPost.Add(post);
        //        var commonHelper = new CommonHelper();
        //        context.SaveChanges();


        //        var imagepath = commonHelper.GetEventPostPath(post.CharityEventPostId);

        //        // Create directory Path if not Exit
        //        commonHelper.CreateDirectory(imagepath);
        //        var imageFileName = Path.GetFileName(post.PostUrl);

        //        if (!string.IsNullOrEmpty(imageFileName) && imageFileName.Contains("?t="))
        //        {
        //            imageFileName = imageFileName.Split('?')[0].ToString();
        //        }
        //        if (!string.IsNullOrEmpty(imageFileName))
        //        {
        //            // Delete file path if exit
        //            commonHelper.DeleteFilePath(imagepath, imageFileName);
        //        }
        //        post.PostUrl = fileName;
        //        var fileSavePath = Path.Combine(imagepath, fileName);
        //        file.Save(fileSavePath);

        //        return true;
        //    }
        //    else
        //    {
        //        return false;
        //    }
        //}

        // Update Charity Event Post
        public override bool Update(long id, CharityEventPost entity)
        {
            var existingChEvPost = context.CharityEventPost.Find(id);

            if (existingChEvPost != null)
            {
                existingChEvPost.PostUrl = entity.PostUrl;
                existingChEvPost.Content = entity.Content;
                existingChEvPost.UpdatedBy = entity.UpdatedBy;
                existingChEvPost.UpdatedAt = DateTime.Now;
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }

        //public bool Update(long id, CharityEventPost entity, Image file)
        //{
        //    var existingChEvPost = context.CharityEventPost.Find(id);

        //    if(existingChEvPost != null)
        //    {
        //        if (file != null)
        //        {
        //            var commonHelper = new CommonHelper();
        //            var imagepath = commonHelper.GetEventPostPath(id);
        //            commonHelper.CreateDirectory(imagepath);
        //            existingChEvPost.PostUrl = entity.PostUrl;
        //            var imageFileName = Path.GetFileName(entity.PostUrl);
        //            if (!string.IsNullOrEmpty(imageFileName) && imageFileName.Contains("?t="))
        //            {
        //                imageFileName = imageFileName.Split('?')[0].ToString();
        //            }
        //            if (!string.IsNullOrEmpty(imageFileName))
        //            {
        //                // Delete file path if exit
        //                commonHelper.DeleteFilePath(imagepath, imageFileName);
        //            }

        //            //entity.EventBannerUrl = fileName;
        //            var fileSavePath = Path.Combine(imagepath, entity.PostUrl);
        //            file.Save(fileSavePath);
        //        }
        //        existingChEvPost.Content = entity.Content;
        //        existingChEvPost.UpdatedBy = entity.UpdatedBy;
        //        existingChEvPost.UpdatedAt = DateTime.Now;
        //        context.SaveChanges();
        //        return true;
        //    }
        //    else
        //    {
        //        return false;
        //    }
        //}

        // Delete Charity Event Post ::?
        public override bool Delete(long id)
        {
            var existingChEVPost = context.CharityEventPost.Find(id);

            if(existingChEVPost != null)
            {
                var existingChEvLike = context.CharityEventPostLike.Where(x => x.CharityEventPostId == id).ToList();
                if (existingChEvLike != null)
                {
                    foreach (var like in existingChEvLike)
                        context.CharityEventPostLike.Remove(like);
                }

                context.CharityEventPost.Remove(existingChEVPost);
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }

        // Get Post by Charity Event PostId
        public override CharityEventPost GetById(long id)
        {
            var post = context.CharityEventPost.SingleOrDefault(x => x.CharityEventPostId == id && x.IsPublished == true);
            return post;
        }

        //Get Charity Event Post by UserName
        public IEnumerable GetChEvPostByUserName(string name)
        {

            var post = context.CharityEventPost.Include(x => x.User).Where(x => x.User.UserName == name && x.IsPublished == true).ToList();
            return post;
        }

        // Get Charity Event Post by UserId
        public IEnumerable GetChEvPostByUserId(long id)
        {
            var post = context.CharityEventPost.Where(x => x.UserId == id && x.IsPublished == true).ToList();
            return post;
        }

        // Get Post by TimeRange
        public IEnumerable GetChEvPostByDate(DateTime date)
        {
            var post = context.CharityEventPost.Where(x => x.CreatedAt <= date.Date && x.IsPublished == true).ToList();
            return post;
        }

        // Get Charity Event Post by Charity EventId
        public IEnumerable GetChEvPostByEventId(long id)
        {
            var post = context.CharityEventPost.Where(x => x.EventId == id && x.IsPublished == true).Include(x => x.User).ToList();
            return post;
        }

        // Get Charity Event Post By Event Name
        public IEnumerable GetChEvPostByEventName(string name)
        {
            var post = context.CharityEventPost.Include(x => x.Event).Where(x => x.Event.EventName == name && x.IsPublished == true);
            return post;
        }
    }
}
