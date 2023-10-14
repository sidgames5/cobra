package runtime;

import haxe.exceptions.NotImplementedException;

using runtime.Values;
using compiler.AST;

class Interpreter {
	public static function evaluate(astNode:Dynamic):RuntimeVal {
		switch (astNode.kind) {
			case NumericLiteral:
				return cast {type: Number, value: astNode.value};
			case NullLiteral:
				return cast {type: Null, value: "null"};
			case BinaryExpr:
				return eval_binary_expr(astNode);
			case Program:
				return eval_program(astNode);
			default:
				throw new NotImplementedException('Node not implemented: ${astNode.kind}\n');
				Sys.exit(1);
				return cast {type: Null, value: "null"};
		}
	}

	private static function eval_binary_expr(binop:BinaryExpr):RuntimeVal {
		final lhs = evaluate(binop.left);
		final rhs = evaluate(binop.right);

		if (lhs.type == Number && rhs.type == Number) {
			return eval_numeric_binary_expr(cast lhs, cast rhs, binop.op);
		} else {
			return cast {type: "null", value: "null"};
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

	private static function eval_program(program:Program):RuntimeVal {
		var lastEvaluated:RuntimeVal = cast {
			type: "null",
			value: "null"
		};

		for (stmt in program.body) {
			lastEvaluated = evaluate(stmt);
		}

		return lastEvaluated;
	}
}
