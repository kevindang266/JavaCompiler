namespace M11J1.AST
{
    public class CompilationUnit : Node
    {
        private ClassDeclaration _classDeclaration;

        public CompilationUnit (ClassDeclaration classDeclaration)
        {
            _classDeclaration = classDeclaration;
        }

        public override void Dump(int indent)
        {
            Label(indent, "Compilation Unit\n");
            _classDeclaration.Dump(indent, "Class Declaration");
        }

        public override bool ResolveNames(LexicalScope scope)
        {
            return _classDeclaration.ResolveNames(scope);
        }
    }
}
