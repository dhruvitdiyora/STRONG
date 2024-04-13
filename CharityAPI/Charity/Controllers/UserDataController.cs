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
    public class UserDataController : BaseAdminController
    {
        private readonly IUserData _userData;
        private readonly IPost _post;
        private readonly IUser _user;
        private readonly IConfiguration _configuration;

        public UserDataController(IUserData userData, IPost post, IUser user, IConfiguration configuration)
        {
            _userData = userData;
            _post = post;
            _user = user;
            _configuration = configuration;
        }

        //GET: api/userData
        [HttpGet]
        public ActionResult<IEnumerable<UserData>> GetUserDatas()
        {
            return Ok(_userData.GetAll());
        }



        //GET:api
        [HttpGet("userinfo")]
        public ActionResult<Users> GetUserInfo()
        {
            var user = _userData.GetUserInfoByUser(UserId);

            if (user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

        //GET:api
        [HttpGet("userdatainfo")]
        public ActionResult<Users> GetUserdataInfo()
        {
            var user = _userData.GetDetailsByUserName(UserId);

            if (user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }



        //GET: api/userData/1
        [HttpGet("{id}")]
        public ActionResult<UserData> GetUserData(long id)
        {
            var userData = _userData.GetById(id);

            if (userData == null)
            {
                return NotFound();
            }

            return Ok(userData);
        }

        // PUT: api/userData/1
        [HttpPut("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult EditUserData(long id)
        {
            var userData = new UserData();
            var httpRequest = HttpContext.Request;
            userData = JsonConvert.DeserializeObject<UserData>(httpRequest.Form["userData"]);
            Image img = null;
            var myAccount = new Account { ApiKey = _configuration["cloudnary:ApiKey"], ApiSecret = _configuration["cloudnary:ApiSecret"], Cloud = _configuration["cloudnary:Cloud"] };
            Cloudinary cloudinary = new Cloudinary(myAccount);
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
                userData.ProfileImage = uploadResult.SecureUrl.AbsoluteUri;

            }

            var validator = new UserDataValidator();
            var result = validator.Validate(userData);
            userData.UpdatedBy = UserId;
            userData.UpdatedAt = DateTime.Now;
            if (!result.IsValid)
            {
                return StatusCode(500, result.ToCustomResponse());
            }
            //var user2 = _userData.GetByEmailId(userData.EmailAddress);
            ////if (user2 != null)
            ////{
            ////    var Error = new CustomResponse();
            ////    Error.Errors.Add("Email-Id Already Exist");
            ////    return StatusCode(400, Error);
            ////}
            //var user3 = _userData.GetByContactNo(userData.MobileNo);
            //if (user3 != null)
            //{
            //    var Error = new CustomResponse();
            //    Error.Errors.Add("Mobile-No. Already Exist");
            //    return StatusCode(400, Error);
            //}
            var userDataObject = _userData.GetById(id);

            if (userDataObject == null)
            {
                return NotFound();
            }
            if (_userData.Update(id, userData))
            {
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Data updated successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // POST: api/userData
        [HttpPost]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<UserData> AddUserData()
        {
            var userData = new UserData();
            var httpRequest = HttpContext.Request;
            userData = JsonConvert.DeserializeObject<UserData>(httpRequest.Form["userData"]);
            Image img = null;
            var myAccount = new Account { ApiKey = _configuration["cloudnary:ApiKey"], ApiSecret = _configuration["cloudnary:ApiSecret"], Cloud = _configuration["cloudnary:Cloud"] };
            Cloudinary cloudinary = new Cloudinary(myAccount);
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
                userData.ProfileImage = uploadResult.SecureUrl.AbsoluteUri;
            }
            var validator = new UserDataValidator();
            var result = validator.Validate(userData);
            userData.CreatedBy = UserId;
            userData.CreatedAt = DateTime.Now;
            userData.UpdatedBy = UserId;
            userData.UpdatedAt = DateTime.Now;

            if (!result.IsValid)
            {
                return StatusCode(500, result.ToCustomResponse());
            }
            var user1 = _userData.GetByUserName(userData.UserName);
            if (user1 != null)
            {
                var Error = new CustomResponse();
                Error.Errors.Add("UserName Already Exist");
                return StatusCode(400, Error);

            }
            var user2 = _userData.GetByEmailId(userData.EmailAddress);
            if (user2 != null)
            {
                var Error = new CustomResponse();
                Error.Errors.Add("Email-Id Already Exist");
                return StatusCode(400, Error);

            }
            var user3 = _userData.GetByContactNo(userData.MobileNo);
            if (user3 != null)
            {
                var Error = new CustomResponse();
                Error.Errors.Add("Mobile-No. Already Exist");
                return StatusCode(400, Error);

            }
            var user4 = _userData.GetByUsersId(userData.Users);
            if (user4 != null)
            {
                var Error = new CustomResponse();
                Error.Errors.Add("User-Id Already Exist");
                return StatusCode(400, Error);

            }
            bool created = _userData.Create(userData);
            if (created)
            {
                return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Data Added successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // DELETE: api/userData/1
        [HttpDelete("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult DeleteUserData(long id)
        {
            var userDataObject = _userData.GetById(id);
            if (userDataObject != null)
            {
                var posts = _post.GetPostByUserId(id);
                foreach(Post post in posts)
                    _post.Delete(post.PostId);
                bool deleted = _userData.Delete(id);
                if (deleted)
                {
                    //if (userDataObject.ProfileImage != null && !string.IsNullOrEmpty(userDataObject.ProfileImage))
                    //{
                    //    var commonHelper = new CommonHelper();
                    //    var attaachmentPath = commonHelper.GetUserPath(id);
                    //    commonHelper.DeleteAllfile(attaachmentPath);
                        return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Data deleted successfully!" });
                    //}
                }
                return BadRequest();
            }
            return NotFound();
        }

        //GET: api/clusterLocation/cityid/1
        [HttpGet("cityid/{id}")]
        public ActionResult<IEnumerable<UserData>> GetUserDataByCityId(long id)
        {
            var userData = _userData.GetByCityId(id);

            if (userData == null)
            {
                return NoContent();
            }

            return Ok(userData);
        }

        [HttpGet("user/{id}")]
        public ActionResult<UserData> GetUserByUserId(long id)
        {
            var users = _userData.GetByUserId(id);
            if (users == null)
            {
                return NotFound();
            }
            return Ok(users);
        }

        //GET: api/clusterLocation/city/Ahmedabad
        [HttpGet("city/{name}")]
        public ActionResult<IEnumerable<UserData>> GetUserDataByCityName(string name)
        {
            var userData = _userData.GetByCityName(name);

            if (userData == null)
            {
                return NoContent();
            }

            return Ok(userData);
        }

        //GET: api/clusterLocation/pincode/380001
        [HttpGet("pincode/{pincode}")]
        public ActionResult<IEnumerable<UserData>> GetUserDataByPincode(long pincode)
        {
            var userData = _userData.GetByPincode(pincode);

            if (userData == null)
            {
                return NoContent();
            }

            return Ok(userData);
        }

        //GET: api/clusterLocation/stateid/1
        [HttpGet("stateid/{id}")]
        public ActionResult<IEnumerable<UserData>> GetUserDataByStateId(long id)
        {
            var userData = _userData.GetByStateId(id);

            if (userData == null)
            {
                return NoContent();
            }

            return Ok(userData);
        }

        //GET: api/clusterLocation/usermane/preet
        [AllowAnonymous]
        [HttpGet("username/{name}")]
        public ActionResult<UserData> GetUserDataByUserName(string name)
        {
            var userData = _userData.GetByUserName(name);

            if (userData == null)
            {
                return StatusCode(204,new { Status = "404", Message = false });
            }

            return StatusCode(200, new { Status = "200", Message = true });
        }

        //GET: api/clusterLocation/usersid/1
        [HttpGet("usersid/{id}")]
        public ActionResult<UserData> GetUserDataByUsersId(long id)
        {
            var userData = _userData.GetByUsersId(id);

            if (userData == null)
            {
                return NotFound();
            }

            return Ok(userData);
        }

        //GET: api/emailid/1
        [HttpGet("emailid/{email}")]
        public ActionResult<UserData> GetUserDataByEmail(string email)
        {
            var userData = _userData.GetByEmailId(email);
            if(userData == null)
            {
                return NotFound();
            }
            return Ok(userData);
        }

        //GET: api/mobno/mob
        [HttpGet("mobno/{mob}")]
        public ActionResult<UserData> GetUserByContactNo(string mob)
        {
            var userData = _userData.GetByContactNo(mob);
            if(userData == null)
            {
                return NotFound();
            }
            return Ok(userData);
        }
        [HttpGet("details/{username}")]
        public ActionResult GetUser(string username)
        {
            return Ok(_userData.GetByUserName(username));
        }
    }
}
