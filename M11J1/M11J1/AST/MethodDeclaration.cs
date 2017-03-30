using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace M11J1.AST
{
    class MethodDeclaration : Node
    {
        /* 
         * MethodDeclaration:
         * {MethodModifier} MethodHeader MethodBody 
        */
        private MethodModifier[] _methodModifier;
        private String _stringMethodModifier;
        private MethodHeader _methodHeader;
        private MethodBody _methodBody;
        public MethodDeclaration(String methodModifier, MethodHeader methodHeader, MethodBody methodBody)
        {
            this._stringMethodModifier = methodModifier;
            this._methodHeader = methodHeader;
            this._methodBody = methodBody;
        }

        public MethodDeclaration(MethodModifier[] methodModifier, MethodHeader methodHeader , MethodBody methodBody)
        {
            this._methodModifier = methodModifier;
            this._methodHeader = methodHeader;
            this._methodBody = methodBody;
         }
    }
}
