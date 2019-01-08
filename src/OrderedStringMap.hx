import haxe.Constraints.IMap;
import haxe.ds.StringMap;

/**
  OrderedStringMap allows mapping of String keys to arbitrary values,
  and remembers the order in which key-values are inserted.

  See `OrderedStringMapImpl` (the actual implementation) and `OrderedMap` for documentation details.
**/
@:forward
@:native("OrderedStringMap")
abstract OrderedStringMap<T>(OrderedStringMapImpl<T>) from OrderedStringMapImpl<T> {

  public inline function new() {
    this = new OrderedStringMapImpl<T>();
  }

  @:arrayAccess inline function _get(key:String)
    return this.get(key);

  @:arrayAccess inline function _set(key:String, value:T):T {
    this.set(key, value);
    return value;
  }
}

class OrderedStringMapImpl<T> implements IOrderedMap<String, T> {

  @:allow(OrderedStringMapIterator)
  var orderedKeys:Array<String> = [];
  var map:StringMap<T> = new StringMap();

  /**
    Creates a new OrderedStringMap.
  **/
  public function new():Void {}

  /**
    See `OrderedMap.set`
  **/
  public function set(key:String, value:T):Void {
    if (!map.exists(key))
      orderedKeys.push(key);
    map.set(key, value);
  }

  /**
    See `OrderedMap.get`
  **/
  public inline function get(key:String):Null<T> {
    return map.get(key);
  }

  /**
    See `OrderedMap.exists`
  **/
  public inline function exists(key:String):Bool {
    return map.exists(key);
  }

  /**
    See `OrderedMap.remove`
  **/
  public function remove(key:String):Bool {
    var removed = map.remove(key);
    if (removed)
      orderedKeys.remove(key);
    return removed;
  }

  /**
    See `OrderedMap.keys`
  **/
  public inline function keys():Iterator<String> {
    var clonedKeys = orderedKeys.copy();
    return clonedKeys.iterator();
  }

  /**
    See `OrderedMap.iterator`
  **/
  public inline function iterator():Iterator<T> {
    return new OrderedStringMapIterator(this);
  }

  /**
    See `OrderedMap.keyValueIterator`
  **/
  public inline function keyValueIterator():KeyValueIterator<String, T> {
    return new haxe.iterators.MapKeyValueIterator(this);
  }

  /**
    See `OrderedMap.copy`
  **/
  public function copy():OrderedStringMapImpl<T> {
    var clone = new OrderedStringMapImpl<T>();
    for (k in orderedKeys)
      clone.set(k, map.get(k));
    return clone;
  }

  /**
    See `OrderedMap.keysCopy`
  **/
  public inline function keysCopy():Array<String> {
    return orderedKeys.copy();
  }

  /**
    See `OrderedMap.length`
  **/
  public var length(get, never):Int;

  inline function get_length():Int {
    return orderedKeys.length;
  }

  /**
    See `OrderedMap.clear`
  **/
  public function clear():Void {
    orderedKeys = [];
    map = new StringMap();
  }

  /**
    See `OrderedMap.toString`
  **/
  public function toString():String {
    var k:String;
    var len = orderedKeys.length;
    var str = "[";
    for (i in 0...len) {
      k = orderedKeys[i];
      str += k + " => " + map.get(k) + (i != len - 1 ? ", " : "");
    }
    return str + "]";
  }
}

@:native("OrderedStringMapIterator")
private class OrderedStringMapIterator<V> {

  var map:OrderedStringMap<V>;
  var index:Int = 0;

  public inline function new(omap:OrderedStringMap<V>) {
    map = omap;
  }

  public inline function hasNext():Bool {
    return index < map.orderedKeys.length;
  }

  public inline function next():V {
    return map.get(map.orderedKeys[index++]);
  }
}
