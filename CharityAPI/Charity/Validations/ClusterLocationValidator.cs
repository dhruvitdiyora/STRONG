using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.IServices;
using CharityAPI.Models;
using FluentValidation;

namespace CharityAPI.Validations
{
    public class ClusterLocationValidator : AbstractValidator<ClusterLocations>
    {
        

		#region ' Constructor '

		public ClusterLocationValidator()
		{

			RuleFor(c => c.PostId).NotEmpty().WithMessage("Post is not Selected");

			RuleFor(c => c.RequirementTypeId).NotEmpty().WithMessage("RequirementType is not Selected");

			RuleFor(c => c.ClusterDetails).NotEmpty().WithMessage("Cluster Details is  not provided");

			RuleFor(c => c.CityId).NotEmpty().WithMessage("City is not Selected");

			RuleFor(c => c.StateId).NotEmpty().WithMessage("state is not Selected");

			RuleFor(c => c.PeopleCount).NotEmpty().WithMessage("People count is not provided");

			RuleFor(c => c.PincodeId).NotEmpty().WithMessage("Pincode is not Selected");
		}

		#endregion ' Constructor '  
	}
}
