import haxe.Constraints.IMap;
import haxe.ds.EnumValueMap;

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
  var orderedKeys:Array<K> = [];
  var map:EnumValueMap<K, V> = new EnumValueMap();

  /**
    Creates a new OrderedEnumValueMap.
  **/
  public function new():Void {}

  /**
    See `OrderedMap.set`
  **/
  public function set(key:K, value:V):Void {
    if (!map.exists(key))
      orderedKeys.push(key);
    map.set(key, value);
  }

  /**
    See `OrderedMap.get`
  **/
  public inline function get(key:K):Null<V> {
    return map.get(key);
  }

  /**
    See `OrderedMap.exists`
  **/
  public inline function exists(key:K):Bool {
    return map.exists(key);
  }

  /**
    See `OrderedMap.remove`
  **/
  public function remove(key:K):Bool {
    var removed = map.remove(key);
    if (removed)
      orderedKeys.remove(key);
    return removed;
  }

  /**
    See `OrderedMap.keys`
  **/
  public inline function keys():Iterator<K> {
    var clonedKeys = orderedKeys.copy();
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
    clone.orderedKeys = orderedKeys.copy();
    clone.map = map.copy();
    return clone;
  }

  /**
    See `OrderedMap.keysCopy`
  **/
  public inline function keysCopy():Array<K> {
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
    map = new EnumValueMap();
  }

  /**
    See `OrderedMap.clear`
  **/
  public inline function getInnerMap<K, V>():ReadOnlyMap<K, V> {
    return cast map;
  }

  /**
    See `OrderedMap.toString`
  **/
  public function toString():String {
    var k:K;
    var len = orderedKeys.length;
    var str = "[";
    for (i in 0...len) {
      k = orderedKeys[i];
      str += k + " => " + map.get(k) + (i != len - 1 ? ", " : "");
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
    return index < map.orderedKeys.length;
  }

  public inline function next():V {
    return map.get(map.orderedKeys[index++]);
  }
}
