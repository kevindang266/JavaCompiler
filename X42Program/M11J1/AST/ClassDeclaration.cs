using System.Collections.Generic;

namespace M11J1.AST
{
    public class ClassDeclaration : Node
    {
        private List<Modifier> _classModifiers;
        private string _className;
        private List<MethodDeclaration> _methodDeclaration;
        public ClassDeclaration(List<Modifier> classModifiers, string className)
        {
            this._classModifiers = classModifiers;
            this._className = className;
        }

        public ClassDeclaration(List<Modifier> classModifiers, string className, List<MethodDeclaration> methodDeclaration)
        {
            this._classModifiers = classModifiers;
            this._className = className;
            this._methodDeclaration = methodDeclaration;
        }

        public override void Dump(int indent)
        {
            if (_classModifiers.Count > 0)
            {
                Label(indent + 1, "Modifier(s)\n");
                foreach (var classModifier in _classModifiers)
                {
                    Label(indent + 2, $"{classModifier}\n");
                }
            }
            Label(indent + 1, $"Class Name: {_className}\n");

            if(_methodDeclaration.Count > 0)
                foreach (var methodDeclaration in _methodDeclaration)
                {
                    methodDeclaration.Dump(indent + 1, "Method Declaration");
                }
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            return true; // haven't handled global variables yet.
        }
    }
}
