import haxe.Constraints.IMap;
import haxe.ds.ObjectMap;

class OrderedObjectMap<K:{}, V> implements haxe.Constraints.IMap<K, V> {
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
  public function get(key:K):Null<V> {
    return map.get(key);
  }

  /**
    See `OrderedMap.exists`
  **/
  public function exists(key:K):Bool {
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
  public function keys():Iterator<K> {
    return orderedKeys.copy().iterator();
  }

  /**
    See `OrderedMap.iterator`
  **/
  public function iterator():Iterator<V> {
    return new OrderedObjectMapIterator(this);
  }

  /**
    See `OrderedMap.copy`
  **/
  public function copy():OrderedObjectMap<K, V> {
    var clone = new OrderedObjectMap();
    for (k in orderedKeys)
      clone.set(k, map.get(k));
    return clone;
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

private class OrderedObjectMapIterator<K:{}, V> {
  var map:OrderedObjectMap<K, V>;
  var index:Int = 0;

  public function new(omap:OrderedObjectMap<K, V>) {
    map = omap;
  }

  public function hasNext():Bool {
    return index < map.orderedKeys.length;
  }

  public function next():V {
    return map.get(map.orderedKeys[index++]);
  }
}
