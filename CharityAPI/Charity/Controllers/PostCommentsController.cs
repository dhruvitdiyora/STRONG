using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.Authentication;
using CharityAPI.IServices;
using CharityAPI.Models;
using CharityAPI.Services;
using CharityAPI.Validations;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CharityAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PostCommentsController : BaseAdminController
    {
        private readonly IPostComments _postComments;
        private readonly IUserData _users;
        public PostCommentsController(IPostComments postComments, IUserData users)
        {
            _postComments = postComments;
            _users = users;
        }

        // GET: api/postComments 
        [AllowAnonymous]
        [HttpGet]
        public ActionResult<IEnumerable<PostComments>> GetPostComments()
        {
            return Ok(_postComments.GetAll());
        }

        // GET: api/postComments/id
        [HttpGet("{id}")]
        public ActionResult<PostComments> GetPostComment(long id)
        {
            var comments = _postComments.GetById(id);
            if(comments == null)
            {
                return NotFound();
            }
            return Ok(comments);
        }

        //GET: api/postComments/postid/id
        [HttpGet("postid/{id}")]
        public ActionResult<PostComments> GetCommentByPostId(long id)
        {
            var comments = _postComments.GetByPostId(id);
            if(comments == null)
            {
                return NotFound();
            }
            return Ok(comments);
        }

        //GET: api/postComments/userid/id
        [HttpGet("userid/{id}")]
        public ActionResult<IEnumerable<PostComments>> GetCommentsByUserId(long id)
        {
            var comments = _postComments.GetByUserId(id);
            if (comments == null)
            {
                return NotFound();
            }
            return Ok(comments);
        }

        //GET: api/postComments/username/name
        [HttpGet("username/{name}")]
        public ActionResult<IEnumerable<PostComments>> GetCommentsByUserName(string name)
        {
            var comments = _postComments.GetByUserName(name);
            if(comments == null)
            {
                return NotFound();
            }
            return Ok(comments);
        }

        //POST: api/postComments
        [HttpPost]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<PostComments> AddPost(PostComments comments)
        {
            //var userData = context.UserData.SingleOrDefault(x => x.UserName == name && x.IsPublished == true);
            var user = _users.GetByUserName(UserId);
            var validator = new PostCommentsValidator();
            var result = validator.Validate(comments);
            comments.UserId = user.UserId;
            comments.CreatedBy = UserId;
            comments.UpdatedBy = UserId;
            comments.CreatedAt = DateTime.Now;
            comments.UpdatedAt = DateTime.Now;
            if (!result.IsValid)
                return StatusCode(500, result.ToCustomResponse());
            bool created = _postComments.Create(comments);
            if (created)
                return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });


            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        //PUT: api/postcomments/id
        [HttpPut("{id}")]
        public IActionResult EditPostComment(int id, PostComments comments)
        {
            var validator = new PostCommentsValidator();
            var result = validator.Validate(comments);
            comments.UpdatedBy = UserId;
            comments.UpdatedAt = DateTime.Now;
            if (!result.IsValid)
                return StatusCode(500, result.ToCustomResponse());
            var com = _postComments.GetById(id);
            if(com == null)
            {
                return NotFound();
            }
            if(_postComments.Update(id, comments))
            {
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Comment updated successfully!" });
            }
            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        //DELETE: api/postcomments/id
        [HttpDelete("{id}")]
        public IActionResult DeletePostComment(int id)
        {
            var comment = _postComments.GetById(id);
            if(comment != null)
            {
                bool deleted = _postComments.Delete(id);
                if (deleted)
                {
                    return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Data deleted successfully!" });
                }
                return BadRequest();
            }
            return NotFound();
        }
    }
}
