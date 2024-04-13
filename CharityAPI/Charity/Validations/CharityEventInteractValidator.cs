using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class CharityEventInteractValidator : AbstractValidator<CharityEventInteract>
    {
		#region ' Constructor '

		public CharityEventInteractValidator()
		{
			RuleFor(c => c.EventId).NotEmpty().WithMessage("EventId is required");

			RuleFor(c => c.UserId).NotEmpty().WithMessage("UserId is required");
			
		}
		#endregion ' Constructor ' 
	}
}
