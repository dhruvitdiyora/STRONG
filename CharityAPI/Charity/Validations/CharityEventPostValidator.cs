using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class CharityEventPostValidator : AbstractValidator<CharityEventPost>
    {
		
		#region ' Constructor '

		public CharityEventPostValidator()
		{
			RuleFor(c => c.EventId).NotEmpty().WithMessage("EventId is required");

			RuleFor(c => c.UserId).NotEmpty().WithMessage("UserId is required");

			//RuleFor(c => c.PostUrl).NotEmpty().WithMessage("Image is Required");
		}
		#endregion ' Constructor '
	}
}
