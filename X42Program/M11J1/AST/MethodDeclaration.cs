using System;
using System.Collections.Generic;

namespace M11J1.AST
{
    public class MethodDeclaration : Node
    {
        private List<Modifier> _methodModifiers;
        private MethodHeader _header;

        public MethodDeclaration(List<Modifier> methodModifiers, MethodHeader header)
        {
            _methodModifiers = methodModifiers;
            _header = header;
        }

        public override void Dump(int indent)
        {
            if (_methodModifiers.Count > 0)
            {
                Label(indent + 1, "Modifier(s)\n");
                foreach (var methodModifier in _methodModifiers)
                {
                    Label(indent + 2, $"{methodModifier}\n");
                }
            }
            _header.Dump(indent + 1);
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            throw new NotImplementedException();
        }
    }

    public class MethodHeader : Node
    {
        private M11J1.AST.Type _result;
        private MethodDeclarator _methodDeclarator;

        public MethodHeader(M11J1.AST.Type result, MethodDeclarator methodDeclarator)
        {
            _result = result;
            _methodDeclarator = methodDeclarator;
        }

        public override void Dump(int indent)
        {
            Label(indent, $"Type: {_result}\n");
            _methodDeclarator.Dump(indent, "Method Header");
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            throw new NotImplementedException();
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

        public override bool ResolveNames(LexicalScope scope)
        {
            throw new NotImplementedException();
        }
    }
}