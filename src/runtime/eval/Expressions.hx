package runtime.eval;

import util.MkUtil.mkNull;
import runtime.Interpreter.evaluate;

using runtime.Values;
using compiler.AST;

function eval_identifier(ident:Identifier, env:Environment):RuntimeVal {
	final val = env.lookupVar(ident.symbol);
	return val;
}

function eval_binary_expr(binop:BinaryExpr, env:Environment):RuntimeVal {
	final lhs = evaluate(binop.left, env);
	final rhs = evaluate(binop.right, env);

	if (lhs.type == Number && rhs.type == Number) {
		return eval_numeric_binary_expr(cast lhs, cast rhs, binop.op);
	} else {
		return mkNull();
	}
}

function eval_numeric_binary_expr(lhs:NumberVal, rhs:NumberVal, op:String):NumberVal {
	var result = 0.0;

	switch (op) {
		case "+":
			result = lhs.value + rhs.value;
		case "-":
			result = lhs.value - rhs.value;
		case "*":
			result = lhs.value * rhs.value;
		case "/":
			// TODO: division by zero checks
			result = lhs.value / rhs.value;
	}

	return {type: Number, value: result};
}
