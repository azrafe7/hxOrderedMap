import haxe.ds.StringMap;

class OrderedStringMap<T> implements IOrderedMap<String, T> {

  var map:StringMap<T> = new StringMap();

  public function new():Void {}

  public function set(key:String, value:T):Void {
    map.set(key, value);
  }

  public inline function get(key:String):Null<T> {
    return map.get(key);
  }

  public inline function exists(key:String):Bool {
    return map.exists(key);
  }

  public function remove(key:String):Bool {
    return map.remove(key);
  }

  public inline function keys():Iterator<String> {
    return map.keys();
  }

  public inline function iterator():Iterator<T> {
    return map.iterator();
  }

  public inline function keyValueIterator():KeyValueIterator<String, T> {
    return new haxe.iterators.MapKeyValueIterator(this);
  }

  public function copy():OrderedStringMap<T> {
    var clone = new OrderedStringMap();
    clone.map = map.copy();
    return clone;
  }

  public function toString():String {
    return map.toString();
  }
}
