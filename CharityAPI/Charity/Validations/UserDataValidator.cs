using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class UserDataValidator : AbstractValidator<UserData>
    {
		
		#region ' Constructor '

		public UserDataValidator()
		{
			RuleFor(c => c.FirstName).NotEmpty().WithMessage("Please enter First Name");

			RuleFor(c => c.LastName).NotEmpty().WithMessage("Please enter Last Name");

			RuleFor(c => c.Gender).NotEmpty().WithMessage("Please select Gender");

			RuleFor(c => c.UserName).NotEmpty().WithMessage("Please enter UserName");

			RuleFor(c => c.EmailAddress).NotEmpty().WithMessage("Please enter Email Address")
				.EmailAddress().WithMessage("Please enter valid Email Address");

			RuleFor(c => c.MobileNo).NotEmpty().WithMessage("Please enter Mobile Number")
				.Matches(@"^[6789]\d{9}$").WithMessage("Please enter valid Mobile Number");

			RuleFor(c => c.Users).NotEmpty().WithMessage("Users field is required");

			RuleFor(c => c.CityId).NotEmpty().WithMessage("Please Select City");

			RuleFor(c => c.StateId).NotEmpty().WithMessage("Please select State");

			RuleFor(c => c.PincodeId).NotEmpty().WithMessage("Please enter Pincode");

		}

		#endregion ' Constructor '  
	}
}
