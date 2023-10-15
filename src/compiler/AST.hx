package compiler;

enum NodeType {
	// Statements
	Program;
	VarDeclaration;

	// Expressions
	NumericLiteral;
	Identifier;
	BinaryExpr;
}

typedef Statement = {
	kind:NodeType
}

typedef Program = {
	> Statement,
	kind:NodeType,
	body:Array<Statement>
}

typedef VarDeclaration = {
	> Statement,
	kind:NodeType,
	constant:Bool,
	key:String,
	?value:Expression
}

typedef Expression = {
	> Statement,
}

typedef BinaryExpr = {
	> Expression,
	left:Expression,
	right:Expression,
	op:String
}

typedef Identifier = {
	> Expression,
	symbol:String
}

typedef NumericLiteral = {
	> Expression,
	value:Float
}
