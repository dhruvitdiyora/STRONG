using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class CharityEventOrganiserValidator : AbstractValidator<CharityEventOrganiser>
    {
		
		#region ' Constructor '

		public CharityEventOrganiserValidator()
		{
			RuleFor(c => c.EventOrganiserId).NotEmpty().WithMessage("OrganiserId is required");

			RuleFor(c => c.EventId).NotEmpty().WithMessage("EventId is required");
			
		}

		#endregion ' Constructor '
	}
}
