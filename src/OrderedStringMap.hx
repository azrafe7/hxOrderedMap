import haxe.Constraints.IMap;
import haxe.ds.StringMap;

class OrderedStringMap<T> implements haxe.Constraints.IMap<String, T> {
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
  public function get(key:String):Null<T> {
    return map.get(key);
  }

  /**
    See `OrderedMap.exists`
  **/
  public function exists(key:String):Bool {
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
  inline public function keys():Iterator<String> {
    return orderedKeys.copy().iterator();
  }

  /**
    See `OrderedMap.iterator`
  **/
  inline public function iterator():Iterator<T> {
    return new OrderedStringMapIterator(this);
  }

  /**
    See `OrderedMap.copy`
  **/
  public function copy():OrderedStringMap<T> {
    var clone = new OrderedStringMap<T>();
    for (k in orderedKeys)
      clone.set(k, map.get(k));
    return clone;
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

private class OrderedStringMapIterator<V> {
  var map:OrderedStringMap<V>;
  var index:Int = 0;

  inline public function new(omap:OrderedStringMap<V>) {
    map = omap;
  }

  inline public function hasNext():Bool {
    return index < map.orderedKeys.length;
  }

  inline public function next():V {
    return map.get(map.orderedKeys[index++]);
  }
}
