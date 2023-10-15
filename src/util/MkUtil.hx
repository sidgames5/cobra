package util;

import runtime.Values.BoolVal;
import runtime.Values.NullVal;
import runtime.Values.NumberVal;

using runtime.Values.ValueType;

function mkNumber(n:Float = 0):NumberVal {
	return {type: Number, value: n};
}

function mkNull():NullVal {
	return {type: Null, value: null};
}

function mkBool(v:Bool = false):BoolVal {
	return {type: Bool, value: v};
}
