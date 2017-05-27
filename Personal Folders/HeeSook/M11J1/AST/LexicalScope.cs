using System.Collections.Generic;
using System.Linq;

namespace M11J1.AST
{
    public class LexicalScope
    {
        private LexicalScope _parentScope;
        public Dictionary<string, IDeclaration> SymbolTable { get; set; }

        public LexicalScope()
        {
            _parentScope = null;
            SymbolTable = new Dictionary<string, IDeclaration>();
        }

        public void SetParentScope(LexicalScope scope)
        {
            _parentScope = scope;
        }

        public IDeclaration ResolveHere(string symbol)
        {
            return SymbolTable.FirstOrDefault(x => x.Key == symbol).Value;
        }

        public IDeclaration Resolve(string symbol)
        {
            // local can refer to methods that are declared in the Interface
            IDeclaration local = ResolveHere(symbol);
            if (local != null)
                return local;   // return VariableDeclaration object if it can be found in current scope
            /*
             * If VariableDeclaration object cannot be found in current scope
             * then try to look for variable object in parent scope
             * Return null if the variable object cannot be found
             */ 
            return _parentScope?.Resolve(symbol);
        }
    }
}
