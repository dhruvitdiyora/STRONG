using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc.NewtonsoftJson;
using System.Drawing;
using System.IO;
using CharityAPI.DTOs;
using Microsoft.Data.SqlClient;

namespace CharityAPI.Services
{
    public class PostServices : GenericRepository<Post>, IPost
    {
        public PostServices(CharityAPIContext context) : base(context)
        {

        }

        //Create Post
        public long Create(Post post)
        {
            var p = context.Post.Add(post);
            var commonHelper = new CommonHelper();
            context.SaveChanges();
            return post.PostId;
            //if (file != null)
            //{
            //    var p = context.Post.Add(post);
            //    var commonHelper = new CommonHelper();
            //    context.SaveChanges();
            //    //var pi = new PostImages();
            //    //if()
            //    //pi.PostId = post.PostId;
            //    //pi.CreatedBy = post.UpdatedBy;
            //    //pi.UpdatedBy = post.UpdatedBy;
            //    //pi.CreatedAt = DateTime.Now;
            //    //pi.UpdatedAt = DateTime.Now;
            //    //_postimage.Create(pi);


            //    var imagepath = commonHelper.GetPostPath(post.UserId, post.PostId);

            //    // Create directory Path if not Exit
            //    commonHelper.CreateDirectory(imagepath);
            //    var imageFileName = Path.GetFileName(post.ImageUrl);

            //    if (!string.IsNullOrEmpty(imageFileName) && imageFileName.Contains("?t="))
            //    {
            //        imageFileName = imageFileName.Split('?')[0].ToString();
            //    }
            //    if (!string.IsNullOrEmpty(imageFileName))
            //    {
            //        // Delete file path if exit
            //        commonHelper.DeleteFilePath(imagepath, imageFileName);
            //    }
            //    post.ImageUrl = fileName;
            //    var fileSavePath = Path.Combine(imagepath, fileName);
            //    file.Save(fileSavePath);

            //    return post.PostId;
            //}
            //else
            //{
            //    return 0;
            //}
        }
        public bool saveImage(Image file,string path)
        {
            try
            {
                //var fileSavePath = Path.Combine(imagepath, fileName);
                file.Save(path);
                return true;
            }
            catch
            {
                return false;
            }
            
        }

        //verify post
        public virtual bool VerifyPost(long id, Post post)
        {
           
            var post1= context.Post.Find(id);

            if(post1!=null)
            {
                post1.IsPublished = true;
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }

        }

        public IEnumerable GetPostsforUser(long pincodeId,long cityId,long stateId,long userId,string sort)
        {
            try
            {
                var parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("@Pincode", pincodeId));
                parameters.Add(new SqlParameter("@CityId", cityId));
                parameters.Add(new SqlParameter("@StateId", stateId));
                parameters.Add(new SqlParameter("@UserId", userId));
                parameters.Add(new SqlParameter("@Sort", sort));
                //var posts = context.
                var likes = context.PostDTOs.FromSqlRaw("exec sp_getPostUser @Pincode,@CityId,@StateId,@UserId,@Sort", parameters: parameters.ToArray());

                return likes;
            }
            catch
            {
                return null;
            }
            
        }
        public IEnumerable GetPostsforFilter(long pincodeId, long cityId, long stateId, long userId,long reqType, string username)
        {
            var userss = DBNull.Value;
            try
            {
                var parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("@Pincode", pincodeId));
                parameters.Add(new SqlParameter("@CityId", cityId));
                parameters.Add(new SqlParameter("@StateId", stateId));
                parameters.Add(new SqlParameter("@ReqType", reqType));
                //if (username == "")
                //{
                //    var sq = new SqlParameter("@UserName", DBNull.Value);
                //    sq.IsNullable = true;
                //    parameters.Add(sq);
                //}
                    
                //else
                parameters.Add(new SqlParameter("@UserName", username));
                parameters.Add(new SqlParameter("@UserId", userId));
                //var posts = context.
                var likes = context.PostDTOs.FromSqlRaw("exec sp_getPostsFilt @Pincode,@CityId,@StateId,@ReqType,@UserName,@UserId", parameters: parameters.ToArray());

                return likes;
            }
            catch(Exception e)
            {

                return null;
            }

        }
        public IEnumerable GetPostsforHome(long pincodeId, long cityId, long stateId, long userId, long reqType, string username, string sort, long page, long total)
        {
            try
            {
                var parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("@Pincode", pincodeId));
                parameters.Add(new SqlParameter("@CityId", cityId));
                parameters.Add(new SqlParameter("@StateId", stateId));
                parameters.Add(new SqlParameter("@ReqType", reqType));
                parameters.Add(new SqlParameter("@UserName", username));
                parameters.Add(new SqlParameter("@UserId", userId));
                parameters.Add(new SqlParameter("@Sort", sort));
                parameters.Add(new SqlParameter("@Page", page));
                parameters.Add(new SqlParameter("@TotalRecord", total));
                //var posts = context.
                var likes = context.PostDTOs.FromSqlRaw("exec sp_getHome @Pincode,@CityId,@StateId,@ReqType,@UserName,@UserId,@Sort,@Page,@TotalRecord", parameters: parameters.ToArray());

                return likes;
            }
            catch (Exception e)
            {

                return null;
            }
        }
        public IEnumerable GetPosts(string sort)
        {
            try
            {
                var param = new SqlParameter("@Sort", sort);
                var likes = context.PostDTOs.FromSqlRaw("exec sp_getPosts {0}",param);

                return likes;
            }
            catch
            {
                return null;
            }
            
        }


        // Update Post
        public  override bool Update(long id, Post entity)
        {
            var existingPost = context.Post.Find(id);
            if(existingPost!= null)
            {
                existingPost.LocationName = entity.LocationName;
                existingPost.PincodeId = entity.PincodeId;
                existingPost.ImageUrl = entity.ImageUrl;
                existingPost.PostDescription = entity.PostDescription;
                existingPost.RequirementTypeId = entity.RequirementTypeId;
                existingPost.Latitude = entity.Latitude;
                existingPost.Longitude = entity.Longitude;
                existingPost.HelpRequiredCount = entity.HelpRequiredCount;
                existingPost.UpdatedBy = entity.UpdatedBy;
                existingPost.UpdatedAt = DateTime.Now;
                existingPost.CloseAt = DateTime.Now;
                context.SaveChanges();
                return true;
            }
            return false;
        }
        //public bool Update(long id, Post entity, Image file)
        //{           
        //    var existingPost = context.Post.Find(id);

        //    if(existingPost!= null)
        //    {
        //        if (file != null)
        //        {
        //            var commonHelper = new CommonHelper();
        //            var imagepath = commonHelper.GetPostPath(existingPost.UserId, id);
        //            existingPost.ImageUrl = entity.ImageUrl;
        //            commonHelper.CreateDirectory(imagepath);
        //            var imageFileName = Path.GetFileName(existingPost.ImageUrl);
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
        //            var fileSavePath = Path.Combine(imagepath, entity.ImageUrl);
        //            file.Save(fileSavePath);
        //        }
        //        existingPost.LocationName = entity.LocationName;
        //        existingPost.PincodeId = entity.PincodeId;
        //        existingPost.PostDescription = entity.PostDescription;
        //        existingPost.RequirementTypeId = entity.RequirementTypeId;
        //        existingPost.Latitude = entity.Latitude;
        //        existingPost.Longitude = entity.Longitude;
        //        existingPost.HelpRequiredCount = entity.HelpRequiredCount;
        //        existingPost.UpdatedBy = entity.UpdatedBy;
        //        existingPost.UpdatedAt = DateTime.Now;
        //        existingPost.CloseAt = DateTime.Now;
        //        context.SaveChanges();
        //        return true;
        //    }
        //    else
        //    {
        //        return false;
        //    }
        //}

        // Delete Post
        public override bool Delete(long id)
        {
            var existingPost = context.Post.Find(id);

            if (existingPost != null)
            {
                var existingComment = context.PostComments.Where(x => x.PostId == id).ToList();
                if (existingComment != null)
                {
                    foreach(var comment in existingComment)
                        context.PostComments.Remove(comment);
                }
                    
                var existingImages = context.PostImages.Where(x => x.PostId == id).ToList();
                if (existingImages != null)
                {
                    foreach (var images in existingImages)
                        context.PostImages.Remove(images);
                }

                var existingSpam = context.Spam.Where(x => x.PostId == id).ToList();
                if (existingSpam != null)
                {
                    foreach (var spam in existingSpam)
                        context.Spam.Remove(spam);
                }
                    
                var existingUrgency = context.Urgency.Where(x => x.PostId == id).ToList();
                if (existingUrgency != null)
                {
                    foreach (var urgency in existingUrgency)
                        context.Urgency.Remove(urgency);
                }

                var existingCluster = context.ClusterLocations.Where(x => x.PostId == id).ToList();
                if (existingCluster != null)
                {
                    foreach (var cluster in existingCluster)
                        context.ClusterLocations.Remove(cluster);
                }

                context.Post.Remove(existingPost);

                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }

        //get all verified post
        public  IEnumerable GetAllVerifiedPost()
        {
            //var post = context.Post.FromSqlRaw("exec getallVerifiedPost").ToList();
            var post = context.Post.Where(x => x.IsPublished == true).Include(x => x.User).Include(x => x.RequirementType).Include(x => x.Pincode);

            return post;
        }

        //get all unverified post
        public IEnumerable GetAllUnVerifiedPost()
        {
            //var post = context.Post.FromSqlRaw("exec getallUnVerifiedPost").ToList();
            var post = context.Post.Where(x => x.IsPublished == false).Include(x => x.User).Include(x => x.RequirementType).Include(x => x.Pincode);


            return post;
        }
        public Post GetPost(long id)
        {
            var post= context.Post.Include(x => x.PostImages).Include(x => x.Pincode).SingleOrDefault(x=>x.PostId==id);
            return post;
        }


        // Get Post by PostId
        public override Post GetById(long id)
        {
            var post = context.Post.Include(x => x.User).Include(x => x.City).Include(x => x.State).Include(x=>x.RequirementType).Include(x=>x.Urgency).Include(x=>x.Spam).
                Include(x=>x.PostComments).Include(x => x.PostImages).SingleOrDefault(x => x.PostId == id && x.IsPublished == true);
            return post;
        }
        
        //Get Post by UserName
        public IEnumerable GetPostByUserName(string name)
        {
            
            var post = context.Post.Include(x => x.User).Where(x => x.User.UserName == name && x.IsPublished == true);
            return post;
        }

        // Get Post by UserId
        public IEnumerable GetPostByUserId(long id)
        {
            var post = context.Post.Include(x => x.RequirementType).Include(x => x.Urgency).Include(x => x.Spam).Where(x => x.UserId == id && x.IsPublished == true).
                  Include(x => x.PostComments).Include(x => x.PostImages).Include(x => x.User).ToList();
            return post;
        }
        public IEnumerable GetPostForUser(long id)
        {
            var post = context.Post.Include(x => x.RequirementType).Include(x => x.Urgency).Include(x => x.Spam).Where(x => x.UserId == id).
                  Include(x => x.PostComments).Include(x => x.PostImages).Include(x => x.User).ToList();
            return post;
        }
        // Get Post by PincodeId
        public IEnumerable GetPostByPincodeId(long id)
        {
            var post = context.Post.Where(x => x.PincodeId == id && x.IsPublished == true).ToList();
            return post;
        }

        // Get Post by Pincode
        public IEnumerable GetPostByPincode(long id)
        {
            var post = context.Post.Include(x => x.Pincode).Where(x => x.Pincode.Pincode1 == id && x.IsPublished == true).ToList();
            return post;
        }

        // Get Post by CityId
        public IEnumerable GetPostByCity(long id)
        {
            var post = context.Post.Where(x => x.CityId == id && x.IsPublished == true).ToList();
            return post;
        }

        // Get Post by StateId
        public IEnumerable GetPostByState(long id)
        {
            var post = context.Post.Where(x => x.StateId == id && x.IsPublished == true).ToList();
            return post;
        }
        
        // Get Post by LocationName
        public IEnumerable GetPostByLocation(string name)
        {
            var post = context.Post.Where(x => x.LocationName == name && x.IsPublished == true).ToList();
            return post;
        }

        // Get Post by RequirementTypeId
        public IEnumerable GetPostByRequirement(long id)
        {
            var post = context.Post.Where(x => x.RequirementTypeId == id && x.IsPublished == true).ToList();
            return post;
        }     


        // Get Post by TimeRange
        public IEnumerable GetPostByDate(DateTime date)
        {            
            var post = context.Post.Where(x => x.CreatedAt <= date.Date && x.IsClosed == false && x.IsPublished == true).ToList();
            return post;
        }
        public bool closePost(long id)
        {
            var existingPost = context.Post.Find(id);
            if (existingPost != null)
            {
                existingPost.IsClosed = true;
                existingPost.CloseAt = DateTime.Now;
                context.SaveChanges();
                return true;
            }
            return false;
        }
    }
}
