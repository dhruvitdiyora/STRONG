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
    public class StatesValidator : AbstractValidator<States>
    {
        

        #region ' Constructor '

		public StatesValidator()
		{
			RuleFor(c => c.StateName).NotEmpty().WithMessage("Please provide State Name!");
		}
        #endregion ' Constructor ' 

        #region 'Public Methods'
        //public CustomResponse IsNameDuplicate(States model)
        //{
        //    var Error = new CustomResponse();
        //    var state = _states.GetStateByStateName(model.StateName);
        //    if (state != null)
        //    {
        //        Error.Errors.Add("State Name Already Exist");
        //    }
        //    return Error;
        //}
        #endregion 'Public Methods'
    }
}
