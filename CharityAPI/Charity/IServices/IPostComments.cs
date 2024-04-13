using CharityAPI.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.IServices
{
    public interface IPostComments: IGenericInterface<PostComments>
    {
        public IEnumerable GetByUserName(string name);
        public IEnumerable GetByUserId(long id);
        public IEnumerable GetByPostId(long id);
    }
}
