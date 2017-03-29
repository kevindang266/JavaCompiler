using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    class ClassModifier : Node
    {
        private string Class_ModifierName;
        public ClassModifier(string ClassModifierName)
        {
            switch (ClassModifierName)
            {
                case "public":
                    this.Class_ModifierName = ClassModifierName;
                    break;
                case "protected":
                    this.Class_ModifierName = ClassModifierName;
                    break;
                case "private":
                    this.Class_ModifierName = ClassModifierName;
                    break;
            }
        }
    }
}
