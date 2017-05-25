using System.Collections.Generic;

namespace Project.AST
{
    public class ClassDeclaration : Node
    {
        private List<Modifier> _classModifiers;
        private string _className;
        private List<MethodDeclaration> _methodDeclarations;
        public string CompilationName { get; set; }

        public ClassDeclaration(List<Modifier> classModifiers, string className, List<MethodDeclaration> methodDeclaration)
        {
            _classModifiers = classModifiers;
            _className = className;
            _methodDeclarations = methodDeclaration;
        }

        public override void Dump(int indent)
        {
            if (_classModifiers.Count > 0)
            {
                Label(indent, "Modifier(s)\n");
                foreach (var classModifier in _classModifiers)
                {
                    Label(indent + 1, $"{classModifier}\n");
                }
            }
            Label(indent, $"Class Name: {_className}\n");

            if (_methodDeclarations.Count > 0)
                foreach (var methodDeclaration in _methodDeclarations)
                {
                    methodDeclaration.Dump(indent, "Method Declaration");
                }
        }

        public override void ResolveNames(LexicalScope scope)
        {
            foreach (var methodDeclaration in _methodDeclarations)
            {
                methodDeclaration.ResolveNames(scope);
            }
        }

        public override void TypeCheck()
        {
            foreach (var methodDeclaration in _methodDeclarations)
            {
                methodDeclaration.TypeCheck();
            }
        }

        public override void GenCode(string file)
        {
            Emit(file, ".class {0} {{", CompilationName + "." + _className);
            foreach (var methodDeclaration in _methodDeclarations)
            {
                methodDeclaration.GenCode(file);
            }
        }
    }
}
