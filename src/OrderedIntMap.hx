import haxe.Constraints.IMap;
import haxe.ds.IntMap;

class OrderedIntMap<T> implements haxe.Constraints.IMap<Int, T> {
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
  public function copy():OrderedIntMap<T> {
    var clone = new OrderedIntMap<T>();
    for (k in orderedKeys)
      clone.set(k, map.get(k));
    return clone;
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
