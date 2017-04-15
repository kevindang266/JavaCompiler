using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    public class CompilationUnit : Node
    {
        private string _packageName;
        private ClassDeclaration _classDeclaration;

        public CompilationUnit (string packageName, ClassDeclaration classDeclaration)
        {
            this._packageName = packageName;
            this._classDeclaration = classDeclaration;
        }
    }
}
