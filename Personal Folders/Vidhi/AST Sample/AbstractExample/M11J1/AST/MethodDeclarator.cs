using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    public class MethodDeclarator : Node
    {
        /*
         * MethodDeclarator:
         * Identifier ( [FormalParameterList] ) [Dims]
         */

        private string _identifier;
        private List<FormalParameter> _formalParameters;
        public MethodDeclarator(string identifier, List<FormalParameter> formalParameters)
        {
            this._identifier = identifier;
            this._formalParameters = formalParameters;
        }
   }
}
