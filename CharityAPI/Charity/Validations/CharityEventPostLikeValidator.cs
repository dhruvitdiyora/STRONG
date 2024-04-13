using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class CharityEventPostLikeValidator : AbstractValidator<CharityEventPostLike>
    {
		
		#region ' Constructor '

		public CharityEventPostLikeValidator()
		{
			RuleFor(c => c.CharityEventPostId).NotEmpty().WithMessage("CharityEventPostId is required");

			RuleFor(c => c.UserId).NotEmpty().WithMessage("UserId is required");
		}

		#endregion ' Constructor ' 
	}
}
