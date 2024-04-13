using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class SpamValidator : AbstractValidator<Spam>
    {
        

		#region ' Constructor '

		public SpamValidator()
		{
			RuleFor(c => c.PostId).NotEmpty().WithMessage("Post is not Selected");

			RuleFor(c => c.UserId).NotEmpty().WithMessage("User is not Seleted");
		}

		#endregion ' Constructor '  
	}
}
