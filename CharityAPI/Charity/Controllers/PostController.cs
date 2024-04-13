using CharityAPI.IServices;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.Models;
using CharityAPI.Authentication;
using Newtonsoft.Json;
using System.Drawing;
using CharityAPI.Services;
using CharityAPI.Validations;
using CharityAPI.DTOs;
using Microsoft.AspNetCore.Authorization;
using System.IO;
using CloudinaryDotNet;
using Microsoft.Extensions.Configuration;
using CloudinaryDotNet.Actions;

namespace CharityAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PostController : BaseAdminController
    {
        private readonly IPost _post;
        private readonly IUserData _userData;
        private readonly IPostImages _images;
        private readonly IConfiguration _configuration;
        public PostController(IPost context, IUserData users, IPostImages postImages, IConfiguration configuration)
        {
            _post = context;
            _userData = users;
            _images = postImages;
            _configuration = configuration;
        }

        // GET: post
        [AllowAnonymous]
        [HttpGet]
        public ActionResult<IEnumerable<PostDTO>> GetAllPost()
        {
            var httpRequest = HttpContext.Request;
            string sort = httpRequest.Query["sort"];
            return Ok(_post.GetPosts(sort));
        }
        [HttpGet("user")]
        public ActionResult<IEnumerable<PostDTO>> GetAllPostUser()
        {
            var httpRequest = HttpContext.Request;
            string sort = httpRequest.Query["sort"];
            var user = _userData.GetByUserName(UserId);
            var post = _post.GetPostsforUser(user.PincodeId, user.CityId, user.StateId,user.UserId,sort);
            return Ok(post);
        }
        [AllowAnonymous]
        [HttpGet("userFilter")]
        public ActionResult<IEnumerable<PostDTO>> GetAllPostUsers()
        {
            var httpRequest = HttpContext.Request;
            long pincodeId = Convert.ToInt64( httpRequest.Query["pincodeId"]);
            long cityId = Convert.ToInt64( httpRequest.Query["cityId"]);
            long stateId = Convert.ToInt64( httpRequest.Query["stateId"]);
            long reqType = Convert.ToInt64( httpRequest.Query["reqType"]);
            string username = httpRequest.Query["username"];
            long userid = 0;
            //var posts = _post.GetPostByUserName(username);
            if (UserId!=null)
            {
                var user = _userData.GetByUserName(UserId);
                
                if (user != null)
                    userid = user.UserId;
            }

            var post = _post.GetPostsforFilter(pincodeId, cityId, stateId, userid, reqType,username);
            return Ok(post);
        }
        [AllowAnonymous]
        [HttpGet("home")]
        public ActionResult<IEnumerable<PostDTO>> GetAllPostHome()
        {
            var httpRequest = HttpContext.Request;
            long pincodeId = Convert.ToInt64(httpRequest.Query["pincodeId"]);
            long cityId = Convert.ToInt64(httpRequest.Query["cityId"]);
            long stateId = Convert.ToInt64(httpRequest.Query["stateId"]);
            long reqType = Convert.ToInt64(httpRequest.Query["reqType"]);
            string username = httpRequest.Query["username"];
            string sort = httpRequest.Query["sort"];
            long page = Convert.ToInt64(httpRequest.Query["page"]);
            long userid = 0;
            long total = 3;
            long filt = 0;
            if (UserId != null)
            {
                var user = _userData.GetByUserName(UserId);

                if (user != null)
                {
                    if(pincodeId==0 && cityId==0 && stateId ==0 && reqType==0 && username == "")
                    {
                        filt = 1;
                        //pincodeId = user.PincodeId;
                        stateId = user.StateId;
                        //cityId = user.CityId;
                    }
                    userid = user.UserId;
                }
                    
            }

            var post = _post.GetPostsforHome(pincodeId, cityId, stateId, userid, reqType, username, sort, page,total);
            return Ok(post);
        }
        //Get all verified post
        //[AllowAnonymous]

        [HttpGet("verifiedpost")]
        public ActionResult<IEnumerable<Post>> GetAllVerifiedPost()
        {
            return Ok(_post.GetAllVerifiedPost());
        }


        //Get all unverified post
        //[AllowAnonymous]
        [Authorize(Roles = UserRoles.Admin)]
        [HttpGet("unverifiedpost")]
        public ActionResult<IEnumerable<Post>> GetAllUnVerifiedPost()
        {
            return Ok(_post.GetAllUnVerifiedPost());
        }


        [AllowAnonymous]
        //GET: post/3
        [HttpGet("{id}")]
        public ActionResult<Post> GetPost(long id)
        {
            var post = _post.GetById(id);

            if(post == null)
            {
                return NotFound();
            }
            return Ok(post);
        }

        //GET: post/3
        [HttpGet("any/{id}")]
        public ActionResult<Post> GetAnyPost(long id)
        {
            var post = _post.GetPost(id);

            if (post == null)
            {
                return NotFound();
            }
            return Ok(post);
        }

        //verify post
        // PUT: post/id
        [Authorize(Roles = UserRoles.Admin)]
        [HttpGet("verification/{id}")]
        public IActionResult VerifyPost(long id)
        {
            var post = _post.GetPost(id);
            if(post != null) 
            { 
                post.UpdatedBy = UserId;
                post.UpdatedAt = DateTime.Now;
                //post.IsPublished = true;

                if (_post.VerifyPost(id, post))
                {
                    return StatusCode(StatusCodes.Status200OK, new Response { Status = "verified", Message = "Post verification successfully!" });
                }
                return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
            }
            return StatusCode(404, new Response { Status = "Error", Message = "Not Found" });
        }

        // PUT: post/id
        [HttpPut("{id}")]
        public IActionResult EditPost(long id)
        {
            var post = new Post();
            var httpRequest = HttpContext.Request;
            post = JsonConvert.DeserializeObject<Post>(httpRequest.Form["post"]);
            Image img = null;
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
                post.ImageUrl = uploadResult.SecureUrl.AbsoluteUri;
            }
            //post.ImageUrl = fileName;
            var validator = new PostValidator();
            var result = validator.Validate(post);
            post.UpdatedBy = UserId;
            post.UpdatedAt = DateTime.Now;
            
            if (!result.IsValid)
            {
                return StatusCode(500, result.ToCustomResponse());
            }
            var postObject = _post.GetPost(id);

            if(postObject == null)
            {
                return NotFound();
            }

            if(_post.Update(id, post))
            {
                if (httpRequest.Form.Files.Count > 4)
                {
                    var existing = _images.GetByPostId(id);
                    if (existing == null)
                    {
                        PostImages pi = new PostImages();
                        pi.CreatedBy = UserId;
                        pi.CreatedAt = DateTime.Now;
                        pi.UpdatedAt = DateTime.Now;
                        pi.UpdatedBy = UserId;
                        var uploadParams1 = new ImageUploadParams()
                        {
                            File = new FileDescription(fileName, HttpContext.Request.Form.Files[1].OpenReadStream()),
                        };
                        var uploadResult1 = cloudinary.Upload(uploadParams1);
                        pi.ImageUrl1 = uploadResult1.SecureUrl.AbsoluteUri;

                        var uploadParams2 = new ImageUploadParams()
                        {
                            File = new FileDescription(fileName, HttpContext.Request.Form.Files[2].OpenReadStream()),
                        };
                        var uploadResult2 = cloudinary.Upload(uploadParams2);
                        pi.ImageUrl2 = uploadResult2.SecureUrl.AbsoluteUri;
                        var uploadParams3 = new ImageUploadParams()
                        {
                            File = new FileDescription(fileName, HttpContext.Request.Form.Files[3].OpenReadStream()),
                        };
                        var uploadResult3 = cloudinary.Upload(uploadParams3);
                        pi.ImageUrl3 = uploadResult3.SecureUrl.AbsoluteUri;

                        var uploadParams4 = new ImageUploadParams()
                        {
                            File = new FileDescription(fileName, HttpContext.Request.Form.Files[4].OpenReadStream()),
                        };
                        var uploadResult4 = cloudinary.Upload(uploadParams4);
                        pi.ImageUrl4 = uploadResult4.SecureUrl.AbsoluteUri;
                        pi.UserId = postObject.UserId;
                        pi.PostId = id;
                        _images.Create(pi);
                        //pi.CreatedBy = UserId;
                        //pi.CreatedAt = DateTime.Now;
                        //pi.UpdatedAt = DateTime.Now;
                        //pi.UpdatedBy = UserId;
                        //var imagepath = new CommonHelper().GetPostPath(post.UserId, id);
                        //var img1 = Image.FromStream(HttpContext.Request.Form.Files[1].OpenReadStream());
                        //var img2 = Image.FromStream(HttpContext.Request.Form.Files[2].OpenReadStream());
                        //var img3 = Image.FromStream(HttpContext.Request.Form.Files[3].OpenReadStream());
                        //var img4 = Image.FromStream(HttpContext.Request.Form.Files[4].OpenReadStream());
                        //var fileName1 = HttpContext.Request.Form.Files[1].FileName;
                        //var fileName2 = HttpContext.Request.Form.Files[2].FileName;
                        //var fileName3 = HttpContext.Request.Form.Files[3].FileName;
                        //var fileName4 = HttpContext.Request.Form.Files[4].FileName;
                        //pi.ImageUrl1 = fileName1;
                        //pi.ImageUrl2 = fileName2;
                        //pi.ImageUrl3 = fileName3;
                        //pi.ImageUrl4 = fileName4;
                        //pi.PostId = id;
                        //pi.UserId = postObject.UserId;
                        //_post.saveImage(img1, Path.Combine(imagepath, fileName1));
                        //_post.saveImage(img2, Path.Combine(imagepath, fileName2));
                        //_post.saveImage(img3, Path.Combine(imagepath, fileName3));
                        //_post.saveImage(img4, Path.Combine(imagepath, fileName4));
                        //_images.Create(pi);
                        return StatusCode(StatusCodes.Status201Created, new Response { Status = "Updated", Message = "Post updated successfully!" });
                    }
                    else
                    {
                        existing.UpdatedAt = DateTime.Now;
                        existing.UpdatedBy = UserId;
                        var uploadParams1 = new ImageUploadParams()
                        {
                            File = new FileDescription(fileName, HttpContext.Request.Form.Files[1].OpenReadStream()),
                        };
                        var uploadResult1 = cloudinary.Upload(uploadParams1);
                        existing.ImageUrl1 = uploadResult1.SecureUrl.AbsoluteUri;

                        var uploadParams2 = new ImageUploadParams()
                        {
                            File = new FileDescription(fileName, HttpContext.Request.Form.Files[2].OpenReadStream()),
                        };
                        var uploadResult2 = cloudinary.Upload(uploadParams2);
                        existing.ImageUrl2 = uploadResult2.SecureUrl.AbsoluteUri;
                        var uploadParams3 = new ImageUploadParams()
                        {
                            File = new FileDescription(fileName, HttpContext.Request.Form.Files[3].OpenReadStream()),
                        };
                        var uploadResult3 = cloudinary.Upload(uploadParams3);
                        existing.ImageUrl3 = uploadResult3.SecureUrl.AbsoluteUri;

                        var uploadParams4 = new ImageUploadParams()
                        {
                            File = new FileDescription(fileName, HttpContext.Request.Form.Files[4].OpenReadStream()),
                        };
                        var uploadResult4 = cloudinary.Upload(uploadParams4);
                        existing.ImageUrl4 = uploadResult4.SecureUrl.AbsoluteUri;
                        //var imagepath = new CommonHelper().GetPostPath(post.UserId, id);
                        //var imageFileName1 = Path.GetFileName(existing.ImageUrl1);
                        //var imageFileName2 = Path.GetFileName(existing.ImageUrl2);
                        //var imageFileName3 = Path.GetFileName(existing.ImageUrl3);
                        //var imageFileName4 = Path.GetFileName(existing.ImageUrl4);
                        //var commonHelper = new CommonHelper();
                        //commonHelper.DeleteFilePath(imagepath, imageFileName1);
                        //commonHelper.DeleteFilePath(imagepath, imageFileName2);
                        //commonHelper.DeleteFilePath(imagepath, imageFileName3);
                        //commonHelper.DeleteFilePath(imagepath, imageFileName4);
                        //var img1 = Image.FromStream(HttpContext.Request.Form.Files[1].OpenReadStream());
                        //var img2 = Image.FromStream(HttpContext.Request.Form.Files[2].OpenReadStream());
                        //var img3 = Image.FromStream(HttpContext.Request.Form.Files[3].OpenReadStream());
                        //var img4 = Image.FromStream(HttpContext.Request.Form.Files[4].OpenReadStream());
                        //var fileName1 = HttpContext.Request.Form.Files[1].FileName;
                        //var fileName2 = HttpContext.Request.Form.Files[2].FileName;
                        //var fileName3 = HttpContext.Request.Form.Files[3].FileName;
                        //var fileName4 = HttpContext.Request.Form.Files[4].FileName;
                        //existing.ImageUrl1 = fileName1;
                        //existing.ImageUrl2 = fileName2;
                        //existing.ImageUrl3 = fileName3;
                        //existing.ImageUrl4 = fileName4;
                        //_post.saveImage(img1, Path.Combine(imagepath, fileName1));
                        //_post.saveImage(img2, Path.Combine(imagepath, fileName2));
                        //_post.saveImage(img3, Path.Combine(imagepath, fileName3));
                        //_post.saveImage(img4, Path.Combine(imagepath, fileName4));
                        _images.Update(existing.PostImagesId,existing);
                        return StatusCode(StatusCodes.Status201Created, new Response { Status = "Updated", Message = "Post updated successfully!" });
                    }
                }
                return StatusCode(StatusCodes.Status200OK, new Response { Status = "Updated", Message = "Data uploaded successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // POST: post
        [HttpPost]
        //[Authorize(Roles = UserRoles.Admin)]
        public ActionResult<Post> AddPost()
        {
            var myAccount = new Account { ApiKey = _configuration["cloudnary:ApiKey"], ApiSecret = _configuration["cloudnary:ApiSecret"], Cloud = _configuration["cloudnary:Cloud"] };
            Cloudinary cloudinary = new Cloudinary(myAccount);
            var post = new Post();
            var httpRequest = HttpContext.Request;
            post = JsonConvert.DeserializeObject<Post>(httpRequest.Form["post"]);
            
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
                post.ImageUrl = uploadResult.SecureUrl.AbsoluteUri;
            }
            //var user1 = _userData.GetByUserName(CurrentUserName);

            var validator = new PostValidator();
            var result = validator.Validate(post);
            var user = _userData.GetByUserName(UserId);
            post.UserId = user.UserId;
            post.CreatedBy = UserId ;
            post.CreatedAt = DateTime.Now;
            post.IsClosed = false;
            post.CloseAt = DateTime.Now;
            post.UpdatedBy = UserId;
            post.UpdatedAt = DateTime.Now;
            post.IsPublished = false;
            //post.ImageUrl = fileName;
            if (!result.IsValid)
            {
                return StatusCode(500, result.ToCustomResponse());
            }
            long created = _post.Create(post);
            if (created!=0)
            {
               
                if (httpRequest.Form.Files.Count > 4)
                {
                    PostImages pi = new PostImages();
                    pi.CreatedBy = UserId;
                    pi.CreatedAt = DateTime.Now;
                    pi.UpdatedAt = DateTime.Now;
                    pi.UpdatedBy = UserId;
                    var uploadParams1 = new ImageUploadParams()
                    {
                        File = new FileDescription(fileName, HttpContext.Request.Form.Files[1].OpenReadStream()),
                    };
                    var uploadResult1 = cloudinary.Upload(uploadParams1);
                    pi.ImageUrl1 = uploadResult1.SecureUrl.AbsoluteUri;

                    var uploadParams2 = new ImageUploadParams()
                    {
                        File = new FileDescription(fileName, HttpContext.Request.Form.Files[2].OpenReadStream()),
                    };
                    var uploadResult2 = cloudinary.Upload(uploadParams2);
                    pi.ImageUrl2 = uploadResult2.SecureUrl.AbsoluteUri;
                    var uploadParams3 = new ImageUploadParams()
                    {
                        File = new FileDescription(fileName, HttpContext.Request.Form.Files[3].OpenReadStream()),
                    };
                    var uploadResult3 = cloudinary.Upload(uploadParams3);
                    pi.ImageUrl3 = uploadResult3.SecureUrl.AbsoluteUri;

                    var uploadParams4 = new ImageUploadParams()
                    {
                        File = new FileDescription(fileName, HttpContext.Request.Form.Files[4].OpenReadStream()),
                    };
                    var uploadResult4 = cloudinary.Upload(uploadParams4);
                    pi.ImageUrl4 = uploadResult4.SecureUrl.AbsoluteUri;

                    //var imagepath = new CommonHelper().GetPostPath(post.UserId,created);
                    //var img1 = Image.FromStream(HttpContext.Request.Form.Files[1].OpenReadStream());
                    //var img2 = Image.FromStream(HttpContext.Request.Form.Files[2].OpenReadStream());
                    //var img3 = Image.FromStream(HttpContext.Request.Form.Files[3].OpenReadStream());
                    //var img4 = Image.FromStream(HttpContext.Request.Form.Files[4].OpenReadStream());
                    //var fileName1 = HttpContext.Request.Form.Files[1].FileName;
                    //var fileName2 = HttpContext.Request.Form.Files[2].FileName;
                    //var fileName3 = HttpContext.Request.Form.Files[3].FileName;
                    //var fileName4 = HttpContext.Request.Form.Files[4].FileName;
                    //pi.ImageUrl1 = fileName1;
                    //pi.ImageUrl2 = fileName2;
                    //pi.ImageUrl3 = fileName3;
                    //pi.ImageUrl4 = fileName4;
                    pi.PostId = created;
                    pi.UserId = user.UserId;
                    //_post.saveImage(img1, Path.Combine(imagepath, fileName1));
                    //_post.saveImage(img2, Path.Combine(imagepath, fileName2));
                    //_post.saveImage(img3, Path.Combine(imagepath, fileName3));
                    //_post.saveImage(img4, Path.Combine(imagepath, fileName4));
                    _images.Create(pi);

                    return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Post created successfully!" });
                }
                
                return StatusCode(StatusCodes.Status201Created, new Response { Status = "Created", Message = "Post created successfully!" });
            }
            return StatusCode(StatusCodes.Status500InternalServerError, new Response { Status = "Error", Message = "Something went wrong. Please contact Administrator!" });
        }

        // DELETE: post/id
        [HttpDelete("{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult DeletePost(long id)
        {
            var postObject = _post.GetPost(id);
            if (postObject != null)
            {
                var user = UserId;
                bool deleted = _post.Delete(id);
                if (deleted)
                {
                    //if (postObject.ImageUrl != null && !string.IsNullOrEmpty(postObject.ImageUrl))
                    //{
                    //    var commonHelper = new CommonHelper();
                    //    var attaachmentPath = commonHelper.GetPostPath(postObject.UserId, postObject.PostId);
                    //    commonHelper.DeleteAllfile(attaachmentPath);
                        return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Data deleted successfully!" });
                    //}
                }
                return BadRequest();
            }
            return NotFound();
        }

        //GET: post/City/id
        [HttpGet("City/{id}")]
        public ActionResult<IEnumerable<Post>> GetPostByCity(long id)
        {
            var post = _post.GetPostByCity(id);

            if (post == null)
            {
                return NoContent();
            }

            return Ok(post);
        }

        [HttpGet("close/{id}")]
        //[Authorize(Roles = UserRoles.Admin)]
        public IActionResult ClosePost(long id)
        {
            var post = _post.closePost(id);
            if (post)
            {
                return StatusCode(StatusCodes.Status202Accepted, new Response { Status = "Deleted", Message = "Post closed successfully!" });
            }
            return BadRequest();
        }

            //GET: post/State/id
            [HttpGet("State/{id}")]
        public ActionResult<IEnumerable<Post>> GetPostByState(long id)
        {
            var post = _post.GetPostByState(id);

            if (post == null)
            {
                return NoContent();
            }

            return Ok(post);
        }

        //GET: post/PincodeId/id
        [HttpGet("PincodeId/{id}")]
        public ActionResult<IEnumerable<Post>> GetPostByPincodeId(long id)
        {
            var post = _post.GetPostByPincodeId(id);

            if (post == null)
            {
                return NoContent();
            }

            return Ok(post);
        }

        //GET: post/Pincode/PincodeNo.
        [HttpGet("Pincode/{id}")]
        public ActionResult<IEnumerable<Post>> GetPostByPincode(long id)
        {
            var post = _post.GetPostByPincode(id);

            if (post == null)
            {
                return NoContent();
            }

            return Ok(post);
        }

        // GET: post/Location/name
        [HttpGet("Location/{name}")]
        public ActionResult<IEnumerable<Post>> GetPostByLocation(string name)
        {
            var post = _post.GetPostByLocation(name);

            if (post == null)
            {
                return NoContent();
            }

            return Ok(post);
        }

        // GET: post/user/name
        [HttpGet("user/{name}")]
        public ActionResult<IEnumerable<Post>> GetPostByUserName(string name)
        {
            var post = _post.GetPostByUserName(name);

            if (post == null)
            {
                return NoContent();
            }

            return Ok(post);
        }

        //GET: post/userid/id
        [HttpGet("userid/{id}")]
        public ActionResult<IEnumerable<Post>> GetPostByUserId(long id)
        {
            var post = _post.GetPostByUserId(id);

            if (post == null)
            {
                return NoContent();
            }

            return Ok(post);
        }


        //GET:api
        [HttpGet("userpostbyuid")]
        public ActionResult<IEnumerable<Post>> GetPostdetailByUserId()

        {
            var user = _userData.GetByUserName(UserId);
           var uid = user.UserId;
            var post = _post.GetPostByUserId(uid);

            if (post == null)
            {
                return NoContent();
            }

            return Ok(post);
        }
        [HttpGet("userpostforuser")]
        public ActionResult<IEnumerable<Post>> GetPostdetailByForUser()

        {
            var user = _userData.GetByUserName(UserId);
            var uid = user.UserId;
            var post = _post.GetPostForUser(uid);

            if (post == null)
            {
                return NoContent();
            }

            return Ok(post);
        }

        //GET: post/Requirement/id
        [HttpGet("Requirement/{id}")]
        public ActionResult<IEnumerable<Post>> GetPostByRequirement(long id)
        {
            var post = _post.GetPostByRequirement(id);

            if (post == null)
            {
                return NoContent();
            }

            return Ok(post);
        }


        //GET: post/Timerange/date
        [HttpGet("Timerange/{date}")]
        public ActionResult<IEnumerable<Post>> GetPostByDate(DateTime date)
        {
            var post = _post.GetPostByDate(date);

            if (post == null)
            {
                return NoContent();
            }

            return Ok(post);
        }
    }
}
