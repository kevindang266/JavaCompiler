using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M11J1.AST
{
    public class ClassModifier : Node
    {
        private string _classModifierName;
        public ClassModifier(string classModifierName)
        {
            switch (classModifierName)
            {
                case "public":
                    this._classModifierName = classModifierName;
                    break;
                case "protected":
                    this._classModifierName = classModifierName;
                    break;
                case "private":
                    this._classModifierName = classModifierName;
                    break;
            }
        }
    }
}
