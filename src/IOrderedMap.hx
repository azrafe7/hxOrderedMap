import haxe.Constraints.IMap;


interface IOrderedMap<K, V> /*extends IMap<K, V>*/ {

  function get(k:K):Null<V>;
  function set(k:K, v:V):Void;
  function exists(k:K):Bool;
  function remove(k:K):Bool;
  function keys():Iterator<K>;
  function iterator():Iterator<V>;
  function copy():IOrderedMap<K, V>;
  function toString():String;
  
  var length(get, null):Int;
  var orderedKeysCopy(get, null):Array<K>;
  function clear():Void;
}
