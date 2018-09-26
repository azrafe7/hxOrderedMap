import haxe.Constraints.IMap;
import haxe.ds.EnumValueMap;

class OrderedEnumValueMap<K:EnumValue, V> implements haxe.Constraints.IMap<K, V> {
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
    return orderedKeys.iterator();
  }

  /**
    See `OrderedMap.iterator`
  **/
  public function iterator():Iterator<V> {
    return new OrderedEnumValueMapIterator(this);
  }

  /**
    See `OrderedMap.copy`
  **/
  public function copy():OrderedEnumValueMap<K, V> {
    var clone = new OrderedEnumValueMap();
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

private class OrderedEnumValueMapIterator<K:EnumValue, V> {
  var map:OrderedEnumValueMap<K, V>;
  var index:Int = 0;

  public function new(omap:OrderedEnumValueMap<K, V>) {
    map = omap;
  }

  public function hasNext():Bool {
    return index < map.orderedKeys.length;
  }

  public function next():V {
    return map.get(map.orderedKeys[index++]);
  }
}
