using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class RequirementTypeValidator : AbstractValidator<RequirementType>
    {
		
		#region ' Constructor '

		public RequirementTypeValidator()
		{
			RuleFor(c => c.RequirementTypeName).NotEmpty().WithMessage("Please enter Requirement Type Name!");
		}

		#endregion ' Constructor '  
	}
}
