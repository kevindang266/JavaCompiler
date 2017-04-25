using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
            this._parentScope = scope;
        }

        public IDeclaration ResolveHere(string symbol)
        {
            return SymbolTable.FirstOrDefault(x => x.Key == symbol).Value;
        }

        public IDeclaration Resolve(string symbol)
        {
            IDeclaration local = ResolveHere(symbol);
            if (local != null)
                return local;
            else if (_parentScope != null)
                return _parentScope.Resolve(symbol);
            else
                return null;
        }
    }
}
