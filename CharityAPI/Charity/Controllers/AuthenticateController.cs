﻿using CharityAPI.Authentication;
using CharityAPI.IServices;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthenticateController : ControllerBase
    {
        private readonly IUser users;
        private readonly IAdmin admins;
        private readonly IOrganisation organisations;
        private readonly IMailService mailService;
        private readonly IConfiguration _configuration;
        private readonly UserManager<ApplicationUser> userManager;
        public AuthenticateController(IUser user, IAdmin admin, IOrganisation organisation, IMailService mailService, IConfiguration configuration, UserManager<ApplicationUser> userManager)
        {
            users = user;
            admins = admin;
            organisations = organisation;
            this.mailService = mailService;
            _configuration = configuration;
            this.userManager = userManager;
        }

        // POST: api/authenticate/checkUser
        [HttpPost]
        [Route("checkUser")]
        public async Task<IActionResult> CheckUser([FromBody] LoginModel model)
        {
            var user = await userManager.FindByNameAsync(model.Username);
            if (user != null)
            {
                var Auth = await userManager.CheckPasswordAsync(user, model.Password);

                if (Auth)
                {
                    if (users.GetByName(model.Username) != null)
                    {
                        users.SendOTP(model.Username);
                        return Ok(new
                        {
                            Status = "Success",

                        });


                    }
                    
                    else if (organisations.GetByName(model.Username) != null)
                    {
                        organisations.SendOTP(model.Username);
                        return Ok(new
                        {
                            Status = "Success",

                        });

                    }
                    else
                    {
                        return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Incorrect Username or Password!" });
                    }
                }
            }
                
            return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Invalid Username or password" });

        }
        // POST: api/authenticate/login?otp=1234
        [HttpPost]
        [Route("login")]
        public async Task<IActionResult> Login([FromBody] LoginModel model, int otp)
        {
            var username = "";
            var pass = "";
            var role = "";
            var userOtp = 1234;

            if (users.GetByName(model.Username) != null)
            {
                username = model.Username;
                pass = model.Password;
                userOtp = (int)users.GetByName(model.Username).Otp;
                role = "User";

                if (otp != userOtp)
                {
                    return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Incorrect OTP!" });
                }

            }
            else if (admins.GetByName(model.Username) != null)
            {
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Incorrect Username or Password!" });

            }
            else if (organisations.GetByName(model.Username) != null)
            {
                username = model.Username;
                //pass = admins.FindName(model.Username).Password;
                pass = model.Password;
                role = UserRoles.Organisation;
                userOtp = (int)organisations.GetByName(model.Username).Otp;

                if (otp != userOtp)
                {
                    return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Incorrect OTP!" });
                }

            }
            else
            {
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Incorrect Username or Password!" });
            }
            var user = await userManager.FindByNameAsync(username);
            var lgn = await userManager.CheckPasswordAsync(user, pass);
            if(lgn)
            {
                var newToken = await users.LoginUser(username, pass);

                if (newToken != null)
                {
                    return Ok(new
                    {
                        role = role,
                        username = username,
                        token = newToken
                    });
                }

                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Email is not confirmed!" });
            }

            return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Wrong Password!" });
        }


        [HttpPost]
        [Route("login-admin")]
        public async Task<IActionResult> LoginAdmin([FromBody] LoginModel model)
        {
            var username = "";
            var pass = "";
            var role = "";
            if (admins.GetByName(model.Username) != null)
            { 
                username = model.Username;
                //pass = admins.FindName(model.Username).Password;
                pass = model.Password;
                role = "Admin";

                var newToken = await users.LoginUser(username, pass);

                if (newToken != null)
                {
                    return Ok(new
                    {
                        role = role,
                        username = username,
                        token = newToken
                    });
                }
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Email is not confirmed!" });
            }
            return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Incorrect Username or Password!" });

        }

        // POST: api/authenticate/register
        [HttpPost]
        [Route("register")]
        public async Task<IActionResult> Register([FromBody] RegisterModel model)
        {
            if (users.FindName(model.Username) != null)
            {
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "User already exists!" });
            }
            if (users.FindByEmail(model.Email) != null)
            {
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "User Email already exists!" });
            }

            if (users.FindContact(model.PhoneNumber) != null)
            {
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Contact No. already exists!" });
            }

            var result = await users.RegisterUser(model);
            if (!result.Succeeded)
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "User creation failed! Please check user details and try again." });

            //users.CreateUser(model);

            return Ok(new Response { Status = "Success", Message = "User created successfully!" });

        }

        // POST: api/authenticate/register-admin
        [HttpPost]
        [Route("register-admin")]
        public async Task<IActionResult> RegisterAdmin([FromBody] RegisterModel model)
        {
            if (users.FindName(model.Username) != null)
            {
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "User already exists!" });
            }
            if (users.FindByEmail(model.Email) != null)
            {
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "User Email already exists!" });
            }

            if (users.FindContact(model.PhoneNumber) != null)
            {
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Contact No. already exists!" });
            }

            var result = await admins.RegisterAdmin(model);
            if (!result.Succeeded)
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Admin creation failed! Please check admin details and try again." });

            admins.CreateAdmin(model);

            return Ok(new Response { Status = "Success", Message = "Admin created successfully!" });
        }
        // POST: api/authenticate/register-organisation
        [HttpPost]
        [Route("register-organisation")]
        public async Task<IActionResult> RegisterOrganisation([FromBody] RegisterModel model)
        {
            if (users.FindName(model.Username) != null)
            {
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "User already exists!" });
            }
            if (users.FindByEmail(model.Email) != null)
            {
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "User Email already exists!" });
            }

            if (users.FindContact(model.PhoneNumber) != null)
            {
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "Contact No. already exists!" });
            }

            var result = await organisations.RegisterOrganisation(model);
            if (!result.Succeeded)
                return StatusCode(StatusCodes.Status400BadRequest, new Response { Status = "Error", Message = "User creation failed! Please check user details and try again." });
            organisations.CreateOrganisation(model);
            //users.CreateUser(model);

            return Ok(new Response { Status = "Success", Message = "User created successfully!" });

        }

        // POST: api/authenticate/confirmemail
        [HttpGet("ConfirmEmail")]
        public async Task<IActionResult> ConfirmEmail(string userId, string token)
        {
            if (string.IsNullOrWhiteSpace(userId) || string.IsNullOrWhiteSpace(token))
            {
                return NotFound();
            }

            var result = await users.ConfirmEmailAsync(userId, token);

            if (result.Status == "Success")
            {
                return Redirect($"{_configuration["AppUrl"]}/confirmemail.html");
            }

            return BadRequest(result);
        }









        //private methods
    }

}
