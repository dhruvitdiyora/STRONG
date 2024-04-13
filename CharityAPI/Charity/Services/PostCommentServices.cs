using CharityAPI.IServices;
using CharityAPI.Models;
using Microsoft.AspNetCore.Http;
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
    public class PostCommentServices : GenericRepository<PostComments>, IPostComments
    {
        public PostCommentServices(CharityAPIContext context) : base(context)
        {

        }

        // Create Comment
        public override bool Create(PostComments comments)
        {
            var result = context.PostComments.Add(comments);
            context.SaveChanges();
            return true;
        }

        // Update Comment
        public override bool Update(long id, PostComments comments)
        {
            var existingcomment = context.PostComments.Find(id);
            if (existingcomment != null)
            {
                existingcomment.Comment = comments.Comment;
                existingcomment.UpdatedAt = comments.UpdatedAt;
                existingcomment.UpdatedBy = comments.UpdatedBy;
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }

        // Delete Comment
        public override bool Delete(long id)
        {
            var existingcomment = context.PostComments.Find(id);
            if(existingcomment != null)
            {
                context.PostComments.Remove(existingcomment);
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }

        // Get Comment By UserName
        public IEnumerable GetByUserName(string name)
        {

            var comment = context.PostComments.Include(x => x.User).Where(x => x.User.UserName == name && x.IsPublished == true);
            return comment;
        }

        // Get Comment By UserId
        public IEnumerable GetByUserId(long id)
        {

            var comment = context.PostComments.Where(x => x.UserId == id && x.IsPublished == true);
            return comment;
        }

        // Get Comment By PostId
        public IEnumerable GetByPostId(long id)
        {
            var comment = context.PostComments.Where(x => x.PostId == id && x.IsPublished == true).Include(x=>x.User);
            return comment;
        }
    }
}
