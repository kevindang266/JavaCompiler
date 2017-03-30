using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    class MethodDeclarator : Node
    {
        /*
         * MethodDeclarator:
         * Identifier ( [FormalParameterList] ) [Dims]
         */

        private Identifier _identifier;
        private FormalParameterList _formalParameterList;
        private DimsOpt _dimOpt;
        public MethodDeclarator(Identifier identifier, FormalParameterList formalParameterList, DimsOpt dimOpt)
        {
            this._identifier = identifier;
            this._formalParameterList = formalParameterList;
            this._dimOpt = dimOpt;
        }


   }
}
