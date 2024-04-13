using CharityAPI.Authentication;
using CharityAPI.IServices;
using CharityAPI.Models;
using CharityAPI.Services;
using CharityAPI.Validations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CharityEventPostLikeController : BaseAdminController
    {
        private readonly ICharityEventPostLike _postlikedetails;
        private readonly IUserData _userData;
        public CharityEventPostLikeController(ICharityEventPostLike postlikedetails, IUserData users)
        {
            _postlikedetails = postlikedetails;
            _userData = users;
        }

        //post add like details
        // POST: api/pincode
        [HttpPost("like")]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<CharityEventPostLike> AddLikeDetails(CharityEventPostLike postlikedetails)
        {
            
            var validator = new CharityEventPostLikeValidator();
            var user = _userData.GetByUserName(UserId);
            postlikedetails.UserId = user.UserId;
            var result = validator.Validate(postlikedetails);
            postlikedetails.UpdatedBy = UserId;
            postlikedetails.CreatedBy = UserId;
            postlikedetails.CreatedAt = DateTime.Now;
            postlikedetails.UpdatedAt = DateTime.Now;

            var data = _postlikedetails.CheckLike(user.UserId, postlikedetails.CharityEventPostId);
            if(data == null)
            {
                postlikedetails.Likes = true;
                postlikedetails.DisLike = false;

                if (!result.IsValid)
                    return StatusCode(500, result.ToCustomResponse());
                bool created = _postlikedetails.Create(postlikedetails);
                if (created)
                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });
            }
            else
            {
                if(data.Likes)
                {
                    data.Likes = false;
                }
                else
                {
                    data.Likes = true;
                }
                data.DisLike = false;
                data.UpdatedAt = DateTime.Now;
                data.UpdatedBy = UserId;
                bool existing = _postlikedetails.Update(data.CharityEventPostLikeId, data);
                if (existing)
                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Added", Message = "Data Added successfully!" });
            }

            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }
        // POST: api/pincode
        [HttpPost("dislike")]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<CharityEventPostLike> AddDislikeDetails(CharityEventPostLike postlikedetails)
        {

            var validator = new CharityEventPostLikeValidator();
            var user = _userData.GetByUserName(UserId);
            postlikedetails.UserId = user.UserId;
            var result = validator.Validate(postlikedetails);
            postlikedetails.UpdatedBy = UserId;
            postlikedetails.CreatedBy = UserId;
            postlikedetails.CreatedAt = DateTime.Now;
            postlikedetails.UpdatedAt = DateTime.Now;

            var data = _postlikedetails.CheckLike(user.UserId, postlikedetails.CharityEventPostId);
            if (data == null)
            {
                postlikedetails.Likes = false;
                postlikedetails.DisLike = true;

                if (!result.IsValid)
                    return StatusCode(500, result.ToCustomResponse());
                bool created = _postlikedetails.Create(postlikedetails);
                if (created)
                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });
            }
            else
            {
                if (data.DisLike)
                {
                    data.DisLike = false;
                }
                else
                {
                    data.DisLike = true;
                }
                data.Likes = false;
                data.UpdatedAt = DateTime.Now;
                data.UpdatedBy = UserId;
                bool existing = _postlikedetails.Update(data.CharityEventPostLikeId, data);
                if (existing)
                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Added", Message = "Data Added successfully!" });
            }

            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // GET: api/state
        [HttpGet]
        public ActionResult<IEnumerable<CharityEventPostLike>> GetAll()
        {
            return Ok(_postlikedetails.GetAll());
        }

        //get state by postlike id
        // GET: api/postlikeservice/2
        [HttpGet("{id}")]
        public ActionResult<CharityEventPostLike> GetPostLikeById(long id)
        {
            var like = _postlikedetails.GetById(id);

            if (like == null)
            {
                return NotFound();
            }

            return Ok(like);
        }

        //get postlike by user id
        // GET: api/postlikeservice/user/
        [HttpGet("user/{id}")]
        public ActionResult<CharityEventPostLike> GetPostLikeByUserId(long id)
        {
            var like = _postlikedetails.GetPostLikeDetailsByUserID(id);

            if (like == null)
            {
                return NotFound();
            }

            return Ok(like);
        }

        //get number of like by post id 
        [HttpGet("like/number/{id}")]
        public long GetNumberOfLikesByPostId(long id)
        {
            var like = _postlikedetails.GetNumberOfLikesByPostId(id);

            return like;
        }

        //get number of like by post id 
        [HttpGet("dislike/number/{id}")]
        public long GetNumberOfDisLikesByPostId(long id)
        {
            var like = _postlikedetails.GetNumberOfDisLikesByPostId(id);

            return like;
        }

        // PUT: api/postlike
        [HttpPut("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult EditPostLike(int id, CharityEventPostLike model)
        {
            var validator = new CharityEventPostLikeValidator();
            var result = validator.Validate(model);
            model.UpdatedBy = UserId;
            model.UpdatedAt = DateTime.Now;
            if (!result.IsValid)
                return StatusCode(500, result.ToCustomResponse());
            var likeobj = _postlikedetails.GetById(id);
            if (likeobj == null)
            {
                return NotFound();

            }
            if (_postlikedetails.Update(id, model))
            {
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Data updated successfully!" });
            }
            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });

        }

        // DELETE: api/postlike/id
        [HttpDelete("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult DeletePostLike(int id)
        {
            var likeobj = _postlikedetails.GetById(id);
            if (likeobj != null)
            {
                bool deleted = _postlikedetails.Delete(id);
                if (deleted)
                    return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Data deleted successfully!" });
                return BadRequest();
            }
            return NotFound();
        }
    }
}
