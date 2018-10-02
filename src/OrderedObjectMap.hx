import haxe.Constraints.IMap;
import haxe.ds.ObjectMap;


@:forward
@:native("OrderedObjectMap")
abstract OrderedObjectMap<K:{}, V>(OrderedObjectMapImpl<K, V>) from OrderedObjectMapImpl<K, V> {

  public inline function new() {
    this = new OrderedObjectMapImpl<K, V>();
  }

  @:arrayAccess @:noCompletion public inline function _get(key:K)
    return this.get(key);

  @:arrayAccess @:noCompletion public inline function _set(key:K, value:V)
    return this.set(key, value);
}


class OrderedObjectMapImpl<K:{}, V> implements IOrderedMap<K, V> {

  @:allow(OrderedObjectMapIterator)
  var orderedKeys:Array<K> = [];
  var map:ObjectMap<K, V> = new ObjectMap();

  /**
    Creates a new OrderedObjectMap.
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
  inline public function get(key:K):Null<V> {
    return map.get(key);
  }

  /**
    See `OrderedMap.exists`
  **/
  inline public function exists(key:K):Bool {
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
  inline public function keys():Iterator<K> {
    return orderedKeys.copy().iterator();
  }

  /**
    See `OrderedMap.iterator`
  **/
  inline public function iterator():Iterator<V> {
    return new OrderedObjectMapIterator(this);
  }

  /**
    See `OrderedMap.copy`
  **/
  public function copy():OrderedObjectMapImpl<K, V> {
    var clone = new OrderedObjectMapImpl<K, V>();
    for (k in orderedKeys)
      clone.set(k, map.get(k));
    return clone;
  }

  /**
    See `OrderedMap.orderedKeysCopy`
  **/
  public var orderedKeysCopy(get, never):Array<K>;

  inline function get_orderedKeysCopy():Array<K> {
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
    orderedKeys.resize(0);
    map = new ObjectMap();
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


@:native("OrderedObjectMapIterator")
private class OrderedObjectMapIterator<K:{}, V> {

  var map:OrderedObjectMap<K, V>;
  var index:Int = 0;

  inline public function new(omap:OrderedObjectMap<K, V>) {
    map = omap;
  }

  inline public function hasNext():Bool {
    return index < map.orderedKeys.length;
  }

  inline public function next():V {
    return map.get(map.orderedKeys[index++]);
  }
}
