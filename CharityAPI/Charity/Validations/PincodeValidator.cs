using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using CharityAPI.Services;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class PincodeValidator : AbstractValidator<Pincode>
    {
        

		#region ' Constructor '

		public PincodeValidator()
		{
			RuleFor(c => c.Pincode1).NotEmpty().WithMessage("Please provide Pincode!").GreaterThan(100000).WithMessage("Pincode must be 6 digit long").LessThan(1000000).WithMessage("Pincode must be 6 digit long");

			RuleFor(c => c.CityId).NotEmpty().WithMessage("City is not Seleted");

			RuleFor(c => c.StateId).NotEmpty().WithMessage("State is not Seleted");
		}

		#endregion ' Constructor '  
	}
}
