using CharityAPI.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.IServices
{
    public interface IPost : IGenericInterface<Post>
    {
        public long Create(Post post);
        //public bool Update(long id, Post post);
        public IEnumerable GetPostByUserName(string name);
        public IEnumerable GetAllVerifiedPost();
        public IEnumerable GetAllUnVerifiedPost();
        public IEnumerable GetPostByUserId(long id);
        public IEnumerable GetPostForUser(long id);
        public IEnumerable GetPostByPincode(long id);
        public IEnumerable GetPostByPincodeId(long id);
        public IEnumerable GetPostByCity(long id);
        public IEnumerable GetPostByState(long id);
        public IEnumerable GetPostByLocation(string name);
        public IEnumerable GetPostByRequirement(long id);
        public bool VerifyPost(long id ,Post post);
        public IEnumerable GetPostByDate(DateTime date);

        public IEnumerable GetPostsforUser(long pincodeId, long cityId, long stateId,long userId,string sort);
        public IEnumerable GetPostsforFilter(long pincodeId, long cityId, long stateId, long userId, long reqType, string username);
        public IEnumerable GetPostsforHome(long pincodeId, long cityId, long stateId, long userId, long reqType, string username, string sort, long page, long total);
        public IEnumerable GetPosts(string sort);
        public Post GetPost(long id);

        public bool saveImage(Image file, string path);
        public bool closePost(long id);


    }
}
