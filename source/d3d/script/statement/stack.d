module d3d.script.statement.stack;

import d3d.script;

enum Operation
{
	Add,
	Substract,
	Multiply,
	Divide,
	Modulo,
	BitAnd,
	BitOr,
	BitXor,
	BitPow,
	BitBsr,
	BitBsl,
	BitUBsr,
	BitUnaryPlus,
	BitUnaryMinus,
	BitUnaryInvert,
	Load,
}

class StackStatement : Statement
{
private:
	Operation _operation;
public:
	void run()
	{

	}

	@property ref Operation operation()
	{
		return _operation;
	}
}
