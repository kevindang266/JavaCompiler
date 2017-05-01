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

        public override void ResolveNames(LexicalScope scope)
        {
            _classDeclaration.ResolveNames(scope);
        }

        public override void TypeCheck()
        {
            _classDeclaration.TypeCheck();
        }
    }
}
