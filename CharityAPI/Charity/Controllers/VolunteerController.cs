using System;
using System.Collections.Generic;
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

namespace CharityAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VolunteerController : BaseAdminController
    {
        private readonly IVolunteer _volunteer;
        private readonly IUserData _userData;

        public VolunteerController(IVolunteer volunteer, IUserData users)
        {
            _volunteer = volunteer;
            _userData = users;
        }

        //GET: api/volunteer
        [HttpGet]
        public ActionResult<IEnumerable<Volunteer>> GetVolunteers()
        {
            return Ok(_volunteer.GetAll());
        }

        //GET: api/volunteer/1
        [HttpGet("{id}")]
        public ActionResult<Volunteer> GetVolunteer(long id)
        {
            var volunteer = _volunteer.GetById(id);

            if (volunteer == null)
            {
                return NotFound();
            }

            return Ok(volunteer);
        }

        // PUT: api/volunteer/1
        [HttpPut("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult EditVolunteer(long id, Volunteer volunteer)
        {
            var validator = new VolunteerValidator();
            var result = validator.Validate(volunteer);
            volunteer.UpdatedBy = UserId;
            volunteer.UpdatedAt = DateTime.Now;
            if (!result.IsValid)
            {
                return StatusCode(500, result.ToCustomResponse());
            }
            var volunteerObject = _volunteer.GetById(id);

            if (volunteerObject == null)
            {
                return NotFound();
            }
            if (_volunteer.Update(id, volunteer))
            {
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Data updated successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // POST: api/volunteer
        [HttpPost]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<Volunteer> AddVolunteer(Volunteer volunteer)
        {
            var validator = new VolunteerValidator();
            var user = _userData.GetByUserName(UserId);
            volunteer.VolunteerUserId = user.UserId;
            var result = validator.Validate(volunteer);
            volunteer.CreatedBy = UserId;
            volunteer.CreatedAt = DateTime.Now;
            volunteer.UpdatedBy = UserId;
            volunteer.UpdatedAt = DateTime.Now;

            var data = _volunteer.IsVolunteer(user.UserId, volunteer.OrganisationId);
            if (data == null)
            {
                //postlikedetails.Likes = true;
                //postlikedetails.DisLike = false;

                if (!result.IsValid)
                {
                    return StatusCode(500, result.ToCustomResponse());
                }
                bool created = _volunteer.Create(volunteer);
                if (created)
                {
                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });
                }
            }
            else
            {
                bool existing = _volunteer.Delete(data.VolunteerId);
                if (existing)
                    return StatusCode(StatusCodes.Status200OK, new Response { Status = "Deleted", Message = "Data Deleted successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // DELETE: api/volunteer/1
        [HttpDelete("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult DeleteVolunteer(long id)
        {
            var volunteerObject = _volunteer.GetById(id);
            if (volunteerObject != null)
            {
                bool deleted = _volunteer.Delete(id);
                if (deleted)
                {
                    return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Data deleted successfully!" });
                }
                return BadRequest();
            }
            return NotFound();
        }

        //GET: api/volunteer/userid/1
        [HttpGet("userid/{id}")]
        public ActionResult<IEnumerable<Volunteer>> GetVolunteerByUserId(long id)
        {
            var volunteer = _volunteer.GetByUserId(id);

            if (volunteer == null)
            {
                return NoContent();
            }

            return Ok(volunteer);
        }

        //GET: api/volunteer/organisationid/1
        [HttpGet("organisationid/{id}")]
        public ActionResult<IEnumerable<Volunteer>> GetVolunteerByOrganisationId(long id)
        {
            var volunteer = _volunteer.GetByOrganisationId(id);

            if (volunteer == null)
            {
                return NoContent();
            }

            return Ok(volunteer);
        }

        //GET: api/volunteer/organisation/RHA
        [HttpGet("organisation/{name}")]
        public ActionResult<IEnumerable<Volunteer>> GetVolunteerByOrganisationName(string name)
        {
            var volunteer = _volunteer.GetByOrganisationName(name);

            if (volunteer == null)
            {
                return NoContent();
            }

            return Ok(volunteer);
        }
        [HttpGet("check/{orgId}")]
        public ActionResult CheckOrganization(long orgId)
        {
            var userData = _userData.GetByUserName(UserId);
            var volunteer = _volunteer.IsVolunteer(userData.UserId, orgId);

            if (volunteer == null)
            {
                return StatusCode(204, new { Status = "404", Message = false });
            }

            return StatusCode(200, new { Status = "200", Message = true });
        }
    }
}
