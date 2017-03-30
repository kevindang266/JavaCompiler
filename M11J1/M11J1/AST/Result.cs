using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    class Result : Node 
    {
        //UnannType :  // To be implemented
        String _result;
        public Result() { }
        public Result(string _result)
        {
            this._result = _result;
        }
    }
}
