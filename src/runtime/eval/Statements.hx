package runtime.eval;

import haxe.exceptions.NotImplementedException;
import util.MkUtil.mkNull;
import runtime.Interpreter.evaluate;

using runtime.Values;
using compiler.AST;

function eval_program(program:Program, env:Environment):RuntimeVal {
	var lastEvaluated:RuntimeVal = mkNull();

	for (stmt in program.body) {
		lastEvaluated = evaluate(stmt, env);
	}

	return lastEvaluated;
}

function eval_var_declaration(declaration:VarDeclaration, env:Environment):RuntimeVal {
	// env.declareVar(declaration.key, declaration.value);
	throw new NotImplementedException();
}
