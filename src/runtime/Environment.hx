package runtime;

import haxe.Exception;
import runtime.Values.RuntimeVal;

class Environment {
	private var parent:Null<Environment>;
	private var variables:Map<String, RuntimeVal>;

	public function new(?parent:Environment) {
		this.parent = parent;
		this.variables = new Map();
	}

	public function declareVar(key:String, value:RuntimeVal):RuntimeVal {
		if (this.variables.exists(key)) {
			throw new Exception('Variable $key has already been declared');
			return null;
		}

		this.variables.set(key, value);
		return value;
	}

	public function assignVar(key:String, value:RuntimeVal):RuntimeVal {
		final env = this.resolve(key);
		env.variables.set(key, value);
		return value;
	}

	public function lookupVar(key:String):RuntimeVal {
		final env = this.resolve(key);
		return env.variables.get(key);
	}

	public function resolve(key:String):Environment {
		if (this.variables.exists(key)) {
			return this;
		}

		if (this.parent == null) {
			throw new Exception('Cannot resolve $key as it does not exist');
			return null;
		}

		return this.parent.resolve(key);
	}
}
