using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace CharityAPI.Services
{
    public class PostImagesServices : GenericRepository<PostImages>, IPostImages
    {
        public PostImagesServices(CharityAPIContext context) : base(context)
        {

        }

        //Get PostImages by PostId
        public PostImages GetByPostId(long id)
        {
            var postImages = context.PostImages.SingleOrDefault(x => x.PostId == id);
            return postImages;
        }

        //GetPostImages by UserId
        public IEnumerable GetByUserId(long id)
        {
            var postImages = context.PostImages.Where(x => x.UserId == id).ToList();
            return postImages;
        }

        //Get PostImages by UserName
        public IEnumerable GetByUserName(string name)
        {
            var postImages = context.PostImages.Include(x => x.User).Where(x => x.User.UserName == name ).ToList();
            return postImages;
        }
    }
}
