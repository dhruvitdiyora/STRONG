using CharityAPI.Authentication;
using CharityAPI.IServices;
using CharityAPI.Models;
using CharityAPI.Services;
using CharityAPI.Validations;
using Microsoft.AspNetCore.Authorization;
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
    public class RequirementTypeController : BaseAdminController
    {
        private readonly IRequirementType _requirementTypes;
        public RequirementTypeController(IRequirementType requirementType)
        {
            _requirementTypes = requirementType;
        }

        // GET: api/requirementType
        [HttpGet]
        [AllowAnonymous]
        public ActionResult<IEnumerable<RequirementType>> GetRequirementTypes()
        {
            return Ok(_requirementTypes.GetAll());
        }

        // GET: api/requirementType/2
        [HttpGet("{id}")]
        public ActionResult<RequirementType> GetRequirementType(long id)
        {
            var requirementType = _requirementTypes.GetById(id);

            if (requirementType == null)
            {
                return NotFound();
            }

            return Ok(requirementType);
        }
        // PUT: api/requirementType/5
        [HttpPut("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult EditRequirementType(long id, RequirementType requirementType)
        {
            var validator = new RequirementTypeValidator();
            var result = validator.Validate(requirementType);
            requirementType.UpdatedBy = UserId;
            requirementType.UpdatedAt = DateTime.Now;
            if (!result.IsValid)
                return StatusCode(500, result.ToCustomResponse());
            var requirementTypeObject = _requirementTypes.GetById(id);
            if (requirementTypeObject == null)
            {
                return NotFound();
                
            }
            var reqtype = _requirementTypes.GetByName(requirementType.RequirementTypeName);
            if (reqtype != null)
            {
                var Error = new CustomResponse();
                Error.Errors.Add("RequirementType Already Exist");
                return StatusCode(400, Error);

            }
            if (_requirementTypes.Update(id,requirementType))
            {
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Data updated successfully!" });
            }
            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });

        }
        // POST: api/requirementType
        [HttpPost]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<RequirementType> AddRequirementType(RequirementType requirementType)
        {
            var validator = new RequirementTypeValidator();
            var result = validator.Validate(requirementType);
            requirementType.UpdatedBy = UserId;
            requirementType.CreatedBy = UserId;
            requirementType.CreatedAt = DateTime.Now;
            requirementType.UpdatedAt = DateTime.Now;

            if (!result.IsValid)
                return StatusCode(500, result.ToCustomResponse());
            var reqtype = _requirementTypes.GetByName(requirementType.RequirementTypeName);
            if (reqtype != null)
            {
                var Error = new CustomResponse();
                Error.Errors.Add("RequirementType Already Exist");
                return StatusCode(400, Error);

            }
            bool created = _requirementTypes.Create(requirementType);
            if(created)
                return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });
            

            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // DELETE: api/requirementType/id
        [HttpDelete("{id}")]
        [Authorize(Roles = UserRoles.Admin)]
        public IActionResult DeleteRequirementType(long id)
        {
            var requirementTypeObject = _requirementTypes.GetById(id);
            if (requirementTypeObject != null)
            {
                bool deleted =_requirementTypes.Delete(id);
                if(deleted)
                    return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Data deleted successfully!" });
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "RequirementType is in use in another place" });
            }
            return NotFound();
        }

        //GET: api/requirementType/Name/name
        [HttpGet("Name/{name}")]
        public IActionResult GetReqByReqName(string name)
        {
            var reqtype = _requirementTypes.GetByName(name);
            if (reqtype == null)
            {
                return NoContent();
            }

            return Ok(reqtype);
        }
    }
}
