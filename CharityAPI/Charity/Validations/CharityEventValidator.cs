using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class CharityEventValidator : AbstractValidator<CharityEvent>
    {

		#region ' Constructor '

		public CharityEventValidator()
		{
			RuleFor(c => c.EventName).NotEmpty().WithMessage("Please provide Event Name!");

			RuleFor(c => c.EventDescription).NotEmpty().WithMessage("Please provide Event Description!");

			RuleFor(c => c.EventOrganiserId).NotEmpty().WithMessage("EventOrganiserId is not selected");

			RuleFor(c => c.EventStartDate).NotEmpty().WithMessage("EventStartDate is not selected");

			//RuleFor(c => c.EventBannerUrl).NotEmpty().WithMessage("EventBannerURL is required");

			RuleFor(c => c.EventEndDate).NotEmpty().WithMessage("EventEndDate is not selected")
			.GreaterThan(c => c.EventStartDate).WithMessage("End date must after Start date");
            
            RuleFor(c => c.EventType).NotEmpty().WithMessage("EventType is not selected");

			RuleFor(c => c.PincodeId).NotEmpty().WithMessage("PincodeId is not selected");
		}

		#endregion ' Constructor '  
	}
}
