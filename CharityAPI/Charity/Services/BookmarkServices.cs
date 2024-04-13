using CharityAPI.IServices;
using CharityAPI.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.Services
{
    public class BookmarkServices : GenericRepository<Bookmark>, IBookmark
    {
        public BookmarkServices(CharityAPIContext context) : base(context)
        {
        }
        // create
        public override bool Create(Bookmark bookmark)
        {
            var result = context.Bookmark.Add(bookmark);
            context.SaveChanges();
            return true;
        }

        // get by bookmark id
        public IEnumerable<Bookmark> GetBookmarkById(long id)
        {
            var bookmark = context.Bookmark.Where(x => x.BookmarkId == id);

            return bookmark;
        }

        // get all bookmarks
        public override IEnumerable<Bookmark> GetAll()
        {
            var bookmark = context.Bookmark;
            return bookmark;
        }

        // get by user id
        public IEnumerable GetBookmarkByUserId(long userid)
        {
            var bookmark = context.Bookmark.Where(x => x.UserId == userid).ToList();
            return bookmark;
        }

        // get by post id
        public IEnumerable GetBookmarkByPostId(long postid)
        {
            var bookmark = context.Bookmark.Where(x => x.PostId == postid && x.IsPublished == true).Include(x => x.User);
            return bookmark;
        }

        // update
        public override bool Update(long id, Bookmark bookmark)
        {
            var existingbookmark = context.Bookmark.Find(id);

            if (existingbookmark != null)
            {

                existingbookmark.UserId = bookmark.UserId;
                existingbookmark.UpdatedBy = bookmark.UpdatedBy;
                existingbookmark.UpdatedAt = DateTime.Now;
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }

        }

        // delete
        public override bool Delete(long id)
        {
            var existingbookmark = context.Bookmark.Find(id);

            if (existingbookmark != null)
            {
                context.Bookmark.Remove(existingbookmark);
                context.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }

        // check
        public Bookmark CheckBookmark(long userid, long postId)
        {
            var bookmark = context.Bookmark.SingleOrDefault(x => x.UserId == userid && x.PostId == postId);
            return bookmark;

        }
    }

}

