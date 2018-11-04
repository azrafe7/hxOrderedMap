import haxe.Constraints.IMap;

@:multiType(@:followWithAbstracts K)
abstract OrderedMap<K, V>(IOrderedMap<K, V>) {

  public function new();

  public inline function set(key:K, value:V):Void
    this.set(key, value);

  @:arrayAccess public inline function get(key:K):Null<V>
    return this.get(key);

  public inline function exists(key:K):Bool
    return this.exists(key);

  public inline function remove(key:K):Bool
    return this.remove(key);

  public inline function keys():Iterator<K> {
    return (cast this).keys();
  }

  public inline function iterator():Iterator<V> {
    return this.iterator();
  }

  public inline function keyValueIterator():KeyValueIterator<K, V> {
    return this.keyValueIterator();
  }

  public inline function copy():OrderedMap<K, V> {
    return cast this.copy();
  }

  public inline function toString():String {
    return this.toString();
  }

  @:arrayAccess inline function arrayWrite(k:K, v:V):V {
    this.set(k, v);
    return v;
  }

  @:to static inline function toOrderedStringMap<K:String, V>(t:IOrderedMap<K, V>):OrderedStringMap<V> {
    return new OrderedStringMap<V>();
  }

  @:from static inline function fromOrderedStringMap<V>(map:OrderedStringMap<V>):OrderedMap<String, V> {
    return cast map;
  }
}
