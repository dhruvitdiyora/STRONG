using CharityAPI.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CharityAPI.IServices
{
    public interface ICities: IGenericInterface<Cities>
    {
        public Cities GetCityByCityName(string cname);

        public IEnumerable GetCityByStateId(long sid);
        
    }
}
