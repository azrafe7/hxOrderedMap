import haxe.Constraints.IMap;
import haxe.ds.ReadOnlyArray;

interface IOrderedMap<K, V> extends IMap<K, V> {

  /* IMap */
  function get(k:K):Null<V>;
  function set(k:K, v:V):Void;
  function exists(k:K):Bool;
  function remove(k:K):Bool;
  function keys():Iterator<K>;
  function iterator():Iterator<V>;
  function keyValueIterator():KeyValueIterator<K, V>;
  function copy():IOrderedMap<K, V>;
  function toString():String;

  /* IOrderedMap */
  var length(get, never):Int;
  var orderedKeys(get, null):ReadOnlyArray<K>;
  var innerMap(get, null):ReadOnlyMap<K, V>;
  function keysCopy():Array<K>;
  function clear():Void;
}
