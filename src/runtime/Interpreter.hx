package runtime;

import runtime.eval.Statements.eval_var_declaration;
import runtime.eval.Expressions.eval_binary_expr;
import runtime.eval.Expressions.eval_identifier;
import runtime.eval.Statements.eval_program;
import exception.RuntimeException;
import util.MkUtil.mkNumber;

using runtime.Values;
using compiler.AST;

class Interpreter {
	public static function evaluate(astNode:Statement, env:Environment):RuntimeVal {
		switch (astNode.kind) {
			case NumericLiteral:
				final nl:NumericLiteral = cast astNode;
				return mkNumber(nl.value);
			case Identifier:
				return eval_identifier(cast astNode, env);
			case BinaryExpr:
				return eval_binary_expr(cast astNode, env);
			case Program:
				return eval_program(cast astNode, env);
			case VarDeclaration:
				return eval_var_declaration(cast astNode, env);
			default:
				throw new RuntimeException('Node not implemented: ${astNode.kind}');
				Sys.exit(1);
				return cast {type: Null, value: "null"};
		}
	}
}
