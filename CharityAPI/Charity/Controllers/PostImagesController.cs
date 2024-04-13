using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CharityAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PostImagesController : BaseAdminController
    {
        private readonly IPostImages _postImages;

        public PostImagesController(IPostImages postImages)
        {
            _postImages = postImages;
        }

        //GET: api/postImages
        [HttpGet]
        public ActionResult<IEnumerable<PostImages>> GetAllPostImages()
        {
            return Ok(_postImages.GetAll());
        }

        //GET: api/postImages/1
        [HttpGet("{id}")]
        public ActionResult<PostImages> GetPostImages(long id)
        {
            var postImages = _postImages.GetById(id);

            if (postImages == null)
            {
                return NotFound();
            }

            return Ok(postImages);
        }

        //GET: api/postImages/userid/1
        [HttpGet("userid/{id}")]
        public ActionResult<IEnumerable<PostImages>> GetPostImagesByUserId(long id)
        {
            var postImages = _postImages.GetByUserId(id);

            if (postImages == null)
            {
                return NoContent();
            }

            return Ok(postImages);
        }

        //GET: api/postImages/postid/1
        [HttpGet("postid/{id}")]
        public ActionResult<IEnumerable<PostImages>> GetPostImagesByPostId(long id)
        {
            var postImages = _postImages.GetByPostId(id);

            if (postImages == null)
            {
                return NoContent();
            }

            return Ok(postImages);
        }

        //GET: api/postImages/username/preet
        [HttpGet("username/{name}")]
        public ActionResult<IEnumerable<PostImages>> GetPostImagesByUserName(string name)
        {
            var postImages = _postImages.GetByUserName(name);

            if (postImages == null)
            {
                return NoContent();
            }

            return Ok(postImages);
        }
    }
}
