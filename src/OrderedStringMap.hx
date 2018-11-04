import haxe.Constraints.IMap;
import haxe.ds.StringMap;

class OrderedStringMap<T> implements IOrderedMap<String, T> {

  var map:StringMap<T> = new StringMap();

  /**
    Creates a new OrderedStringMap.
  **/
  public function new():Void {}

  /**
    See `OrderedMap.set`
  **/
  public function set(key:String, value:T):Void {
    map.set(key, value);
  }

  /**
    See `OrderedMap.get`
  **/
  public inline function get(key:String):Null<T> {
    return map.get(key);
  }

  /**
    See `OrderedMap.exists`
  **/
  public inline function exists(key:String):Bool {
    return map.exists(key);
  }

  /**
    See `OrderedMap.remove`
  **/
  public function remove(key:String):Bool {
    return map.remove(key);
  }

  /**
    See `OrderedMap.keys`
  **/
  public inline function keys():Iterator<String> {
    return map.keys();
  }

  /**
    See `OrderedMap.iterator`
  **/
  public inline function iterator():Iterator<T> {
    return map.iterator();
  }

  /**
    See `OrderedMap.keyValueIterator`
  **/
  public inline function keyValueIterator():KeyValueIterator<String, T> {
    return new haxe.iterators.MapKeyValueIterator(this);
  }

  /**
    See `OrderedMap.copy`
  **/
  public function copy():OrderedStringMap<T> {
    var clone = new OrderedStringMap();
    clone.map = map.copy();
    return clone;
  }

  /**
    See `OrderedMap.toString`
  **/
  public function toString():String {
    return map.toString();
  }
}
