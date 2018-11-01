import haxe.Constraints.IMap;

interface IOrderedMap<K, V> #if !(cpp || hl) extends IMap<K, V> #end {

// see https://github.com/azrafe7/hxOrderedMap/issues/2
#if (cpp || hl)
  /* IMap */
  function get(k:K):Null<V>;
  function set(k:K, v:V):Void;
  function exists(k:K):Bool;
  function remove(k:K):Bool;
  function keys():Iterator<K>;
  function iterator():Iterator<V>;
  function copy():IOrderedMap<K, V>;
  function toString():String;
#end

  /* IOrderedMap */
  var length(get, null):Int;
  function keysCopy():Array<K>;
  function clear():Void;
}
