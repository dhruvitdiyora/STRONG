﻿using CharityAPI.Authentication;
using CharityAPI.IServices;
using CharityAPI.Models;
using CharityAPI.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Drawing;
using FluentValidation;
using CharityAPI.Validations;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Configuration;
using CloudinaryDotNet;
using CloudinaryDotNet.Actions;

namespace CharityAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CharityEventController : BaseAdminController
    {
        private readonly IEvent _charityEvent;

        private readonly IOrganisationData _orgData;
        private readonly ICharityEventPost _eventPost;
        private readonly IConfiguration _configuration;
        public CharityEventController(IEvent charityEvent,IOrganisationData orgdata, ICharityEventPost eventPost, IConfiguration configuration)
        {
            _charityEvent = charityEvent;
            _orgData = orgdata;
            _eventPost = eventPost;
            _configuration = configuration;
        }
        // GET: api/charityEvent
        [AllowAnonymous]
        [HttpGet]
        public ActionResult<IEnumerable<CharityEvent>> GetCharityEvent()
        {
            return Ok(_charityEvent.GetAll());
        }

        // GET: api/CharityEvent/2
        //[AllowAnonymous]
        [HttpGet("{id}")]
        public ActionResult<CharityEvent> GetCharityEvent(long id)
        {
            var charityEvent = _charityEvent.GetById(id);

            if (charityEvent == null)
            {
                return NoContent();
            }

            return Ok(charityEvent);
        }
        // PUT: api/CharityEvent/5
        [HttpPut("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult EditCharityEvent(long id)
        {
            var charityEvent = new CharityEvent();
            var httpRequest = HttpContext.Request;
            charityEvent = JsonConvert.DeserializeObject<CharityEvent>(httpRequest.Form["charityEvent"]);
            //Image img = null;
            string fileName = "";
            var myAccount = new Account { ApiKey = _configuration["cloudnary:ApiKey"], ApiSecret = _configuration["cloudnary:ApiSecret"], Cloud = _configuration["cloudnary:Cloud"] };
            Cloudinary cloudinary = new Cloudinary(myAccount);

            if (httpRequest.Form.Files.Count > 0)
            {
                fileName = HttpContext.Request.Form.Files[0].FileName;
                var uploadParams = new ImageUploadParams()
                {
                    File = new FileDescription(fileName, HttpContext.Request.Form.Files[0].OpenReadStream()),
                };
                var uploadResult = cloudinary.Upload(uploadParams);
                charityEvent.EventBannerUrl = uploadResult.SecureUrl.AbsoluteUri;
            }
            var validator = new CharityEventValidator();
            var result = validator.Validate(charityEvent);
            charityEvent.UpdatedAt = DateTime.Now;
            charityEvent.UpdatedBy = UserId;
            if (!result.IsValid)
                return StatusCode(500, result.ToCustomResponse());
            var charityEventObject = _charityEvent.GetById(id);
            if (charityEventObject == null)
            {
                return NotFound();

            }
            if (_charityEvent.Update(id, charityEvent))
            {
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Data uploaded successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
            //    return StatusCode(500, new Response { Status = "Error", Message = "Image File is missing!!!" });

            //return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });

        }
        // POST: api/charityEvent
        [HttpPost]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<CharityEvent> AddCharityEvent()
        {
            var charityEvent = new CharityEvent();
            var myAccount = new Account { ApiKey = _configuration["cloudnary:ApiKey"], ApiSecret = _configuration["cloudnary:ApiSecret"], Cloud = _configuration["cloudnary:Cloud"] };
            Cloudinary cloudinary = new Cloudinary(myAccount);
            var httpRequest = HttpContext.Request;
            charityEvent = JsonConvert.DeserializeObject<CharityEvent>(httpRequest.Form["charityEvent"]);
            //Image img = null;
            string fileName = "";

            if (httpRequest.Form.Files.Count > 0)
            {
                //img = Image.FromStream(HttpContext.Request.Form.Files[0].OpenReadStream());
                fileName = HttpContext.Request.Form.Files[0].FileName;
                var uploadParams = new ImageUploadParams()
                {
                    File = new FileDescription(fileName, HttpContext.Request.Form.Files[0].OpenReadStream()),
                };
                var uploadResult = cloudinary.Upload(uploadParams);
                charityEvent.EventBannerUrl = uploadResult.SecureUrl.AbsoluteUri;
            }
            var user = _orgData.GetByUserName(UserId);
            charityEvent.EventOrganiserId = user.OrganisationDataId;
            var validator = new CharityEventValidator();
            var result = validator.Validate(charityEvent);
            charityEvent.IsPublished = true;
            charityEvent.IsVerified = false;
            charityEvent.IsCompleted = false;
            charityEvent.UpdatedBy = UserId;
            charityEvent.CreatedBy = UserId;
            charityEvent.CreatedAt = DateTime.Now;
            charityEvent.UpdatedAt = DateTime.Now;

            if (!result.IsValid)
                return StatusCode(500, result.ToCustomResponse());
            bool created = _charityEvent.Create(charityEvent);
            if (created)
                return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });


            return StatusCode(500, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // DELETE: api/CharityEvent/id
        [HttpDelete("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult DeleteCharityEvent(int id)
        {
            
            var charityEventObject = _charityEvent.GetById(id);
            if (charityEventObject != null)
            {
                var eventPosts = _eventPost.GetChEvPostByEventId(id);
                foreach (CharityEventPost eventPost in eventPosts)
                    _eventPost.Delete(eventPost.CharityEventPostId);
                if (_charityEvent.Delete(id))
                {
                    //if (charityEventObject.EventBannerUrl != null && !string.IsNullOrEmpty(charityEventObject.EventBannerUrl))
                    //{
                    //    var commonHelper = new CommonHelper();
                    //    var attaachmentPath = commonHelper.GetEventBannerPath(charityEventObject.EventOrganiserId, charityEventObject.EventId);
                    //    commonHelper.DeleteAllfile(attaachmentPath);
                        return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Data deleted successfully!" });
                    //}
                }
                    
                return BadRequest();
            }
            return NotFound();
        }
        // GET: api/CharityEvent/city/2
        [HttpGet("city/{id}")]
        public ActionResult<CharityEvent> GetCharityEventByCIty(long id)
        {
            var charityEvent = _charityEvent.GetById(id);

            if (charityEvent == null)
            {
                return NoContent();
            }

            return Ok(charityEvent);
        }

        // GET: api/CharityEvent/organisation/2
        [HttpGet("organisation/{id}")]
        public ActionResult<CharityEvent> GetCharityEventByOrganisation(long id)
        {
            var charityEvent = _charityEvent.GetByOrganisation(id);

            if (charityEvent == null)
            {
                return NoContent();
            }

            return Ok(charityEvent);
        }
        // GET: api/CharityEvent/pincode/2
        [HttpGet("pincode/{id}")]
        public ActionResult<CharityEvent> GetCharityEventByPincode(long id)
        {
            var charityEvent = _charityEvent.GetByPincode(id);

            if (charityEvent == null)
            {
                return NoContent();
            }

            return Ok(charityEvent);
        }
        // GET: api/CharityEvent/current
        [HttpGet("current")]
        public ActionResult<CharityEvent> GetCurrrentCharityEvent(long id)
        {
            var charityEvent = _charityEvent.GetCurrent();

            if (charityEvent == null)
            {
                return NoContent();
            }

            return Ok(charityEvent);
        }
        // GET: api/CharityEvent/date
        [HttpGet("date")]
        public ActionResult<CharityEvent> GetCharityEventByDate(DateTime Date)
        {
            var charityEvent = _charityEvent.GetByDate(Date);

            if (charityEvent == null)
            {
                return NoContent();
            }

            return Ok(charityEvent);
        }
    }
}
