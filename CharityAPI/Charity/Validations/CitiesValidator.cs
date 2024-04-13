using CharityAPI.IServices;
using CharityAPI.Models;
using CharityAPI.Services;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.Validations
{
    public class CitiesValidator : AbstractValidator<Cities>
    {
		private readonly ICities _cities;
		#region ' Constructor '

		public CitiesValidator()
		{
			RuleFor(c => c.CityName).NotEmpty().WithMessage("Please provide City Name!");
			RuleFor(c => c.CityName).Length(0,100).WithMessage("Please provide City Name!");

			RuleFor(c => c.StateId).NotEmpty().WithMessage("State is not Seleted");
			RuleFor(c => c.StateId).GreaterThan(0).WithMessage("State is not Seleted");
			RuleFor(c => c.StateId).LessThan(999999).WithMessage("State is not Seleted");
			//RuleFor(c => c.StateId).Mac(0, 10).WithMessage("State is not Seleted");


			
		}

		#endregion ' Constructor '  
		#region 'Public Methods'
		public CustomResponse IsNameDuplicate(Cities model)
		{
			var Error = new CustomResponse();
			var city = _cities.GetCityByCityName(model.CityName);
			if(city!=null)
            {
				Error.Errors.Add("City Name Already Exist");
			}
			return Error;
		}
		#endregion 'Public Methods'
	}
}
