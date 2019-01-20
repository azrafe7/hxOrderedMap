import haxe.Constraints.IMap;
import haxe.ds.IntMap;
import haxe.ds.ReadOnlyArray;

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
  var _orderedKeys:Array<Int> = [];
  var _innerMap:IntMap<T> = new IntMap();

  /**
    Creates a new OrderedIntMap.
  **/
  public function new():Void {}

  /**
    See `OrderedMap.set`
  **/
  public function set(key:Int, value:T):Void {
    if (!_innerMap.exists(key))
      _orderedKeys.push(key);
    _innerMap.set(key, value);
  }

  /**
    See `OrderedMap.get`
  **/
  public inline function get(key:Int):Null<T> {
    return _innerMap.get(key);
  }

  /**
    See `OrderedMap.exists`
  **/
  public inline function exists(key:Int):Bool {
    return _innerMap.exists(key);
  }

  /**
    See `OrderedMap.remove`
  **/
  public function remove(key:Int):Bool {
    var removed = _innerMap.remove(key);
    if (removed)
      _orderedKeys.remove(key);
    return removed;
  }

  /**
    See `OrderedMap.keys`
  **/
  public inline function keys():Iterator<Int> {
    var clonedKeys = _orderedKeys.copy();
    return clonedKeys.iterator();
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
    clone._orderedKeys = _orderedKeys.copy();
    clone._innerMap = _innerMap.copy();
    return clone;
  }

  /**
    See `OrderedMap.length`
  **/
  public var length(get, never):Int;

  inline function get_length():Int {
    return _orderedKeys.length;
  }

  /**
    See `OrderedMap.orderedKeys`
  **/
  public var orderedKeys(get, never):ReadOnlyArray<Int>;

  inline function get_orderedKeys():ReadOnlyArray<Int> {
    return cast this._orderedKeys;
  }

  /**
    See `OrderedMap.innerMap`
  **/
  public var innerMap(get, null):ReadOnlyMap<Int, T>;

  inline function get_innerMap():ReadOnlyMap<Int, T> {
    return cast this._innerMap;
  }

  /**
    See `OrderedMap.keysCopy`
  **/
  public inline function keysCopy():Array<Int> {
    return _orderedKeys.copy();
  }

  /**
    See `OrderedMap.clear`
  **/
  public function clear():Void {
    _orderedKeys = [];
    _innerMap = new IntMap();
  }

  /**
    See `OrderedMap.toString`
  **/
  public function toString():String {
    var k:Int;
    var len = _orderedKeys.length;
    var str = "[";
    for (i in 0...len) {
      k = _orderedKeys[i];
      str += k + " => " + _innerMap.get(k) + (i != len - 1 ? ", " : "");
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
    return index < map._orderedKeys.length;
  }

  public inline function next():V {
    return map.get(map._orderedKeys[index++]);
  }
}
