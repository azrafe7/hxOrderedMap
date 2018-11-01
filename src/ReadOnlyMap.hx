@:forward(exists, keys, iterator, copy, toString)
abstract ReadOnlyMap<K, V>(Map<K, V>) from Map<K, V> {

  @:arrayAccess public inline function get(k:K):Null<V>
    return this[k];

  @:arrayAccess inline function arrayWrite(k:K, v:V):V
    throw "Cannot modify a ReadOnlyMap.";

  public inline function set(k:K, v:V):Void
    throw "Cannot modify a ReadOnlyMap.";

  public inline function remove(k:K):Void
    throw "Cannot modify a ReadOnlyMap.";
}
