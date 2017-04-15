using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace M11J1.AST
{
    public class MethodDeclaration : Node
    {
        private List<MethodModifier> _methodModifiers;
        private MethodHeader _methodHeader;
        private MethodBody _methodBody;

        public MethodDeclaration(List<MethodModifier> methodModifiers, MethodHeader methodHeader, MethodBody methodBody)
        {
            this._methodModifiers = methodModifiers;
            this._methodHeader = methodHeader;
            this._methodBody = methodBody;
         }
    }
}
