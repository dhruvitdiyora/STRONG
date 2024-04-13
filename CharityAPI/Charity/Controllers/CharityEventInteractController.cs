using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.Authentication;
using CharityAPI.IServices;
using CharityAPI.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using CharityAPI.Services;
using CharityAPI.Validations;

namespace CharityAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CharityEventInteractController : BaseAdminController
    {
        private readonly ICharityEventInteract _charityEventInteract;
        private readonly IUserData _userData;

        public CharityEventInteractController(ICharityEventInteract charityEventInteract, IUserData users)
        {
            _charityEventInteract = charityEventInteract;
            _userData = users;
        }

        //GET: api/charityEventInteract
        [HttpGet]
        public ActionResult<IEnumerable<CharityEventInteract>> GetCharityEventInteracts()
        {
            return Ok(_charityEventInteract.GetAll());
        }

        //GET: api/charityEventInteract/1
        [HttpGet("{id}")]
        public ActionResult<CharityEventInteract> GetCharityEventInteract(long id)
        {
            var eventInteract = _charityEventInteract.GetById(id);

            if (eventInteract == null)
            {
                return NotFound();
            }

            return Ok(eventInteract);
        }

        // PUT: api/charityEventInteract/1
        [HttpPut("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult EditCharityEventInteract(long id, CharityEventInteract charityEventInteract)
        {
            var validator = new CharityEventInteractValidator();
            var result = validator.Validate(charityEventInteract);
            charityEventInteract.UpdatedBy = UserId;
            charityEventInteract.UpdatedAt = DateTime.Now;
            if (!result.IsValid)
            {
                return StatusCode(500, result.ToCustomResponse());
            }
            var charityEventInteractObject = _charityEventInteract.GetById(id);

            if (charityEventInteractObject == null)
            {
                return NotFound();
            }
            if (_charityEventInteract.Update(id, charityEventInteract))
            {
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Data updated successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // POST: api/charityEventInteract
        [HttpPost("interested")]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<CharityEventInteract> AddCharityEventInterested(CharityEventInteract charityEventInteract)
        {
            var validator = new CharityEventInteractValidator();
            var user = _userData.GetByUserName(UserId);
            charityEventInteract.UserId = user.UserId;
            var result = validator.Validate(charityEventInteract);
            charityEventInteract.CreatedBy = UserId;
            charityEventInteract.CreatedAt = DateTime.Now;
            charityEventInteract.UpdatedBy = UserId;
            charityEventInteract.UpdatedAt = DateTime.Now;

            var data = _charityEventInteract.CheckInteract(user.UserId, charityEventInteract.EventId);
            if (data == null)
            {
                charityEventInteract.IsInterested = true;
                charityEventInteract.IsGoing = false;

                if (!result.IsValid)
                {
                    return StatusCode(500, result.ToCustomResponse());
                }
                bool created = _charityEventInteract.Create(charityEventInteract);
                if (created)
                {
                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });
                }
            }
            else
            {
                if (data.IsInterested)
                {
                    data.IsInterested = false;
                }
                else
                {
                    data.IsInterested = true;
                }
                data.IsGoing = false;
                data.UpdatedAt = DateTime.Now;
                data.UpdatedBy = UserId;
                bool existing = _charityEventInteract.Update(data.CharityEventInteractId, data);
                if (existing)
                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Added", Message = "Data Added successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // POST: api/charityEventInteract
        [HttpPost("going")]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<CharityEventInteract> AddCharityEventGoing(CharityEventInteract charityEventInteract)
        {
            var validator = new CharityEventInteractValidator();
            var user = _userData.GetByUserName(UserId);
            charityEventInteract.UserId = user.UserId;
            var result = validator.Validate(charityEventInteract);
            charityEventInteract.CreatedBy = UserId;
            charityEventInteract.CreatedAt = DateTime.Now;
            charityEventInteract.UpdatedBy = UserId;
            charityEventInteract.UpdatedAt = DateTime.Now;

            var data = _charityEventInteract.CheckInteract(user.UserId, charityEventInteract.EventId);
            if (data == null)
            {
                charityEventInteract.IsInterested = false;
                charityEventInteract.IsGoing = true;

                if (!result.IsValid)
                {
                    return StatusCode(500, result.ToCustomResponse());
                }
                bool created = _charityEventInteract.Create(charityEventInteract);
                if (created)
                {
                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });
                }
            }
            else
            {
                if (data.IsGoing)
                {
                    data.IsGoing = false;
                }
                else
                {
                    data.IsGoing = true;
                }
                data.IsInterested = false;
                data.UpdatedAt = DateTime.Now;
                data.UpdatedBy = UserId;
                bool existing = _charityEventInteract.Update(data.CharityEventInteractId, data);
                if (existing)
                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Added", Message = "Data Added successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // DELETE: api/charityEventInteract/1
        [HttpDelete("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult DeleteCharityEventInteract(long id)
        {
            var charityEventInteractObject = _charityEventInteract.GetById(id);
            if (charityEventInteractObject != null)
            {
                bool deleted = _charityEventInteract.Delete(id);
                if (deleted)
                {
                    return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Data deleted successfully!" });
                }
                return BadRequest();
            }
            return NotFound();
        }

        //GET: api/charityEventInteract/eventid/1
        [HttpGet("eventid/{id}")]
        public ActionResult<IEnumerable<CharityEventInteract>> GetCharityEventInteractByEventId(long id)
        {
            var charityEventInteract = _charityEventInteract.GetByEventId(id);

            if (charityEventInteract == null)
            {
                return NoContent();
            }

            return Ok(charityEventInteract);
        }

        //GET: api/charityEventInteract/userid/1
        [HttpGet("userid/{id}")]
        public ActionResult<IEnumerable<CharityEventInteract>> GetCharityEventInteractByUserId(long id)
        {
            var charityEventInteract = _charityEventInteract.GetByUserId(id);

            if (charityEventInteract == null)
            {
                return NoContent();
            }

            return Ok(charityEventInteract);
        }

        //GET: api/charityEventInteract/interested/eventid/1
        [HttpGet("interested/eventid/{id}")]
        public ActionResult<IEnumerable<CharityEventInteract>> GetCharityEventInterestedByEventId(long id)
        {
            var charityEventInteract = _charityEventInteract.GetInterestedByEventId(id);

            if (charityEventInteract == null)
            {
                return NoContent();
            }

            return Ok(charityEventInteract);
        }

        //GET: api/charityEventInteract/interested/userid/1
        [HttpGet("interested/userid/{id}")]
        public ActionResult<IEnumerable<CharityEventInteract>> GetCharityEventInterestedByUserId(long id)
        {
            var charityEventInteract = _charityEventInteract.GetInterestedByUserId(id);

            if (charityEventInteract == null)
            {
                return NoContent();
            }

            return Ok(charityEventInteract);
        }

        //GET: api/charityEventInteract/going/eventid/1
        [HttpGet("going/eventid/{id}")]
        public ActionResult<IEnumerable<CharityEventInteract>> GetCharityEventGoingByEventID(long id)
        {
            var charityEventInteract = _charityEventInteract.GetGoingByEventId(id);

            if (charityEventInteract == null)
            {
                return NoContent();
            }

            return Ok(charityEventInteract);
        }

        //GET: api/charityEventInteract/going/userid/1
        [HttpGet("going/userid/{id}")]
        public ActionResult<IEnumerable<CharityEventInteract>> GetCharityEventGoingByUserId(long id)
        {
            var charityEventInteract = _charityEventInteract.GetGoingByUserId(id);

            if (charityEventInteract == null)
            {
                return NoContent();
            }

            return Ok(charityEventInteract);
        }
    }
}
