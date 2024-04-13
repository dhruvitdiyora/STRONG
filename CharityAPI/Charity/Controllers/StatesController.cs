using CharityAPI.Authentication;
using CharityAPI.IServices;
using CharityAPI.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.Validations;
using CharityAPI.Services;
using Microsoft.AspNetCore.Authorization;

namespace CharityAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StatesController : BaseAdminController
    {
        private readonly IStates _states;
        public StatesController(IStates states)
        {
            _states = states;
        }

        // POST: api/state
        [HttpPost]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<States> AddStates(States states)
        {
            var validator = new StatesValidator();
            var result = validator.Validate(states);
            states.UpdatedBy = UserId;
            states.CreatedBy = UserId;
            states.CreatedAt = DateTime.Now;
            states.UpdatedAt = DateTime.Now;

            if (!result.IsValid)
                return StatusCode(500, result.ToCustomResponse());
            var state = _states.GetStateByStateName(states.StateName);
            if (state != null)
            {
                var Error = new CustomResponse();
                Error.Errors.Add("State Name Already Exist");
                return StatusCode(400, Error);
            }
            bool created = _states.Create(states);
            if (created)
                return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });


            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }
        // GET: api/state
        [HttpGet]
        [AllowAnonymous]
        public ActionResult<IEnumerable<States>> GetAll()
        {
            return Ok(_states.GetAll());
        }

        //get state by state id
        // GET: api/state/2
        [HttpGet("{id}")]
        public ActionResult<States> GetStateById(int id)
        {
            var state = _states.GetById(id);

            if (state == null)
            {
                return NotFound();
            }

            return Ok(state);
        }

        //GET: api/state/goa
       [HttpGet("sname/{sname}")]
        public ActionResult<IEnumerable> GetStateByStateName(string sname)
        {
            var state = _states.GetStateByStateName(sname);

            if (state == null)
            {
                return NotFound();
            }

            return Ok(state);
        }

        // PUT: api/states25
        [HttpPut("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult EditState(int id, States states)
        {
            var validator = new StatesValidator();
            var result = validator.Validate(states);
            states.UpdatedBy = UserId;
            states.UpdatedAt = DateTime.Now;
            if (!result.IsValid)
                return StatusCode(500, result.ToCustomResponse());
            var stateobj = _states.GetById(id);
            if (stateobj == null)
            {
                return NotFound();

            }
            var state = _states.GetStateByStateName(states.StateName);
            if (state != null)
            {
                var Error = new CustomResponse();
                Error.Errors.Add("State Name Already Exist");
                return StatusCode(400, Error);

            }
            if (_states.Update(id, states))
            {
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Data updated successfully!" });
            }
            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });

        }

        // DELETE: api/states/id
        [HttpDelete("{id}")]
        [Authorize(Roles = UserRoles.Admin)]
        public IActionResult DeleteState(int id)
        {
            var stateobj = _states.GetById(id);
            if (stateobj != null)
            {
                bool deleted = _states.Delete(id);
                if (deleted)
                    return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Data deleted successfully!" });
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "State is in use in another place" });
            }
            return NotFound();
        }
    }
}
