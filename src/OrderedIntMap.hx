import haxe.Constraints.IMap;
import haxe.ds.IntMap;

/**
  OrderedIntMap allows mapping of Int keys to arbitrary values,
  and remembers the order in which key-values are inserted.

  See `OrderedIntMapImpl` (the actual implementation) and `OrderedMap` for documentation details.
**/
@:forward
@:native("OrderedIntMap")
abstract OrderedIntMap<T>(OrderedIntMapImpl<T>) from OrderedIntMapImpl<T> {

  public inline function new() {
    this = new OrderedIntMapImpl<T>();
  }

  @:arrayAccess inline function _get(key:Int)
    return this.get(key);

  @:arrayAccess inline function _set(key:Int, value:T):T {
    this.set(key, value);
    return value;
  }
}

class OrderedIntMapImpl<T> implements IOrderedMap<Int, T> {

  @:allow(OrderedIntMapIterator)
  var orderedKeys:Array<Int> = [];
  var map:IntMap<T> = new IntMap();

  /**
    Creates a new OrderedIntMap.
  **/
  public function new():Void {}

  /**
    See `OrderedMap.set`
  **/
  public function set(key:Int, value:T):Void {
    if (!map.exists(key))
      orderedKeys.push(key);
    map.set(key, value);
  }

  /**
    See `OrderedMap.get`
  **/
  public inline function get(key:Int):Null<T> {
    return map.get(key);
  }

  /**
    See `OrderedMap.exists`
  **/
  public inline function exists(key:Int):Bool {
    return map.exists(key);
  }

  /**
    See `OrderedMap.remove`
  **/
  public function remove(key:Int):Bool {
    var removed = map.remove(key);
    if (removed)
      orderedKeys.remove(key);
    return removed;
  }

  /**
    See `OrderedMap.keys`
  **/
  public inline function keys():Iterator<Int> {
    return orderedKeys.copy().iterator();
  }

  /**
    See `OrderedMap.iterator`
  **/
  public inline function iterator():Iterator<T> {
    return new OrderedIntMapIterator(this);
  }

  /**
    See `OrderedMap.keyValueIterator`
  **/
  public inline function keyValueIterator():KeyValueIterator<Int, T> {
    return new haxe.iterators.MapKeyValueIterator(this);
  }

  /**
    See `OrderedMap.copy`
  **/
  public function copy():OrderedIntMapImpl<T> {
    var clone = new OrderedIntMapImpl<T>();
    for (k in orderedKeys)
      clone.set(k, map.get(k));
    return clone;
  }

  /**
    See `OrderedMap.keysCopy`
  **/
  public inline function keysCopy():Array<Int> {
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
    map = new IntMap();
  }

  /**
    See `OrderedMap.toString`
  **/
  public function toString():String {
    var k:Int;
    var len = orderedKeys.length;
    var str = "[";
    for (i in 0...len) {
      k = orderedKeys[i];
      str += k + " => " + map.get(k) + (i != len - 1 ? ", " : "");
    }
    return str + "]";
  }
}

@:native("OrderedIntMapIterator")
private class OrderedIntMapIterator<V> {

  var map:OrderedIntMap<V>;
  var index:Int = 0;

  public inline function new(omap:OrderedIntMap<V>) {
    map = omap;
  }

  public inline function hasNext():Bool {
    return index < map.orderedKeys.length;
  }

  public inline function next():V {
    return map.get(map.orderedKeys[index++]);
  }
}
