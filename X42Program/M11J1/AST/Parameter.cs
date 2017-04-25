using System.Collections.Generic;

namespace M11J1.AST
{
    public abstract class Parameter : Node
    {
    }
    public class FormalParameter : Parameter
    {
        private List<Modifier> _modifiers;
        private Type _type;
        private VariableDeclaration _variableDeclaration;

        public FormalParameter(List<Modifier> modifiers, VariableDeclaration variableDeclaration)
        {
            _modifiers = modifiers;
            _variableDeclaration = variableDeclaration;
        }

        public override void Dump(int indent)
        {
            if (_modifiers.Count > 0)
            {
                Label(indent + 1, "Modifier(s)\n");
                foreach (var modifier in _modifiers)
                {
                    Label(indent + 2, $"{modifier}\n");
                }
            }
            _variableDeclaration.Dump(indent + 1);
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            return true;
        }
    }
}
