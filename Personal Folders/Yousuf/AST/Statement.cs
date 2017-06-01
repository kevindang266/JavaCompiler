using System;
using System.Collections.Generic;
using System.IO;
namespace M11J1.AST { 
    public abstract class Statement : Node
    {
        public abstract void gencode(StreamWriter codewriter);
    }
    public class IfStatement : Statement
    {
        private Expression cond;
        private Statement thenStmt, elseStmt;

        public IfStatement(Expression cond, Statement thenStmt, Statement elseStmt)
        {
            this.cond = cond;
            this.thenStmt = thenStmt;
            this.elseStmt = elseStmt;
        }

        public override void dump(int indent)
        {
            label(indent, "IfStatement\n");
            cond.dump(indent + 1, "cond");
            thenStmt.dump(indent + 1, "then");
            elseStmt.dump(indent + 1, "else");
        }

        public override void gencode(StreamWriter codewriter)
        {
            throw new NotImplementedException();
        }
    };

   

    public class VariableDeclaration : Statement
    {
        private Type type;
        private char name;
        public VariableDeclaration(Type type, char name)
        {
            this.type = type;
            this.name = name;
        }
        public override void dump(int indent)
        {
            label(indent, "VariableDeclaration {0}\n", name);
            type.dump(indent + 1);
        }

        public override void gencode(StreamWriter codewriter)
        {
            throw new NotImplementedException();
        }
    };
    public class VariableDeclarationList : Statement
    {
        private Type type;
        List<VariableDeclarator> name;
        public VariableDeclarationList(Type type, List<VariableDeclarator> name)
        {
            this.type = type;
            this.name = name;
        }
        public override void dump(int indent)
        {
            label(indent, "VariableDeclarationList {0}\n", name);
            foreach (var child in name)
                child.dump(indent + 1);
        }

        public override void gencode(StreamWriter codewriter)
        {
            throw new NotImplementedException();
        }
    };
    public class ExpressionStatement : Statement
    {
        private Expression expr;

        public ExpressionStatement(Expression expr)
        {
            this.expr = expr;
        }

        public override void dump(int indent)
        {
            label(indent, "ExpressionStatement\n");
            expr.dump(indent);
        }

        public override void gencode(StreamWriter codewriter)
        {
            expr.gencode(codewriter);
        }
    };
    public class CompoundStatement : Statement
    {
        private List<Statement> stmts;

        public CompoundStatement(List<Statement> stmts)
        {
            this.stmts = stmts;
        }

        public override void dump(int indent)
        {
            label(indent, "CompoundStatement\n");
            foreach (var child in stmts)
                child.dump(indent);
        }

        public override void gencode(StreamWriter codewriter)
        {
            foreach (var child in stmts)
                child.gencode(codewriter);
        }
    };
    public class VariableDeclarationStatement : Statement
    {
        private Type type;
        private IdentifierExpression name;
        private NumberExpression value;

        public VariableDeclarationStatement(Type type, IdentifierExpression name, NumberExpression value)
        {
            this.type = type;
            this.name = name;
            this.value = value;
        }

        public override void dump(int indent)
        {
            label(indent + 1, "VariableDeclarationStatement\n");
            type.dump(indent + 2);
            name.dump(indent + 2);
            value.dump(indent + 2);
        }

        public override void gencode(StreamWriter codewriter)
        {
            throw new NotImplementedException();
        }
    };
    public class IfThenElseStatement : Statement
    {
        private Expression cond;
        private Statement thenStmt, elseStmt;

        public IfThenElseStatement(Expression cond, Statement thenStmt, Statement elseStmt)
        {
            this.cond = cond;
            this.thenStmt = thenStmt;
            this.elseStmt = elseStmt;
        }

        public override void dump(int indent)
        {
            label(indent, "IfThenElseStatement\n");
            cond.dump(indent + 1, "cond");
            thenStmt.dump(indent + 1, "then");
            elseStmt.dump(indent + 1, "else");
        }

        public override void gencode(StreamWriter codewriter)
        {
            throw new NotImplementedException();
        }
    };
 }
