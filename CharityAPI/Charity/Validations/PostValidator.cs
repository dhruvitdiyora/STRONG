using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class PostValidator : AbstractValidator<Post>
    {
		
		#region ' Constructor '

		public PostValidator()
		{
			RuleFor(c => c.UserId).NotEmpty().WithMessage("UserId is required");

			RuleFor(c => c.PostDescription).NotEmpty().WithMessage("Please enter Post Description");

			RuleFor(c => c.RequirementTypeId).NotEmpty().WithMessage("Please select RequirementType");

			RuleFor(c => c.LocationName).NotEmpty().WithMessage("Location Name is required");

			RuleFor(c => c.HelpRequiredCount).NotEmpty().WithMessage("Please enter count of needy people");

			RuleFor(c => c.CityId).NotEmpty().WithMessage("Please select City");

			RuleFor(c => c.StateId).NotEmpty().WithMessage("Please select State");

			RuleFor(c => c.PincodeId).NotEmpty().WithMessage("Please enter Pincode");
		}

		#endregion ' Constructor '  
	}
}
