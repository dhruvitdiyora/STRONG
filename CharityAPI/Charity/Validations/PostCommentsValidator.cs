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
    public class PostCommentsValidator : AbstractValidator<PostComments>
    {
        #region ' Constructor '
        public PostCommentsValidator()
        {
            RuleFor(c => c.Comment).NotEmpty().WithMessage("Please enter comment!");
        }
        #endregion ' Constructor ' 

    }
}
