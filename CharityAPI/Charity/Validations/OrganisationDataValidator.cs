using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class OrganisationDataValidator : AbstractValidator<OrganisationData>
    {
		
		#region ' Constructor '

		public OrganisationDataValidator()
		{
			RuleFor(c => c.OrganisationUserId).NotEmpty().WithMessage("Organisation UserId is required");

			RuleFor(c => c.OrganisationName).NotEmpty().WithMessage("Organisation Name is required");

			RuleFor(c => c.OrganisationAddress).NotEmpty().WithMessage("Organisation Address is required");

			RuleFor(c => c.OrganisationContactNo).NotEmpty().WithMessage("Contact numbeer is required")
				.Matches(@"^[6789]\d{9}$").WithMessage("Enter valid contact number");

			//RuleFor(c => c.OrganisationLogoUrl).NotEmpty().WithMessage("Organisation Image is required");

			RuleFor(c => c.OrganisationUserName).NotEmpty().WithMessage("Organisation UserName is required");

		}

		#endregion ' Constructor '  
	}
}
