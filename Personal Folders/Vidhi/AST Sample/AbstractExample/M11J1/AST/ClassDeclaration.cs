using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    public class ClassDeclaration : Node
    {
        private List<ClassModifier> _classModifiers;
        private string _className;
        private List<MethodDeclaration> _methodDeclaration;

        public ClassDeclaration(List<ClassModifier> classModifiers, string className, List<MethodDeclaration> methodDeclaration)
        {
            this._classModifiers = classModifiers;
            this._className = className;
            this._methodDeclaration = methodDeclaration;
        }
    }
}
