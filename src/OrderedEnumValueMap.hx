import haxe.Constraints.IMap;
import haxe.ds.EnumValueMap;
import haxe.ds.ReadOnlyArray;

/**
  OrderedEnumValueMap allows mapping of enum value keys to arbitrary values,
  and remembers the order in which key-values are inserted.

  Keys are compared by value and recursively over their parameters. If any
  parameter is not an enum value, `Reflect.compare` is used to compare them.

  See `OrderedEnumValueMapImpl` (the actual implementation) and `OrderedMap` for documentation details.
**/
@:forward
@:native("OrderedEnumValueMap")
abstract OrderedEnumValueMap<K:EnumValue, V>(OrderedEnumValueMapImpl<K, V>) from OrderedEnumValueMapImpl<K, V> {

  public inline function new() {
    this = new OrderedEnumValueMapImpl<K, V>();
  }

  @:arrayAccess inline function _get(key:K):Null<V>
    return this.get(key);

  @:arrayAccess inline function _set(key:K, value:V):V {
    this.set(key, value);
    return value;
  }
}

class OrderedEnumValueMapImpl<K:EnumValue, V> implements IOrderedMap<K, V> {

  @:allow(OrderedEnumValueMapIterator)
  var _orderedKeys:Array<K> = [];
  var _innerMap:EnumValueMap<K, V> = new EnumValueMap();

  /**
    Creates a new OrderedEnumValueMap.
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
    return new OrderedEnumValueMapIterator(this);
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
  public function copy():OrderedEnumValueMapImpl<K, V> {
    var clone = new OrderedEnumValueMapImpl<K, V>();
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
    _innerMap = new EnumValueMap();
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

@:native("OrderedEnumValueMapIterator")
private class OrderedEnumValueMapIterator<K:EnumValue, V> {

  var map:OrderedEnumValueMap<K, V>;
  var index:Int = 0;

  public inline function new(omap:OrderedEnumValueMap<K, V>) {
    map = omap;
  }

  public inline function hasNext():Bool {
    return index < map._orderedKeys.length;
  }

  public inline function next():V {
    return map.get(map._orderedKeys[index++]);
  }
}
