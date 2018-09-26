import haxe.Constraints.IMap;
import haxe.ds.EnumValueMap;

class OrderedEnumValueMap<K:EnumValue, V> implements haxe.Constraints.IMap<K, V> implements IOrderedMap<K, V> {
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
  inline public function keys():Iterator<K> {
    return orderedKeys.copy().iterator();
  }

  /**
    See `OrderedMap.iterator`
  **/
  inline public function iterator():Iterator<V> {
    return new OrderedEnumValueMapIterator(this);
  }

  /**
    See `OrderedMap.copy`
  **/
  public function copy():OrderedEnumValueMap<K, V> {
    var clone = new OrderedEnumValueMap<K, V>();
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
    map = new EnumValueMap();
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

  inline public function new(omap:OrderedEnumValueMap<K, V>) {
    map = omap;
  }

  inline public function hasNext():Bool {
    return index < map.orderedKeys.length;
  }

  inline public function next():V {
    return map.get(map.orderedKeys[index++]);
  }
}
