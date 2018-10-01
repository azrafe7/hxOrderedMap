import haxe.Constraints.IMap;

interface IOrderedMap<K, V> extends IMap<K, V> {
#if cpp
  public function get(k:K):Null<V>;
  public function set(k:K, v:V):Void;
  public function exists(k:K):Bool;
  public function remove(k:K):Bool;
  public function keys():Iterator<K>;
  public function iterator():Iterator<V>;
  public function copy():IOrderedMap<K,V>;
  public function toString():String;
#end

  var length(get, null):Int;
  var orderedKeysCopy(get, null):Array<K>;
  function clear():Void;
}
