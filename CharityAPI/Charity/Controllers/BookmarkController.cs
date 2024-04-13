using System;
using System.Collections.Generic;
using CharityAPI.Models;
using CharityAPI.Services;
using CharityAPI.Validations;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using CharityAPI.IServices;
using Microsoft.AspNetCore.Http;
using CharityAPI.Authentication;

namespace CharityAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookmarkController : BaseAdminController
    {
        private readonly IBookmark _bookmark;
        private readonly IUserData _users;
        private readonly IPost _post;

        public BookmarkController(IBookmark bookmark, IUserData users, IPost post)
        {
            _bookmark = bookmark;
            _users = users;
            _post = post;
        }

        // POST bookmark : api/bookmark
        [HttpPost]
        public ActionResult<Bookmark> AddBookmark(Bookmark bookmark)
        {
            var user = _users.GetByUserName(UserId);
            bookmark.UserId = user.UserId;
            var validator = new BookmarkValidator();
            var result = validator.Validate(bookmark);

            bookmark.UpdatedBy = UserId;
            bookmark.CreatedBy = UserId;
            bookmark.CreatedAt = DateTime.Now;
            bookmark.UpdatedAt = DateTime.Now;
            var data = _bookmark.CheckBookmark(user.UserId, bookmark.PostId);
            if (data != null)
            {
                var del = _bookmark.Delete(data.BookmarkId);
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Deleted", Message = "Bookmark removed successfully!" });
            }
            else
            {
                if (!result.IsValid)
                    return StatusCode(500, result.ToCustomResponse());
                bool created = _bookmark.Create(bookmark);
                if (created)
                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Post added to Bookmark successfully!" });
            }
            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // GET all : api/bookmark
        [HttpGet]
        public ActionResult<IEnumerable<Bookmark>> GetAll()
        {
            return Ok(_bookmark.GetAll());
        }

        // GET by id : api/bookmark/id
        [HttpGet("{id}")]
        public ActionResult<Bookmark> GetBookmarkById(int id)
        {
            var bookmark = _bookmark.GetById(id);
            if (bookmark == null)
            {
                return NotFound();
            }
            return Ok(bookmark);
        }

        // GET by post id : api/bookmark/post/id
        [HttpGet("post/{id}")]
        public ActionResult<Bookmark> GetBookmarkByPostId(int id)
        {
            var bookmark = _bookmark.GetBookmarkByPostId(id);
            if (bookmark == null)
            {
                return NotFound();
            }
            return Ok(bookmark);
        }

        // GET by user id : api/bookmark/user/id
        [HttpGet("user/{id}")]
        public ActionResult<Bookmark> GetBookmarkByUsertId(int id)
        {
            var bookmark = _bookmark.GetBookmarkByUserId(id);
            if (bookmark == null)
            {
                return NotFound();
            }
            return Ok(bookmark);
        }

        // PUT : api/bookmark/id
        [HttpPut("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult EditBookmark(int id, Bookmark bookmark)
        {
            var validator = new BookmarkValidator();
            var result = validator.Validate(bookmark);
            bookmark.UpdatedBy = UserId;
            bookmark.UpdatedAt = DateTime.Now;
            if (!result.IsValid)
                return StatusCode(500, result.ToCustomResponse());
            var uobj = _bookmark.GetById(id);
            if (uobj == null)
            {
                return NotFound();

            }
            if (_bookmark.Update(id, bookmark))
            {
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Bookmark updated successfully!" });
            }
            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // DELETE : api/bookmark/id
        [HttpDelete("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult DeleteBookmark(int id)
        {
            var uobj = _bookmark.GetById(id);
            if (uobj != null)
            {
                bool deleted = _bookmark.Delete(id);
                if (deleted)
                    return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Bookmark removed successfully!" });
                return BadRequest();
            }
            return NotFound();
        }

        // GET : api/bookmark/check/postid
        [HttpGet("check/{postId}")]
        public ActionResult CheckBookmark(long postId)
        {
            var userData = _users.GetByUserName(UserId);
            var bookmark = _bookmark.CheckBookmark(userData.UserId, postId);

            if (bookmark == null)
            {
                return NotFound();
                //return StatusCode(204, new { Status = "204", Message = false });
            }

            return StatusCode(200, new { Status = "200", Message = true });
        }

    }
}
