using System.Collections.Generic;

namespace M11J1.AST
{
    public abstract class Parameter : Node
    {
        public abstract VariableDeclarationList GetVariableDeclaration();
    }
    public class FormalParameter : Parameter
    {
        private List<Modifier> _modifiers;
        private VariableDeclarationList _variableDeclaration;
        public FormalParameter(List<Modifier> modifiers, Type type, string variableDeclaratorId)
        {
            _modifiers = modifiers;
            _variableDeclaration = new VariableDeclarationList(new List<VariableDeclaration>
                () {new VariableDeclaration(type, variableDeclaratorId) });
        }

        public override void Dump(int indent)
        {
            if (_modifiers != null && _modifiers.Count > 0)
            {
                Label(indent, "Modifier(s)\n");
                foreach (var modifier in _modifiers)
                {
                    Label(indent + 1, $"{modifier}\n");
                }
            }
            _variableDeclaration?.Dump(indent);
        }

        public override VariableDeclarationList GetVariableDeclaration()
        {
            return _variableDeclaration;
        }

        public override void ResolveNames(LexicalScope scope)
        {
            _variableDeclaration.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _variableDeclaration.TypeCheck();
        }

        public override void GenCode(string file)
        {
            throw new System.NotImplementedException();
        }
    }
}
