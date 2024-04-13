using CharityAPI.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.IServices
{
    public interface IBookmark : IGenericInterface<Bookmark>
    {
        public IEnumerable GetBookmarkByPostId(long postid);
        public IEnumerable GetBookmarkByUserId(long userid);
        public Bookmark CheckBookmark(long userid, long postId);
    }
}
