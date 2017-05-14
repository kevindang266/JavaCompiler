// This code was generated by the Gardens Point Parser Generator
// Copyright (c) Wayne Kelly, John Gough, QUT 2005-2014
// (see accompanying GPPGcopyright.rtf)

// GPPG version 1.5.2
// Machine:  LAPTOP-D82G4GJQ
// DateTime: 12/05/2017 11:54:50 PM
// UserName: Tarandeep
// Input file <taran1.y - 12/05/2017 11:53:13 PM>

// options: lines diagnose & report gplex

using System;
using System.Collections.Generic;
using System.CodeDom.Compiler;
using System.Globalization;
using System.Text;
using QUT.Gppg;

namespace Yfile
{
public enum Tokens {
    error=127,EOF=128,Number=129,Identifier=130,Abstract=131,Assert=132,
    Boolean=133,Break=134,Byte=135,Case=136,Catch=137,Char=138,
    Class=139,Const=140,Continue=141,Default=142,Do=143,Double=144,
    Else=145,Enum=146,Extends=147,Final=148,Finally=149,Float=150,
    For=151,Goto=152,If=153,Implements=154,Import=155,Instanceof=156,
    Int=157,Interface=158,Long=159,Native=160,New=161,Package=162,
    Private=163,Protected=164,Public=165,Return=166,Short=167,Static=168,
    Strictfp=169,Super=170,Switch=171,Synchronized=172,This=173,Throw=174,
    Throws=175,Transient=176,Try=177,Void=178,Volatile=179,While=180,
    BooleanLiteral=181,NullLiteral=182,IntegerLiteral=183,CharacterLiteral=184,StringLiteral=185,FloatingPointLiteral=186,
    VariableArguments=187,DoubleColon=188,Selection=189,Equal=190,GreaterOrEqual=191,LessOrEqual=192,
    NotEqual=193,AndCondition=194,OrCondition=195,Increment=196,Decrement=197,SignedLeftShift=198,
    SignedRightShift=199,UnsignedRightShift=200,AddAnd=201,SubtractAnd=202,MultiplyAnd=203,DivideAnd=204,
    BitwiseAnd=205,BitwiseInclusiveOr=206,BitwiseExclusiveOr=207,ModulusAnd=208,LeftShiftAnd=209,RightShiftAnd=210,
    ShiftRightZeroFill=211};

public struct ValueType
#line 3 "taran1.y"
{
    public int num;
    public string name;
}
#line default
// Abstract base class for GPLEX scanners
[GeneratedCodeAttribute( "Gardens Point Parser Generator", "1.5.2")]
public abstract class ScanBase : AbstractScanner<ValueType,LexLocation> {
  private LexLocation __yylloc = new LexLocation();
  public override LexLocation yylloc { get { return __yylloc; } set { __yylloc = value; } }
  protected virtual bool yywrap() { return true; }
}

// Utility class for encapsulating token information
[GeneratedCodeAttribute( "Gardens Point Parser Generator", "1.5.2")]
public class ScanObj {
  public int token;
  public ValueType yylval;
  public LexLocation yylloc;
  public ScanObj( int t, ValueType val, LexLocation loc ) {
    this.token = t; this.yylval = val; this.yylloc = loc;
  }
}

[GeneratedCodeAttribute( "Gardens Point Parser Generator", "1.5.2")]
public class Parser: ShiftReduceParser<ValueType, LexLocation>
{
#pragma warning disable 649
  private static Dictionary<int, string> aliases;
#pragma warning restore 649
  private static Rule[] rules = new Rule[100];
  private static State[] states = new State[135];
  private static string[] nonTerms = new string[] {
      "CompilationUnit", "$accept", "ClassDeclaration", "NormalClassDeclaration", 
      "Modifiers", "ClassBody", "ClassBodyDeclarations", "ClassBodyDeclaration", 
      "ClassMemberDeclaration", "MethodDeclaration", "MethodHeader", "MethodBody", 
      "Result", "MethodDeclarator", "Block", "Modifier", "UnannType", "FormalParameterList", 
      "Dims_opt", "FormalParameter", "VariableDeclaratorId", "BlockStatements", 
      "BlockStatement", "LocalVariableDeclarationStatement", "Statement", "LocalVariableDeclaration", 
      "VariableDeclaratorList", "VariableModifiers", "UnannPrimitiveType", "UnannReferenceType", 
      "NumericType", "IntegralType", "FloatingPointType", "UnannArrayType", "UnannTypeVariable", 
      "Dims", "VariableDeclarator", "VariableDeclarators", "VariableInitializer", 
      "Expression", "StatementWithoutTrailingSubstatement", "LabeledStatement", 
      "IfThenStatement", "IfThenElseStatement", "StatementNoShortIf", "LabeledStatementNoShortIf", 
      "IfThenElseStatementNoShortIf", "EmptyStatement", "ExpressionStatement", 
      "StatementExpression", "Assignment", "AssignmentExpression", "LeftHandSide", 
      "AssignmentOperator", "ExpressionName", "Literal", "TypeName", "PackageOrTypeName", 
      "MethodName", "PackageName", "AmbiguousName", };

  static Parser() {
    states[0] = new State(-16,new int[]{-1,1,-3,3,-4,4,-5,5});
    states[1] = new State(new int[]{128,2});
    states[2] = new State(-1);
    states[3] = new State(-2);
    states[4] = new State(-3);
    states[5] = new State(new int[]{139,6,165,112,164,113,148,114,168,115},new int[]{-16,120});
    states[6] = new State(new int[]{130,7});
    states[7] = new State(new int[]{123,9},new int[]{-6,8});
    states[8] = new State(-4);
    states[9] = new State(-6,new int[]{-7,10});
    states[10] = new State(new int[]{125,11,59,134,178,-16,157,-16,159,-16,138,-16,135,-16,167,-16,150,-16,144,-16,133,-16,130,-16,165,-16,164,-16,148,-16,168,-16},new int[]{-8,12,-9,13,-10,14,-5,15});
    states[11] = new State(-5);
    states[12] = new State(-7);
    states[13] = new State(-8);
    states[14] = new State(-9);
    states[15] = new State(new int[]{178,132,157,58,159,59,138,60,135,61,167,62,150,64,144,65,133,66,130,111,165,112,164,113,148,114,168,115},new int[]{-11,16,-16,120,-13,121,-17,133,-29,55,-31,56,-32,57,-33,63,-30,67,-34,68,-35,69});
    states[16] = new State(new int[]{123,19,59,119},new int[]{-12,17,-15,18});
    states[17] = new State(-11);
    states[18] = new State(-13);
    states[19] = new State(new int[]{157,58,159,59,138,60,135,61,167,62,150,64,144,65,133,66,130,71,165,112,164,113,148,114,168,115,123,19,59,77,153,85},new int[]{-22,20,-23,118,-24,23,-26,24,-17,26,-29,55,-31,56,-32,57,-33,63,-30,67,-34,68,-35,69,-28,107,-16,116,-25,117,-41,74,-15,75,-48,76,-49,78,-50,79,-51,81,-53,39,-55,42,-42,83,-43,84,-44,93});
    states[20] = new State(new int[]{125,21,157,58,159,59,138,60,135,61,167,62,150,64,144,65,133,66,130,71,165,112,164,113,148,114,168,115,123,19,59,77,153,85},new int[]{-23,22,-24,23,-26,24,-17,26,-29,55,-31,56,-32,57,-33,63,-30,67,-34,68,-35,69,-28,107,-16,116,-25,117,-41,74,-15,75,-48,76,-49,78,-50,79,-51,81,-53,39,-55,42,-42,83,-43,84,-44,93});
    states[21] = new State(-27);
    states[22] = new State(-29);
    states[23] = new State(-30);
    states[24] = new State(new int[]{59,25});
    states[25] = new State(-32);
    states[26] = new State(new int[]{130,48},new int[]{-27,27,-37,28,-21,33});
    states[27] = new State(-33);
    states[28] = new State(new int[]{44,29});
    states[29] = new State(new int[]{130,48},new int[]{-38,30,-37,54,-21,33});
    states[30] = new State(new int[]{44,31,59,-53});
    states[31] = new State(new int[]{130,48},new int[]{-37,32,-21,33});
    states[32] = new State(-55);
    states[33] = new State(new int[]{61,34,44,-56,59,-56});
    states[34] = new State(new int[]{130,43,183,45},new int[]{-39,35,-40,36,-52,37,-51,38,-53,39,-55,42,-56,44});
    states[35] = new State(-57);
    states[36] = new State(-63);
    states[37] = new State(-82);
    states[38] = new State(-87);
    states[39] = new State(new int[]{61,46,43,47},new int[]{-54,40});
    states[40] = new State(new int[]{130,43,183,45},new int[]{-40,41,-52,37,-51,38,-53,39,-55,42,-56,44});
    states[41] = new State(-83);
    states[42] = new State(-84);
    states[43] = new State(-94);
    states[44] = new State(-88);
    states[45] = new State(-89);
    states[46] = new State(-85);
    states[47] = new State(-86);
    states[48] = new State(new int[]{91,51,61,-59,44,-59,59,-59,41,-59,157,-59,159,-59,138,-59,135,-59,167,-59,150,-59,144,-59,133,-59,130,-59,165,-59,164,-59,148,-59,168,-59},new int[]{-19,49,-36,50});
    states[49] = new State(-58);
    states[50] = new State(-60);
    states[51] = new State(new int[]{93,52});
    states[52] = new State(new int[]{91,51,61,-61,44,-61,59,-61,41,-61,157,-61,159,-61,138,-61,135,-61,167,-61,150,-61,144,-61,133,-61,130,-61,165,-61,164,-61,148,-61,168,-61,123,-61},new int[]{-36,53});
    states[53] = new State(-62);
    states[54] = new State(-54);
    states[55] = new State(-37);
    states[56] = new State(-39);
    states[57] = new State(-41);
    states[58] = new State(-43);
    states[59] = new State(-44);
    states[60] = new State(-45);
    states[61] = new State(-46);
    states[62] = new State(-47);
    states[63] = new State(-42);
    states[64] = new State(-48);
    states[65] = new State(-49);
    states[66] = new State(-40);
    states[67] = new State(-38);
    states[68] = new State(-50);
    states[69] = new State(new int[]{91,51},new int[]{-36,70});
    states[70] = new State(-51);
    states[71] = new State(new int[]{58,72,91,-52,61,-94,43,-94});
    states[72] = new State(new int[]{123,19,59,77,130,82,153,85},new int[]{-25,73,-41,74,-15,75,-48,76,-49,78,-50,79,-51,81,-53,39,-55,42,-42,83,-43,84,-44,93});
    states[73] = new State(-75);
    states[74] = new State(-64);
    states[75] = new State(-71);
    states[76] = new State(-72);
    states[77] = new State(-74);
    states[78] = new State(-73);
    states[79] = new State(new int[]{59,80});
    states[80] = new State(-77);
    states[81] = new State(-78);
    states[82] = new State(new int[]{58,72,61,-94,43,-94});
    states[83] = new State(-65);
    states[84] = new State(-66);
    states[85] = new State(new int[]{40,86});
    states[86] = new State(new int[]{130,43,183,45},new int[]{-40,87,-52,37,-51,38,-53,39,-55,42,-56,44});
    states[87] = new State(new int[]{41,88});
    states[88] = new State(new int[]{123,19,59,77,130,95,153,98},new int[]{-25,89,-45,90,-41,94,-15,75,-48,76,-49,78,-50,79,-51,81,-53,39,-55,42,-42,83,-43,84,-44,93,-46,105,-47,106});
    states[89] = new State(-79);
    states[90] = new State(new int[]{145,91});
    states[91] = new State(new int[]{123,19,59,77,130,82,153,85},new int[]{-25,92,-41,74,-15,75,-48,76,-49,78,-50,79,-51,81,-53,39,-55,42,-42,83,-43,84,-44,93});
    states[92] = new State(-80);
    states[93] = new State(-67);
    states[94] = new State(new int[]{125,-64,157,-64,159,-64,138,-64,135,-64,167,-64,150,-64,144,-64,133,-64,130,-64,165,-64,164,-64,148,-64,168,-64,123,-64,59,-64,153,-64,145,-68});
    states[95] = new State(new int[]{58,96,61,-94,43,-94});
    states[96] = new State(new int[]{123,19,59,77,130,95,153,98},new int[]{-25,73,-45,97,-41,94,-15,75,-48,76,-49,78,-50,79,-51,81,-53,39,-55,42,-42,83,-43,84,-44,93,-46,105,-47,106});
    states[97] = new State(-76);
    states[98] = new State(new int[]{40,99});
    states[99] = new State(new int[]{130,43,183,45},new int[]{-40,100,-52,37,-51,38,-53,39,-55,42,-56,44});
    states[100] = new State(new int[]{41,101});
    states[101] = new State(new int[]{123,19,59,77,130,95,153,98},new int[]{-25,89,-45,102,-41,94,-15,75,-48,76,-49,78,-50,79,-51,81,-53,39,-55,42,-42,83,-43,84,-44,93,-46,105,-47,106});
    states[102] = new State(new int[]{145,103});
    states[103] = new State(new int[]{123,19,59,77,130,95,153,98},new int[]{-25,92,-45,104,-41,94,-15,75,-48,76,-49,78,-50,79,-51,81,-53,39,-55,42,-42,83,-43,84,-44,93,-46,105,-47,106});
    states[104] = new State(-81);
    states[105] = new State(-69);
    states[106] = new State(-70);
    states[107] = new State(new int[]{157,58,159,59,138,60,135,61,167,62,150,64,144,65,133,66,130,111,165,112,164,113,148,114,168,115},new int[]{-17,108,-16,110,-29,55,-31,56,-32,57,-33,63,-30,67,-34,68,-35,69});
    states[108] = new State(new int[]{130,48},new int[]{-27,109,-37,28,-21,33});
    states[109] = new State(-34);
    states[110] = new State(-36);
    states[111] = new State(-52);
    states[112] = new State(-17);
    states[113] = new State(-18);
    states[114] = new State(-19);
    states[115] = new State(-20);
    states[116] = new State(-35);
    states[117] = new State(-31);
    states[118] = new State(-28);
    states[119] = new State(-14);
    states[120] = new State(-15);
    states[121] = new State(new int[]{130,123},new int[]{-14,122});
    states[122] = new State(-12);
    states[123] = new State(new int[]{40,124});
    states[124] = new State(-24,new int[]{-18,125});
    states[125] = new State(new int[]{41,126,157,-16,159,-16,138,-16,135,-16,167,-16,150,-16,144,-16,133,-16,130,-16,165,-16,164,-16,148,-16,168,-16},new int[]{-20,128,-5,129});
    states[126] = new State(new int[]{91,51,123,-59,59,-59},new int[]{-19,127,-36,50});
    states[127] = new State(-23);
    states[128] = new State(-25);
    states[129] = new State(new int[]{157,58,159,59,138,60,135,61,167,62,150,64,144,65,133,66,130,111,165,112,164,113,148,114,168,115},new int[]{-17,130,-16,120,-29,55,-31,56,-32,57,-33,63,-30,67,-34,68,-35,69});
    states[130] = new State(new int[]{130,48},new int[]{-21,131});
    states[131] = new State(-26);
    states[132] = new State(-21);
    states[133] = new State(-22);
    states[134] = new State(-10);

    for (int sNo = 0; sNo < states.Length; sNo++) states[sNo].number = sNo;

    rules[1] = new Rule(-2, new int[]{-1,128});
    rules[2] = new Rule(-1, new int[]{-3});
    rules[3] = new Rule(-3, new int[]{-4});
    rules[4] = new Rule(-4, new int[]{-5,139,130,-6});
    rules[5] = new Rule(-6, new int[]{123,-7,125});
    rules[6] = new Rule(-7, new int[]{});
    rules[7] = new Rule(-7, new int[]{-7,-8});
    rules[8] = new Rule(-8, new int[]{-9});
    rules[9] = new Rule(-9, new int[]{-10});
    rules[10] = new Rule(-9, new int[]{59});
    rules[11] = new Rule(-10, new int[]{-5,-11,-12});
    rules[12] = new Rule(-11, new int[]{-13,-14});
    rules[13] = new Rule(-12, new int[]{-15});
    rules[14] = new Rule(-12, new int[]{59});
    rules[15] = new Rule(-5, new int[]{-5,-16});
    rules[16] = new Rule(-5, new int[]{});
    rules[17] = new Rule(-16, new int[]{165});
    rules[18] = new Rule(-16, new int[]{164});
    rules[19] = new Rule(-16, new int[]{148});
    rules[20] = new Rule(-16, new int[]{168});
    rules[21] = new Rule(-13, new int[]{178});
    rules[22] = new Rule(-13, new int[]{-17});
    rules[23] = new Rule(-14, new int[]{130,40,-18,41,-19});
    rules[24] = new Rule(-18, new int[]{});
    rules[25] = new Rule(-18, new int[]{-18,-20});
    rules[26] = new Rule(-20, new int[]{-5,-17,-21});
    rules[27] = new Rule(-15, new int[]{123,-22,125});
    rules[28] = new Rule(-22, new int[]{-23});
    rules[29] = new Rule(-22, new int[]{-22,-23});
    rules[30] = new Rule(-23, new int[]{-24});
    rules[31] = new Rule(-23, new int[]{-25});
    rules[32] = new Rule(-24, new int[]{-26,59});
    rules[33] = new Rule(-26, new int[]{-17,-27});
    rules[34] = new Rule(-26, new int[]{-28,-17,-27});
    rules[35] = new Rule(-28, new int[]{-16});
    rules[36] = new Rule(-28, new int[]{-28,-16});
    rules[37] = new Rule(-17, new int[]{-29});
    rules[38] = new Rule(-17, new int[]{-30});
    rules[39] = new Rule(-29, new int[]{-31});
    rules[40] = new Rule(-29, new int[]{133});
    rules[41] = new Rule(-31, new int[]{-32});
    rules[42] = new Rule(-31, new int[]{-33});
    rules[43] = new Rule(-32, new int[]{157});
    rules[44] = new Rule(-32, new int[]{159});
    rules[45] = new Rule(-32, new int[]{138});
    rules[46] = new Rule(-32, new int[]{135});
    rules[47] = new Rule(-32, new int[]{167});
    rules[48] = new Rule(-33, new int[]{150});
    rules[49] = new Rule(-33, new int[]{144});
    rules[50] = new Rule(-30, new int[]{-34});
    rules[51] = new Rule(-34, new int[]{-35,-36});
    rules[52] = new Rule(-35, new int[]{130});
    rules[53] = new Rule(-27, new int[]{-37,44,-38});
    rules[54] = new Rule(-38, new int[]{-37});
    rules[55] = new Rule(-38, new int[]{-38,44,-37});
    rules[56] = new Rule(-37, new int[]{-21});
    rules[57] = new Rule(-37, new int[]{-21,61,-39});
    rules[58] = new Rule(-21, new int[]{130,-19});
    rules[59] = new Rule(-19, new int[]{});
    rules[60] = new Rule(-19, new int[]{-36});
    rules[61] = new Rule(-36, new int[]{91,93});
    rules[62] = new Rule(-36, new int[]{91,93,-36});
    rules[63] = new Rule(-39, new int[]{-40});
    rules[64] = new Rule(-25, new int[]{-41});
    rules[65] = new Rule(-25, new int[]{-42});
    rules[66] = new Rule(-25, new int[]{-43});
    rules[67] = new Rule(-25, new int[]{-44});
    rules[68] = new Rule(-45, new int[]{-41});
    rules[69] = new Rule(-45, new int[]{-46});
    rules[70] = new Rule(-45, new int[]{-47});
    rules[71] = new Rule(-41, new int[]{-15});
    rules[72] = new Rule(-41, new int[]{-48});
    rules[73] = new Rule(-41, new int[]{-49});
    rules[74] = new Rule(-48, new int[]{59});
    rules[75] = new Rule(-42, new int[]{130,58,-25});
    rules[76] = new Rule(-46, new int[]{130,58,-45});
    rules[77] = new Rule(-49, new int[]{-50,59});
    rules[78] = new Rule(-50, new int[]{-51});
    rules[79] = new Rule(-43, new int[]{153,40,-40,41,-25});
    rules[80] = new Rule(-44, new int[]{153,40,-40,41,-45,145,-25});
    rules[81] = new Rule(-47, new int[]{153,40,-40,41,-45,145,-45});
    rules[82] = new Rule(-40, new int[]{-52});
    rules[83] = new Rule(-51, new int[]{-53,-54,-40});
    rules[84] = new Rule(-53, new int[]{-55});
    rules[85] = new Rule(-54, new int[]{61});
    rules[86] = new Rule(-54, new int[]{43});
    rules[87] = new Rule(-52, new int[]{-51});
    rules[88] = new Rule(-52, new int[]{-56});
    rules[89] = new Rule(-56, new int[]{183});
    rules[90] = new Rule(-57, new int[]{130});
    rules[91] = new Rule(-57, new int[]{-58,46,130});
    rules[92] = new Rule(-58, new int[]{130});
    rules[93] = new Rule(-58, new int[]{-58,46,130});
    rules[94] = new Rule(-55, new int[]{130});
    rules[95] = new Rule(-59, new int[]{130});
    rules[96] = new Rule(-60, new int[]{130});
    rules[97] = new Rule(-60, new int[]{-60,46,130});
    rules[98] = new Rule(-61, new int[]{130});
    rules[99] = new Rule(-61, new int[]{-61,46,130});
  }

  protected override void Initialize() {
    this.InitSpecialTokens((int)Tokens.error, (int)Tokens.EOF);
    this.InitStates(states);
    this.InitRules(rules);
    this.InitNonTerminals(nonTerms);
  }

  protected override void DoAction(int action)
  {
#pragma warning disable 162, 1522
    switch (action)
    {
    }
#pragma warning restore 162, 1522
  }

  protected override string TerminalToString(int terminal)
  {
    if (aliases != null && aliases.ContainsKey(terminal))
        return aliases[terminal];
    else if (((Tokens)terminal).ToString() != terminal.ToString(CultureInfo.InvariantCulture))
        return ((Tokens)terminal).ToString();
    else
        return CharToString((char)terminal);
  }

#line 333 "taran1.y"

public Parser(Scanner scanner) : base(scanner)
{
}

#line default
}
}