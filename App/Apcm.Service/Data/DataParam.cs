using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Data
{
    internal class DataParam
    {
        public string Name { get; private set; }
        
        public object Value { get; private set; }

        public DataParam(string name, object value)
        {
            Name = string.Format("@{0}", name.Replace("@", ""));
            Value = value;
        }

        public static DataParam Create(string name, object value)
        {
            return new DataParam(name, value);
        }

    }
}
