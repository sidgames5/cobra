package util;

import runtime.Values.NullVal;
import runtime.Values.NumberVal;

using runtime.Values.ValueType;

function mkNumber(n:Float = 0):NumberVal {
	return {type: Number, value: n};
}

function mkNull():NullVal {
	return {type: Null, value: null};
}
