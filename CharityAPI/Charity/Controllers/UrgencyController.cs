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
    public class UrgencyController : BaseAdminController
    {
        private readonly IUrgency _urgency;
        private readonly IUserData _users;
        public UrgencyController(IUrgency urgency, IUserData users)
        {
            _urgency = urgency;
            _users = users;
        }

        // POST: api/urgency
        [HttpPost]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<Urgency> AddUrgency(Urgency urgency)
        {
            var user = _users.GetByUserName(UserId);
            urgency.UserId = user.UserId;
            var validator = new UrgencyValidator();
            var result = validator.Validate(urgency);
            
            urgency.UpdatedBy = UserId;
            urgency.CreatedBy = UserId;
            urgency.CreatedAt = DateTime.Now;
            urgency.UpdatedAt = DateTime.Now;
            var data = _urgency.CheckUrgency(user.UserId, urgency.PostId);
            if (data!=null){
                var del = _urgency.Delete(data.UrgencyId);

                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Deleted", Message = "Urgency removed successfully!" });
            }
            else{
                if (!result.IsValid)
                    return StatusCode(500, result.ToCustomResponse());
                bool created = _urgency.Create(urgency);
                if (created)
                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });
            }
                



            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        //get all urgency
        // GET: api/urgency
        [HttpGet]
        public ActionResult<IEnumerable<Urgency>> GetAll()
        {
            return Ok(_urgency.GetAll());
        }

        //get urgency by urgency id
        // GET: api/urgency/2
        [HttpGet("{id}")]
        public ActionResult<Urgency> GetUrgencyById(int id)
        {
            var urgency = _urgency.GetById(id);

            if (urgency == null)
            {
                return NotFound();
            }

            return Ok(urgency);
        }

        //get urgency by post id
        // GET: api/urgency/post/id
        [HttpGet("post/{id}")]
        public ActionResult<Urgency> GetUrgencyByPostId(int id)
        {
            var urgency = _urgency.GetUrgencyByPostId(id);

            if (urgency == null)
            {
                return NotFound();
            }

            return Ok(urgency);
        }

        //get urgency by user id
        // GET: api/urgency/user/2
        [HttpGet("user/{id}")]
        public ActionResult<Urgency> GetUrgencyByUsertId(int id)
        {
            var urgency = _urgency.GetUrgencyByUserId(id);

            if (urgency == null)
            {
                return NotFound();
            }

            return Ok(urgency);
        }

        // PUT: api/urgency/2
        [HttpPut("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult EditUrgency(int id, Urgency urgency)
        {
            var validator = new UrgencyValidator();
            var result = validator.Validate(urgency);
            urgency.UpdatedBy = UserId;
            urgency.UpdatedAt = DateTime.Now;
            if (!result.IsValid)
                return StatusCode(500, result.ToCustomResponse());
            var uobj = _urgency.GetById(id);
            if (uobj == null)
            {
                return NotFound();

            }
            if (_urgency.Update(id, urgency))
            {
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Data updated successfully!" });
            }
            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });

        }

        // DELETE: api/urgency/id
        [HttpDelete("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult DeleteUrgncy(int id)
        {
            var uobj = _urgency.GetById(id);
            if (uobj != null)
            {
                bool deleted = _urgency.Delete(id);
                if (deleted)
                    return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Data deleted successfully!" });
                return BadRequest();
            }
            return NotFound();
        }
    }
}
