using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
   public class ClassDeclaration : Node
    {
        
        /* NormalClassDeclaration:
        {ClassModifier} class Identifier [TypeParameters] [Superclass] [Superinterfaces] ClassBody */

        private ClassModifier _classModifier;
        private string _className;
    
        public ClassDeclaration( ClassModifier classModifier, string className)
        {
            this._classModifier = classModifier;
            this._className = className;
            
        }
    }
}
