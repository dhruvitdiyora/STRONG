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
using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;

namespace CharityAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrganisationDataController : BaseAdminController
    {
        private readonly IOrganisationData _organisationData;
        private readonly IVolunteer _volunteer;
        private readonly IEvent _event;
        private readonly IConfiguration _configuration;

        public OrganisationDataController(IOrganisationData organisationData, IVolunteer volunteer, IEvent events, IConfiguration configuration)
        {
            _organisationData = organisationData;
            _volunteer = volunteer;
            _event = events;
            _configuration = configuration;
        }

        //GET: api/organisationData
        [AllowAnonymous]
        [HttpGet]
        public ActionResult<IEnumerable<OrganisationData>> GetOrganisationDatas()
        {
            return Ok(_organisationData.GetAll());
        }

        //GET:api
        [HttpGet("orginfo")]
        public ActionResult<Users> GetOrgInfo()
        {
            var org = _organisationData.GetOrgInfoByUser(UserId);

            if (org == null)
            {
                return NotFound();
            }

            return Ok(org);
        }

        //Get all verified post
        [AllowAnonymous]
        [HttpGet("verifiedorg")]
        public ActionResult<IEnumerable<OrganisationData>> GetAllVerifiedOrgs()
        {
            return Ok(_organisationData.GetAllVerifiedOrgs());
        }


        //Get all unverified post
        [HttpGet("unverifiedorg")]
        public ActionResult<IEnumerable<OrganisationData>> GetAllUnVerifiedOrgs()
        {
            return Ok(_organisationData.GetAllUnVerifiedOrgs());
        }

        //verify organisation
        // GET: organisationData/id
        [Authorize(Roles = UserRoles.Admin)]
        [HttpGet("verification/{id}")]
        public IActionResult VerifyOrg(long id)
        {
            var org = _organisationData.GetById(id);
            if (org != null)
            {
                org.UpdatedBy = UserId;
                org.UpdatedAt = DateTime.Now;
                //post.IsPublished = true;

                if (_organisationData.VerifyOrg(id, org))
                {
                    return StatusCode(StatusCodes.Status200OK, new Response { Status = "verified", Message = "Organisation verification successfully!" });
                }
                return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
            }
            return StatusCode(404, new Response { Status = "Error", Message = "Not Found" });
        }

        //GET: api/organisationData/1
        [HttpGet("{id}")]
        public IActionResult GetOrganisationData(long id)
        {
            var organisationData = _organisationData.GetById(id);
            var volunteers = _volunteer.GetByOrganisationId(id);
            var total = volunteers.Count();

            if (organisationData == null)
            {
                return NotFound();
            }
            //return Ok(organisationData);
            return StatusCode(StatusCodes.Status200OK, new {  model= organisationData, Total = total });
        }

        // PUT: api/organisationData/1
        [HttpPut("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult EditOrganisationData(long id)
        {
            var orgData = new OrganisationData();
            var httpRequest = HttpContext.Request;
            orgData = JsonConvert.DeserializeObject<OrganisationData>(httpRequest.Form["orgData"]);
            string filename="";
            var myAccount = new Account { ApiKey = _configuration["cloudnary:ApiKey"], ApiSecret = _configuration["cloudnary:ApiSecret"], Cloud = _configuration["cloudnary:Cloud"] };
            Cloudinary cloudinary = new Cloudinary(myAccount);

            if (httpRequest.Form.Files.Count > 0)
            {
                //img = Image.FromStream(HttpContext.Request.Form.Files[0].OpenReadStream());
                filename = HttpContext.Request.Form.Files[0].FileName;
                var uploadParams = new ImageUploadParams()
                {
                    File = new FileDescription(filename, HttpContext.Request.Form.Files[0].OpenReadStream()),
                };
                var uploadResult = cloudinary.Upload(uploadParams);
                orgData.OrganisationLogoUrl = uploadResult.SecureUrl.AbsoluteUri;

            }
            var validator = new OrganisationDataValidator();
            var result = validator.Validate(orgData);
            orgData.UpdatedBy = UserId;
            orgData.UpdatedAt = DateTime.Now;
            if (!result.IsValid)
            {
                return StatusCode(500, result.ToCustomResponse());
            }
            //var organisationData1 = _organisationData.GetByOrganisationName(orgData.OrganisationUserName);
            //if (organisationData1 != null)
            //{
            //    var Error = new CustomResponse();
            //    Error.Errors.Add("Organisation Name Already Exist");
            //    return StatusCode(400, Error);
            //}
            //var organisationData2 = _organisationData.GetByContactNo(orgData.OrganisationContactNo);
            //if (organisationData2 != null)
            //{
            //    var Error = new CustomResponse();
            //    Error.Errors.Add("Organisation Contact number Already Exist");
            //    return StatusCode(400, Error);
            //}

            var organisationDataObject = _organisationData.GetById(id);

            if (organisationDataObject == null)
            {
                return NotFound();
            }
            if (_organisationData.Update(id, orgData))
            {
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Data updated successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // POST: api/organisationData
        [HttpPost]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<OrganisationData> AddOrganisationData()
        {
            var orgData = new OrganisationData();
            var httpRequest = HttpContext.Request;
            orgData = JsonConvert.DeserializeObject<OrganisationData>(httpRequest.Form["orgData"]);
            //Image img = null;
            string fileName = "";
            var myAccount = new Account { ApiKey = _configuration["cloudnary:ApiKey"], ApiSecret = _configuration["cloudnary:ApiSecret"], Cloud = _configuration["cloudnary:Cloud"] };
            Cloudinary cloudinary = new Cloudinary(myAccount);
            if (httpRequest.Form.Files.Count > 0)
            {
                //img = Image.FromStream(HttpContext.Request.Form.Files[0].OpenReadStream());
                fileName = HttpContext.Request.Form.Files[0].FileName;
                var uploadParams = new ImageUploadParams()
                {
                    File = new FileDescription(fileName, HttpContext.Request.Form.Files[0].OpenReadStream()),
                };
                var uploadResult = cloudinary.Upload(uploadParams);
                orgData.OrganisationLogoUrl = uploadResult.SecureUrl.AbsoluteUri;

            }
            var validator = new OrganisationDataValidator();
            var result = validator.Validate(orgData);
            orgData.CreatedBy = UserId;
            orgData.CreatedAt = DateTime.Now;
            orgData.UpdatedBy = UserId;
            orgData.UpdatedAt = DateTime.Now;
            orgData.IsVerified = false;

            if (!result.IsValid)
            {
                return StatusCode(500, result.ToCustomResponse());
            }
            var organisationData1 = _organisationData.GetByOrganisationName(orgData.OrganisationName);
            if (organisationData1 != null)
            {
                var Error = new CustomResponse();
                Error.Errors.Add("Organisation Name Already Exist");
                return StatusCode(400, Error);
            }
            var organisationData2 = _organisationData.GetByContactNo(orgData.OrganisationContactNo);
            if (organisationData2 != null)
            {
                var Error = new CustomResponse();
                Error.Errors.Add("Organisation Contact number Already Exist");
                return StatusCode(400, Error);
            }

            bool created = _organisationData.Create(orgData);
            if (created)
            {
                return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // DELETE: api/organisationData/1
        [HttpDelete("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult DeleteOrganisationData(long id)
        {
            var organisationDataObject = _organisationData.GetById(id);
            if (organisationDataObject != null)
            {
                var events = _event.GetByOrganisation(id);
                foreach (CharityEvent chEv in events)
                    _event.Delete(chEv.EventId);
                bool deleted = _organisationData.Delete(id);
                if (deleted)
                {
                    //if (organisationDataObject.OrganisationLogoUrl != null && !string.IsNullOrEmpty(organisationDataObject.OrganisationLogoUrl))
                    //{
                    //    var commonHelper = new CommonHelper();
                    //    var attaachmentPath = commonHelper.GetOrganisationPath(id);
                    //    commonHelper.DeleteAllfile(attaachmentPath);
                        return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Data deleted successfully!" });
                   // }
                }
                return BadRequest();
            }
            return NotFound();
        }

        //GET: api/organisationData/name/RHA
        [HttpGet("name/{name}")]
        public ActionResult<ClusterLocations> GetOrganisationDataByOrganisationName(string name)
        {
            var organisationData = _organisationData.GetByOrganisationName(name);

            if (organisationData == null)
            {
                return NotFound();
            }

            return Ok(organisationData);
        }

        //GET: api/organisationData/userid/1
        [HttpGet("userid/{id}")]
        public ActionResult<ClusterLocations> GetOrganisationDataByUserId(long id)
        {
            var organisationData = _organisationData.GetByUserId(id);

            if (organisationData == null)
            {
                return NotFound();
            }

            return Ok(organisationData);
        }

        //GET: api/organisationData/contact/6544535125
        [HttpGet("contact/{contact}")]
        public ActionResult<ClusterLocations> GetOrganisationDataByContact(string contact)
        {
            var organisationData = _organisationData.GetByContactNo(contact);

            if (organisationData == null)
            {
                return NotFound();
            }

            return Ok(organisationData);
        }

        [AllowAnonymous]
        [HttpGet("details/{username}")]
        public ActionResult GetOrgs(string username)
        {
            var userData = _organisationData.GetByUserName(username);
            if (userData == null)
            {
                return StatusCode(204, new { Status = "404", Message = false });
            }

            return StatusCode(200, new { Status = "200", Message = true });
        }

    }
}
