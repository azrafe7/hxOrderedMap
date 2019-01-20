import haxe.Constraints.IMap;
import haxe.ds.ObjectMap;
import haxe.ds.ReadOnlyArray;

/**
  OrderedObjectMap allows mapping of object keys to arbitrary values,
  and remembers the order in which key-values are inserted.

  See `OrderedObjectMapImpl` (the actual implementation) and `OrderedMap` for documentation details.
**/
@:forward
@:native("OrderedObjectMap")
abstract OrderedObjectMap<K:{}, V>(OrderedObjectMapImpl<K, V>) from OrderedObjectMapImpl<K, V> {

  public inline function new() {
    this = new OrderedObjectMapImpl<K, V>();
  }

  @:arrayAccess inline function _get(key:K)
    return this.get(key);

  @:arrayAccess inline function _set(key:K, value:V):V {
    this.set(key, value);
    return value;
  }
}

class OrderedObjectMapImpl<K:{}, V> implements IOrderedMap<K, V> {

  @:allow(OrderedObjectMapIterator)
  var _orderedKeys:Array<K> = [];
  var _innerMap:ObjectMap<K, V> = new ObjectMap();

  /**
    Creates a new OrderedObjectMap.
  **/
  public function new():Void {}

  /**
    See `OrderedMap.set`
  **/
  public function set(key:K, value:V):Void {
    if (!_innerMap.exists(key))
      _orderedKeys.push(key);
    _innerMap.set(key, value);
  }

  /**
    See `OrderedMap.get`
  **/
  public inline function get(key:K):Null<V> {
    return _innerMap.get(key);
  }

  /**
    See `OrderedMap.exists`
  **/
  public inline function exists(key:K):Bool {
    return _innerMap.exists(key);
  }

  /**
    See `OrderedMap.remove`
  **/
  public function remove(key:K):Bool {
    var removed = _innerMap.remove(key);
    if (removed)
      _orderedKeys.remove(key);
    return removed;
  }

  /**
    See `OrderedMap.keys`
  **/
  public inline function keys():Iterator<K> {
    var clonedKeys = _orderedKeys.copy();
    return clonedKeys.iterator();
  }

  /**
    See `OrderedMap.iterator`
  **/
  public inline function iterator():Iterator<V> {
    return new OrderedObjectMapIterator(this);
  }

  /**
    See `OrderedMap.keyValueIterator`
  **/
  public inline function keyValueIterator():KeyValueIterator<K, V> {
    return new haxe.iterators.MapKeyValueIterator(this);
  }

  /**
    See `OrderedMap.copy`
  **/
  public function copy():OrderedObjectMapImpl<K, V> {
    var clone = new OrderedObjectMapImpl<K, V>();
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
  public var orderedKeys(get, null):ReadOnlyArray<K>;

  inline function get_orderedKeys():ReadOnlyArray<K> {
    return cast this._orderedKeys;
  }

  /**
    See `OrderedMap.innerMap`
  **/
  public var innerMap(get, null):ReadOnlyMap<K, V>;

  inline function get_innerMap():ReadOnlyMap<K, V> {
    return cast this._innerMap;
  }

  /**
    See `OrderedMap.keysCopy`
  **/
  public inline function keysCopy():Array<K> {
    return _orderedKeys.copy();
  }

  /**
    See `OrderedMap.clear`
  **/
  public function clear():Void {
    _orderedKeys = [];
    _innerMap = new ObjectMap();
  }

  /**
    See `OrderedMap.toString`
  **/
  public function toString():String {
    var k:K;
    var len = _orderedKeys.length;
    var str = "[";
    for (i in 0...len) {
      k = _orderedKeys[i];
      str += k + " => " + _innerMap.get(k) + (i != len - 1 ? ", " : "");
    }
    return str + "]";
  }
}

@:native("OrderedObjectMapIterator")
private class OrderedObjectMapIterator<K:{}, V> {

  var map:OrderedObjectMap<K, V>;
  var index:Int = 0;

  public inline function new(omap:OrderedObjectMap<K, V>) {
    map = omap;
  }

  public inline function hasNext():Bool {
    return index < map._orderedKeys.length;
  }

  public inline function next():V {
    return map.get(map._orderedKeys[index++]);
  }
}
