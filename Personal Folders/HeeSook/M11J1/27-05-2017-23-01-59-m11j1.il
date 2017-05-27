.assembly Test {}
.class Test.HelloWorld {
.method  public static 
void 
main (string[] args) {
.entrypoint
.locals init ([0] int32 x)
.locals init ([1] int32 y)
.locals init ([2] int32 k)
ldc.i4 42
stloc 0
pop
ldc.i4 53
stloc 1
pop
ldloc 0
ldc.i4 3
clt
brfalse L0
ldloc 0
ldc.i4 42
add
stloc 1
pop
L0:
ldloc 0
ldc.i4 3
glt
brfalse L1
.locals init ([3] int32 x)
ldc.i4 3
stloc 3
pop
L1:
.locals init ([4] int32 x)
ldc.i4 4
stloc 4
pop
ret
}
}
