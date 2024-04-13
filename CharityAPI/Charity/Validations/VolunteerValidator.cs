using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class VolunteerValidator : AbstractValidator<Volunteer>
    {
		
		#region ' Constructor '

		public VolunteerValidator()
		{
			RuleFor(c => c.VolunteerUserId).NotEmpty().WithMessage("VolunteerUserId is required");

			RuleFor(c => c.OrganisationId).NotEmpty().WithMessage("OrganisationId is required");
		}

		#endregion ' Constructor '
	}
}
