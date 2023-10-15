package exception;

import haxe.Exception;

class CompilerException extends Exception {
	public function new(?message:String) {
		super(message);
		Sys.stderr().writeString('Compiler error: $message\n');
		Sys.exit(1);
	}
}
