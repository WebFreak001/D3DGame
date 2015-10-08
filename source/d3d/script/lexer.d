module d3d.script.lexer;

import std.regex;
import std.conv;

enum TokenType
{
	// Any unquoted string
	Identifier = 0, // has Regex
	// public, private, etc
	Attribute, // has Regex
	// @
	CustomAttribute, // has Regex

	// "abc"
	// -415
	// 0x84B
	// 0b10001101
	// 0.5165
	// -0.452f
	// true false on off yes no
	StringValue, // has Function
	NumberValue, // has Regex
	HexNumberValue, // has Regex
	BinaryNumberValue, // has Regex
	FloatingValue, // has Regex
	True, False, // has Regex

	// : ;
	Colon, // has Regex
	Semicolon, // has Regex
	Whitespace, // has Regex

	// {} [] ()
	CurlyBraceOpen, // has Regex
	CurlyBraceClose, // has Regex
	SquareBracketOpen, // has Regex
	SquareBracketClose, // has Regex
	ParenthesesOpen, // has Regex
	ParenthesesClose, // has Regex

	// Comparision Operators
	// <   >   <=  >=  ==  !=  is  has in
	OpLT, // has Regex
	OpGT, // has Regex
	OpLE, // has Regex
	OpGE, // has Regex
	OpEqual, // has Regex
	OpNotEqual, // has Regex
	OpIs, // has Regex
	OpHas, // has Regex
	OpIn, // has Regex
	// Other Operators
	// <<  >>  <<= >>= >>> >>>=
	OpShiftLeft, // has Regex
	OpShiftRight, // has Regex
	OpShiftLeftAss, // has Regex
	OpShiftRightAss, // has Regex
	OpUShiftRight, // has Regex
	OpUShiftRightAss, // has Regex
	// +   -   +=  -=  *   /   %   ^^  *=  /=  %=  ^^=
	OpAdd, // has Regex
	OpSub, // has Regex
	OpAddAss, // has Regex
	OpSubAss, // has Regex
	OpMul, // has Regex
	OpDiv, // has Regex
	OpMod, // has Regex
	OpPow, // has Regex
	OpMulAss, // has Regex
	OpDivAss, // has Regex
	OpModAss, // has Regex
	OpPowAss, // has Regex
	// &   |   ^   &=  |=  ^=
	OpAnd, // has Regex
	OpOr, // has Regex
	OpXor, // has Regex
	OpAndAss, // has Regex
	OpOrAss, // has Regex
	OpXorAss, // has Regex
	// =   ~   !   ++  --  .   ,
	OpAssign, // has Regex
	OpTildeNot, // has Regex
	OpNot, // has Regex
	OpPlusPlus, // has Regex
	OpMinusMinus, // has Regex
	OpDot, // has Regex
	OpComma, // has Regex
	// (&&  and) (||  or)  xor
	OpAndAnd, // has Regex
	OpOrOr, // has Regex
	OpXorXor, // has Regex

	Keyword_enum, // has Regex
	Keyword_module, // has Regex
	Keyword_import, // has Regex
	Keyword_struct, // has Regex
	Keyword_class, // has Regex
	Keyword_interface, // has Regex
	Keyword_function, // has Regex
	Keyword_dynamic, // has Regex
	Keyword_is, // has Regex
	Keyword_has, // has Regex
	Keyword_where, // has Regex
	Keyword_if, // has Regex
	Keyword_else, // has Regex
	Keyword_for, // has Regex
	Keyword_while, // has Regex
	Keyword_do, // has Regex
	Keyword_with, // has Regex
	Keyword_using, // has Regex
	Keyword_return, // has Regex
	Keyword_cast, // has Regex
	Keyword_throw, // has Regex
	Keyword_new, // has Regex
	Keyword_try, // has Regex
	Keyword_catch, // has Regex
	Keyword_finally, // has Regex
	Keyword_var, // has Regex
	Keyword_delete, // has Regex
	Keyword_alias, // has Regex
	Keyword_union, // has Regex
	Keyword_override, // has Regex
	Keyword_debug, // has Regex
	Keyword_switch, // has Regex
	Keyword_case, // has Regex
	Keyword_default, // has Regex
	Keyword_break, // has Regex
	Keyword_continue, // has Regex
	Keyword_goto, // has Regex
	Keyword_foreach, // has Regex
	Keyword_foreach_reverse, // has Regex
	Keyword_scope, // has Regex
	Keyword_unittest, // has Regex

	EOF /// Always appended to the end
}

private RegexToken[] regexes = [ /* Will get called in this order */
	RegexToken(TokenType.Whitespace, ctRegex!`^[^\S\r\n]+`),
	RegexToken(TokenType.Attribute, ctRegex!`^(public|private|protected|static|const|abstract|override|deprecated)\b`),
	RegexToken(TokenType.CustomAttribute, ctRegex!`^@`),
	RegexToken(TokenType.Semicolon, ctRegex!`^;`),
	RegexToken(TokenType.Colon, ctRegex!`^:`),
	RegexToken(TokenType.CurlyBraceOpen, ctRegex!`^\{`),
	RegexToken(TokenType.CurlyBraceClose, ctRegex!`^\}`),
	RegexToken(TokenType.SquareBracketOpen, ctRegex!`^\[`),
	RegexToken(TokenType.SquareBracketClose, ctRegex!`^\]`),
	RegexToken(TokenType.ParenthesesOpen, ctRegex!`^\(`),
	RegexToken(TokenType.ParenthesesClose, ctRegex!`^\)`),
	RegexToken(TokenType.OpAndAnd, ctRegex!`^(&&|and\b)`),
	RegexToken(TokenType.OpOrOr, ctRegex!`^(\|\||or\b)`),
	RegexToken(TokenType.OpXorXor, ctRegex!`^xor\b`),
	RegexToken(TokenType.OpUShiftRightAss, ctRegex!`^>>>=`),
	RegexToken(TokenType.OpUShiftRight, ctRegex!`^>>>`),
	RegexToken(TokenType.OpShiftRightAss, ctRegex!`^>>=`),
	RegexToken(TokenType.OpShiftRight, ctRegex!`^>>`),
	RegexToken(TokenType.OpShiftLeftAss, ctRegex!`^<<=`),
	RegexToken(TokenType.OpShiftLeft, ctRegex!`^<<`),
	RegexToken(TokenType.OpLE, ctRegex!`^<=`),
	RegexToken(TokenType.OpLT, ctRegex!`^<`),
	RegexToken(TokenType.OpGE, ctRegex!`^>=`),
	RegexToken(TokenType.OpGT, ctRegex!`^>`),
	RegexToken(TokenType.OpEqual, ctRegex!`^==`),
	RegexToken(TokenType.OpNotEqual, ctRegex!`^!=`),
	RegexToken(TokenType.OpHas, ctRegex!`^has\b`),
	RegexToken(TokenType.OpIs, ctRegex!`^is\b`),
	RegexToken(TokenType.OpIn, ctRegex!`^in\b`),
	RegexToken(TokenType.OpAddAss, ctRegex!`^\+=`),
	RegexToken(TokenType.OpSubAss, ctRegex!`^\-=`),
	RegexToken(TokenType.OpMulAss, ctRegex!`^\*=`),
	RegexToken(TokenType.OpDivAss, ctRegex!`^\/=`),
	RegexToken(TokenType.OpModAss, ctRegex!`^\%=`),
	RegexToken(TokenType.OpPowAss, ctRegex!`^\^\^=`),
	RegexToken(TokenType.OpAdd, ctRegex!`^\+`),
	RegexToken(TokenType.OpSub, ctRegex!`^\-`),
	RegexToken(TokenType.OpMul, ctRegex!`^\*`),
	RegexToken(TokenType.OpDiv, ctRegex!`^\/`),
	RegexToken(TokenType.OpMod, ctRegex!`^\%`),
	RegexToken(TokenType.OpPow, ctRegex!`^\^\^`),
	RegexToken(TokenType.OpAndAss, ctRegex!`^\&=`),
	RegexToken(TokenType.OpOrAss, ctRegex!`^\|=`),
	RegexToken(TokenType.OpXorAss, ctRegex!`^\^=`),
	RegexToken(TokenType.OpAnd, ctRegex!`^\&`),
	RegexToken(TokenType.OpOr, ctRegex!`^\|`),
	RegexToken(TokenType.OpXor, ctRegex!`^\^`),
	RegexToken(TokenType.OpTildeNot, ctRegex!`^~`),
	RegexToken(TokenType.OpNot, ctRegex!`^!`),
	RegexToken(TokenType.OpPlusPlus, ctRegex!`^\+\+`),
	RegexToken(TokenType.OpMinusMinus, ctRegex!`^\-\-`),
	RegexToken(TokenType.OpDot, ctRegex!`^\.`),
	RegexToken(TokenType.OpComma, ctRegex!`^,`),
	RegexToken(TokenType.OpAssign, ctRegex!`^=`),
	RegexToken(TokenType.HexNumberValue, ctRegex!`^[+-]?0x[0-9a-fA-F]+\b`),
	RegexToken(TokenType.BinaryNumberValue, ctRegex!`^[+-]?0b[01]+\b`),
	RegexToken(TokenType.NumberValue, ctRegex!`^[+-]?\d+\b`),
	RegexToken(TokenType.FloatingValue, ctRegex!`^[+-]?(\d+\.\d+|\.\d+|\d+\.)(e[+-]?\d+)?f?\b`),
	RegexToken(TokenType.Keyword_enum, ctRegex!`^enum\b`),
	RegexToken(TokenType.Keyword_module, ctRegex!`^module\b`),
	RegexToken(TokenType.Keyword_import, ctRegex!`^import\b`),
	RegexToken(TokenType.Keyword_struct, ctRegex!`^struct\b`),
	RegexToken(TokenType.Keyword_class, ctRegex!`^class\b`),
	RegexToken(TokenType.Keyword_interface, ctRegex!`^interface\b`),
	RegexToken(TokenType.Keyword_function, ctRegex!`^function\b`),
	RegexToken(TokenType.Keyword_dynamic, ctRegex!`^dynamic\b`),
	RegexToken(TokenType.Keyword_is, ctRegex!`^is\b`),
	RegexToken(TokenType.Keyword_has, ctRegex!`^has\b`),
	RegexToken(TokenType.Keyword_where, ctRegex!`^where\b`),
	RegexToken(TokenType.Keyword_if, ctRegex!`^if\b`),
	RegexToken(TokenType.Keyword_else, ctRegex!`^else\b`),
	RegexToken(TokenType.Keyword_for, ctRegex!`^for\b`),
	RegexToken(TokenType.Keyword_while, ctRegex!`^while\b`),
	RegexToken(TokenType.Keyword_do, ctRegex!`^do\b`),
	RegexToken(TokenType.Keyword_with, ctRegex!`^with\b`),
	RegexToken(TokenType.Keyword_using, ctRegex!`^using\b`),
	RegexToken(TokenType.Keyword_return, ctRegex!`^return\b`),
	RegexToken(TokenType.Keyword_cast, ctRegex!`^cast\b`),
	RegexToken(TokenType.Keyword_throw, ctRegex!`^throw\b`),
	RegexToken(TokenType.Keyword_new, ctRegex!`^new\b`),
	RegexToken(TokenType.Keyword_try, ctRegex!`^try\b`),
	RegexToken(TokenType.Keyword_catch, ctRegex!`^catch\b`),
	RegexToken(TokenType.Keyword_finally, ctRegex!`^finally\b`),
	RegexToken(TokenType.Keyword_var, ctRegex!`^var\b`),
	RegexToken(TokenType.Keyword_delete, ctRegex!`^delete\b`),
	RegexToken(TokenType.Keyword_alias, ctRegex!`^alias\b`),
	RegexToken(TokenType.Keyword_union, ctRegex!`^union\b`),
	RegexToken(TokenType.Keyword_override, ctRegex!`^override\b`),
	RegexToken(TokenType.Keyword_debug, ctRegex!`^debug\b`),
	RegexToken(TokenType.Keyword_switch, ctRegex!`^switch\b`),
	RegexToken(TokenType.Keyword_case, ctRegex!`^case\b`),
	RegexToken(TokenType.Keyword_default, ctRegex!`^default\b`),
	RegexToken(TokenType.Keyword_break, ctRegex!`^break\b`),
	RegexToken(TokenType.Keyword_continue, ctRegex!`^continue\b`),
	RegexToken(TokenType.Keyword_goto, ctRegex!`^goto\b`),
	RegexToken(TokenType.Keyword_foreach, ctRegex!`^foreach\b`),
	RegexToken(TokenType.Keyword_foreach_reverse, ctRegex!`^foreach_reverse\b`),
	RegexToken(TokenType.Keyword_scope, ctRegex!`^scope\b`),
	RegexToken(TokenType.Keyword_unittest, ctRegex!`^unittest\b`),
	RegexToken(TokenType.True, ctRegex!`^(true|yes|on)\b`),
	RegexToken(TokenType.False, ctRegex!`^(false|no|off)\b`),
	RegexToken(TokenType.Identifier, ctRegex!`^[a-zA-Z_][a-zA-Z0-9_]*\b`), // No unicode characters, so there is no ";" (Greek question mark) in the variable names
];

///
struct Token
{
	///
	TokenType type;
	///
	string content;
	///
	int line;

	string toString() const
	{
		return content;
	}
}

private struct RegexToken
{
	TokenType token;
	StaticRegex!char regex;
}

class ScriptSyntaxError : Exception {
	public this(string msg, string source, int line) {
		super(msg ~ " in " ~ source ~ " in line " ~ to!string(line));
	}
}

///
Token[] tokenize(string code, string source)
{
	Token[] tokens;
	int line = 1; // Code lines start at 1
 CodeLoop:
	while (code.length > 0)
	{
		{ // Newline
			if (code[0] == '\r')
			{
				code = code[1 .. $];
				if (code.length == 0)
					break;
				if (code[0] == '\n')
					code = code[1 .. $];
				line++;
				continue CodeLoop;
			}
			else if (code[0] == '\n')
			{
				code = code[1 .. $];
				line++;
				continue CodeLoop;
			}
		}
		{ // String
			if (code[0] == '"' || code[0] == '`' || (code.length > 1 && code[0 .. 2] == "r\""))
			{
				string found = "";
				bool needsEscape = true;
				if (code[0] == 'r')
				{
					found ~= 'r';
					code = code[1 .. $];
					needsEscape = false;
				}
				if (code[0] == '`')
					needsEscape = false;
				immutable char strChar = code[0];
				found ~= code[0];
				code = code[1 .. $];
				bool escaped = false;
				bool inString = true;

				while (inString)
				{
					if (code.length == 0)
						throw new ScriptSyntaxError("Unexpected EOF while in String", source, line);
					immutable char c = code[0];
					switch (c)
					{
					case '\\':
						if (escaped)
						{
							found ~= c;
							escaped = false;
						}
						else
						{
							escaped = true;
						}
						break;
					default:
						if (c == strChar)
						{
							found ~= c;
							if (escaped)
							{
								escaped = false;
							}
							else
							{
								inString = false;
							}
						}
						else if (escaped)
						{
							escaped = false;
							if (needsEscape)
								switch (c)
								{
								case '\'': // TODO: There must be a nice D way of doing all this!
									found ~= '\'';
									break;
								case '"':
									found ~= '"';
									break;
								case '?':
									found ~= '\?';
									break;
								case '0':
									found ~= '\0';
									break;
								case 'a':
									found ~= '\a';
									break;
								case 'b':
									found ~= '\b';
									break;
								case 'f':
									found ~= '\f';
									break;
								case 'n':
									found ~= '\n';
									break;
								case 'r':
									found ~= '\r';
									break;
								case 'v':
									found ~= '\v';
									break;
								default:
									throw new ScriptSyntaxError("Invalid escaped character '\\" ~ c ~ "'", source, line);
								}
							else
							{
								found ~= '\\';
								found ~= c;
							}
						}
						else
						{
							found ~= c;
						}
						break;
					}
					code = code[1 .. $];
				}
				tokens ~= Token(TokenType.StringValue, found, line);
				continue CodeLoop;
			}
		}
		foreach (regex; regexes)
		{
			auto match = code.matchFirst(regex.regex);
			if (!match.empty)
			{
				if (regex.token != TokenType.Whitespace)
					tokens ~= Token(regex.token, match.hit, line);
				code = code[match.hit.length .. $];
				continue CodeLoop;
			}
		}
		if (code.length >= 10)
			throw new ScriptSyntaxError("Unexpected Token at " ~ code[0 .. 10] ~ "...", source, line);
		throw new ScriptSyntaxError("Unexpected Token at " ~ code, source, line);
	}
	tokens ~= Token(TokenType.EOF, "", line);
	return tokens;
}

unittest
{
	assert(tokenize(q{"Hello \"World\""}, "unittest:lexer.d")[0].content == `"Hello "World""`, "String parsing wrong");

	std.stdio.writeln(tokenize(q{
module example.test;
import std.stdio;

void foo()
{
    string foo = try new Foo("Hello World").run();
	print(foo);
	foreach_reverse(c; foo)
	{
		print(c);
	}
}

class Foo
{
    string message;
    this(string message)
    {
        . = message;
	}

    void run()
    {
        throw message;
	}
}}, "unittest:lexer.d"));
}
