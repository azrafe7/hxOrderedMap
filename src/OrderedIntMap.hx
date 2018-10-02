import haxe.Constraints.IMap;
import haxe.ds.IntMap;

@:forward
@:native("OrderedIntMap")
abstract OrderedIntMap<T>(OrderedIntMapImpl<T>) from OrderedIntMapImpl<T> {
  public inline function new() {
    this = new OrderedIntMapImpl<T>();
  }

  @:arrayAccess @:noCompletion public inline function _get(key:Int)
    return this.get(key);

  @:arrayAccess @:noCompletion public inline function _set(key:Int, value:T)
    return this.set(key, value);
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
  public function get(key:Int):Null<T> {
    return map.get(key);
  }

  /**
    See `OrderedMap.exists`
  **/
  public function exists(key:Int):Bool {
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
  inline public function keys():Iterator<Int> {
    return orderedKeys.copy().iterator();
  }

  /**
    See `OrderedMap.iterator`
  **/
  inline public function iterator():Iterator<T> {
    return new OrderedIntMapIterator(this);
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
    See `OrderedMap.orderedKeysCopy`
  **/
  public var orderedKeysCopy(get, never):Array<Int>;

  inline function get_orderedKeysCopy():Array<Int> {
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

  inline public function new(omap:OrderedIntMap<V>) {
    map = omap;
  }

  inline public function hasNext():Bool {
    return index < map.orderedKeys.length;
  }

  inline public function next():V {
    return map.get(map.orderedKeys[index++]);
  }
}
