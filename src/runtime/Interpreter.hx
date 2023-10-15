package runtime;

import util.MkUtil.mkNumber;
import util.MkUtil.mkNull;
import haxe.exceptions.NotImplementedException;

using runtime.Values;
using compiler.AST;

class Interpreter {
	public static function evaluate(astNode:Statement, env:Environment):RuntimeVal {
		switch (astNode.kind) {
			case NumericLiteral:
				final nl:NumericLiteral = cast astNode;
				return mkNumber(nl.value);
			case NullLiteral:
				return mkNull();
			case Identifier:
				return eval_identifier(cast astNode, env);
			case BinaryExpr:
				return eval_binary_expr(cast astNode, env);
			case Program:
				return eval_program(cast astNode, env);
			default:
				throw new NotImplementedException('Node not implemented: ${astNode.kind}\n');
				Sys.exit(1);
				return cast {type: Null, value: "null"};
		}
	}

	private static function eval_identifier(ident:Identifier, env:Environment):RuntimeVal {
		final val = env.lookupVar(ident.symbol);
		return val;
	}

	private static function eval_binary_expr(binop:BinaryExpr, env:Environment):RuntimeVal {
		final lhs = evaluate(binop.left, env);
		final rhs = evaluate(binop.right, env);

		if (lhs.type == Number && rhs.type == Number) {
			return eval_numeric_binary_expr(cast lhs, cast rhs, binop.op);
		} else {
			return mkNull();
		}
	}

	private static function eval_numeric_binary_expr(lhs:NumberVal, rhs:NumberVal, op:String):NumberVal {
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

	private static function eval_program(program:Program, env:Environment):RuntimeVal {
		var lastEvaluated:RuntimeVal = mkNull();

		for (stmt in program.body) {
			lastEvaluated = evaluate(stmt, env);
		}

		return lastEvaluated;
	}
}
