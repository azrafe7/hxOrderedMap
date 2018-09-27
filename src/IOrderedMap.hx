import haxe.Constraints.IMap;

interface IOrderedMap<K, V> extends IMap<K, V> {
  var length(get, null):Int;
  var orderedKeysCopy(get, null):Array<K>;
  function clear():Void;
}
