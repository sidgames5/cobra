package exception;

import haxe.Exception;

class RuntimeException extends Exception {
	public function new(?message:String) {
		super(message);
		Sys.stderr().writeString('Runtime error: $message\n');
		Sys.exit(1);
	}
}
