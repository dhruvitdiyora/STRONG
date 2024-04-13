using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Threading.Tasks;
using CharityAPI.Models;

namespace CharityAPI.IServices
{
    public interface IUserData : IGenericInterface<UserData>
    {
        public bool Create(UserData user, Image file, string fileName);
        //public bool Update(long id, UserData user, Image file);
        public UserData GetByUserName(string name);
        public UserData GetByUsersId(long id);
        public UserData GetByUserId(long id);
        public Users GetUserInfoByUser(string name);
        public UserData GetDetailsByUserName(string name);  
        public IEnumerable GetByCityId(long id);
        public IEnumerable GetByCityName(string name);
        public IEnumerable GetByStateId(long id);
        public IEnumerable GetByPincode(long pincode);
        public UserData GetByEmailId(string email);
        public UserData GetByContactNo(string mob);

    }
}
