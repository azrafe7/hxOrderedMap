import haxe.Constraints.IMap;
import haxe.ds.StringMap;


/* IXMap interface */
interface IXMap<K, V> extends IMap<K, V> { }


/* Main */
class Issue {
  public static function main() {

    var xmap = new XMap();
    xmap["1"] = "one";

    trace(xmap);
  }
}


/* XMap multitype abstract */
@:multiType(@:followWithAbstracts K)
abstract XMap<K, V>(IXMap<K, V>) {

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

  public inline function copy():XMap<K, V> {
    return cast this.copy();
  }

  public inline function toString():String {
    return this.toString();
  }

  @:arrayAccess inline function arrayWrite(k:K, v:V):V {
    this.set(k, v);
    return v;
  }

  @:to static inline function toXStringMap<K:String, V>(t:IXMap<K, V>):XStringMap<V> {
    return new XStringMap<V>();
  }

  @:from static inline function fromXStringMap<V>(map:XStringMap<V>):XMap<String, V> {
    return cast map;
  }
}


/* XStringMap implementation */
class XStringMap<T> implements IXMap<String, T> {

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

  public function copy():XStringMap<T> {
    var clone = new XStringMap();
    clone.map = map.copy();
    return clone;
  }

  public function toString():String {
    return map.toString();
  }
}
