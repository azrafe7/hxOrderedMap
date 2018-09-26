import haxe.Constraints.IMap;
import haxe.ds._TYPE_Map;

class Ordered_TYPE_Map<T> implements haxe.Constraints.IMap<_TYPE_, T> {
	@:allow(Ordered_TYPE_MapIterator)
	var orderedKeys:Array<_TYPE_> = [];
	var map:_TYPE_Map<T> = new _TYPE_Map();

	/**
		Creates a new Ordered_TYPE_Map.
	**/
	public function new():Void {}

	/**
		See `OrderedMap.set`
	**/
	public function set(key:_TYPE_, value:T):Void {
		if (!map.exists(key))
			orderedKeys.push(key);
		map.set(key, value);
	}

	/**
		See `OrderedMap.get`
	**/
	public function get(key:_TYPE_):Null<T> {
		return map.get(key);
	}

	/**
		See `OrderedMap.exists`
	**/
	public function exists(key:_TYPE_):Bool {
		return map.exists(key);
	}

	/**
		See `OrderedMap.remove`
	**/
	public function remove(key:_TYPE_):Bool {
		var removed = map.remove(key);
		if (removed)
			orderedKeys.remove(key);
		return removed;
	}

	/**
		See `OrderedMap.keys`
	**/
	public function keys():Iterator<_TYPE_> {
		return orderedKeys.iterator();
	}

	/**
		See `OrderedMap.iterator`
	**/
	public function iterator():Iterator<T> {
		return new Ordered_TYPE_MapIterator(this);
	}

	/**
		See `OrderedMap.copy`
	**/
	public function copy():Ordered_TYPE_Map<T> {
		var clone = new Ordered_TYPE_Map();
		for (k in orderedKeys)
			clone.set(k, map.get(k));
		return clone;
	}

	/**
		See `OrderedMap.toString`
	**/
	public function toString():String {
		var k:_TYPE_;
		var len = orderedKeys.length;
		var str = "[";
		for (i in 0...len) {
			k = orderedKeys[i];
			str += k + " => " + map.get(k) + (i != len - 1 ? ", " : "");
		}
		return str + "]";
	}
}

private class Ordered_TYPE_MapIterator<V> {
	var map:Ordered_TYPE_Map<V>;
	var index:Int = 0;

	public function new(omap:Ordered_TYPE_Map<V>) {
		map = omap;
	}

	public function hasNext():Bool {
		return index < map.orderedKeys.length;
	}

	public function next():V {
		return map.get(map.orderedKeys[index++]);
	}
}
