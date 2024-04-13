using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.Models;

namespace CharityAPI.IServices
{
    public interface IPostImages : IGenericInterface<PostImages>
    {
        public IEnumerable GetByUserId(long id);
        public PostImages GetByPostId(long id);
        public IEnumerable GetByUserName(string name);
    }
}
