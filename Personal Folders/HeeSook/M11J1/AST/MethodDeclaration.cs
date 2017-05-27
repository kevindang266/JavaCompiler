using System.Collections.Generic;

namespace M11J1.AST
{
    public class MethodDeclaration : Node
    {
        private List<Modifier> _methodModifiers;
        private MethodHeader _header;
        private CompoundStatement _statements;

        public MethodDeclaration(List<Modifier> methodModifiers, MethodHeader header, CompoundStatement statements)
        {
            _methodModifiers = methodModifiers;
            _header = header;
            _statements = statements;
        }

        public override void Dump(int indent)
        {
            if (_methodModifiers.Count > 0)
            {
                Label(indent, "Modifier(s)\n");
                foreach (var methodModifier in _methodModifiers)
                {
                    Label(indent + 1, $"{methodModifier}\n");
                }
            }
            _header.Dump(indent, "Method Header");
            Label(indent, "MethodBody\n");
            _statements.Dump(indent + 1);
        }

        public override void ResolveNames(LexicalScope scope)
        {
            _header.ResolveNames(scope);
            _statements.SetGlobalParameter(_header);
            _statements.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _header.TypeCheck();
            _statements.TypeCheck();
        }

        public override void GenCode(string file)
        {
            string modifier = string.Empty;
            foreach (var methodModifier in _methodModifiers)
            {
                modifier += " " + methodModifier.ToString().ToLower();
            }
            Emit(file, ".method {0} ", modifier);
            _header.GenCode(file);
            _statements.GenCode(file);
        }
    }

    public class MethodHeader : Node
    {
        private Type _result;
        private MethodDeclarator _methodDeclarator;

        public MethodHeader(Type result, MethodDeclarator methodDeclarator)
        {
            _result = result;
            _methodDeclarator = methodDeclarator;
        }

        public override void Dump(int indent)
        {
            _result.Dump(indent, "type");
            _methodDeclarator.Dump(indent, "Method Declarator");
        }

        public MethodDeclarator GetMethodDeclarator()
        {
            return _methodDeclarator;
        }

        public override void ResolveNames(LexicalScope scope)
        {
            _result.ResolveNames(scope);
            _methodDeclarator.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _methodDeclarator.TypeCheck();
        }

        public override void GenCode(string file)
        {
            Emit(file, "{0} ", _result.CLRName());
            _methodDeclarator.GenCode(file);
        }
    }

    public class MethodDeclarator : Node
    {
        private string _methodName;
        private List<Parameter> _parameters;

        public MethodDeclarator(string methodName, List<Parameter> parameters)
        {
            _methodName = methodName;
            _parameters = parameters;
        }

        public override void Dump(int indent)
        {
            Label(indent, $"Method Name: {_methodName}\n");
            if (_parameters.Count > 0)
            {
                Label(indent, "Parameter(s)\n");
                foreach (var parameter in _parameters)
                {
                    parameter.Dump(indent + 1);
                }
            }
        }

        public List<Parameter> GetParameters()
        {
            return _parameters;
        }

        public override void ResolveNames(LexicalScope scope)
        {
            foreach (var parameter in _parameters)
            {
                parameter.ResolveNames(scope);
            }

        }

        public override void TypeCheck()
        {
            foreach (var parameter in _parameters)
            {
                parameter.TypeCheck();
            }
        }

        public override void GenCode(string file)
        {
            Emit(file, "{0} (string[] args) {{", _methodName);
            Emit(file, ".entrypoint");
        }
    }
}