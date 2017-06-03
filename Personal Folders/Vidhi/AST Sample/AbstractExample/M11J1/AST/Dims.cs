using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    public class Dims : Node
    {
        char _lSquareBracket;
        char _rSquareBracket;

        public Dims(char lSquareBracket , char rSquareBracket)
        {
            this._lSquareBracket = lSquareBracket;
            this._rSquareBracket = rSquareBracket;
        }
   }
}
