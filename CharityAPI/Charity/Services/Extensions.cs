using CharityAPI.Authentication;
using FluentValidation.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.Services
{
    public static class Extensions
    {
		public static ModelResponse ToCustomResponse(this ValidationResult result)
		{
			var returnData = new ModelResponse();
			if (!result.IsValid)
			{
				foreach (var item in result.Errors)
				{
					returnData.Errors.Add(item.ErrorMessage);
				}
			}
			return returnData;
		}
	}
}
