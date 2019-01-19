import haxe.Constraints.IMap;

/**
  OrderedMap allows key to value mapping for arbitrary value types, and many key
  types.

  This is a multi-type abstract, it is instantiated as one of its
  specialization types depending on its type parameters.

  An OrderedMap can be instantiated without explicit type parameters. Type inference
  will then determine the type parameters from the usage.

  OrderedMap is an abstract type, it is not available at runtime.
**/
@:multiType(@:followWithAbstracts K)
@:native("OrderedMap")
abstract OrderedMap<K, V>(IOrderedMap<K, V>) {

  /**
    Creates a new OrderedMap.

    This becomes a constructor call to one of the specialization types in
    the output. The rules for that are as follows:

    1. if K is a `String`, `OrderedStringMap` is used
    2. if K is an `Int`, `OrderedIntMap` is used
    3. if K is an `EnumValue`, `OrderedEnumValueMap` is used
    4. if K is any other class or structure, `OrderedObjectMap` is used
    5. if K is any other type, it causes a compile-time error
  **/
  public function new();

  /**
    Maps `key` to `value`.

    If `key` already has a mapping, the previous value disappears.

    If `key` is null, the result is unspecified.
  **/
  public inline function set(key:K, value:V):Void
    this.set(key, value);

  /**
    Returns the current mapping of `key`.

    If no such mapping exists, null is returned.

    Note that a check like `map.get(key) == null` can hold for two reasons:

    1. the map has no mapping for `key`
    2. the map has a mapping with a value of `null`

    If it is important to distinguish these cases, `exists()` should be
    used.

    If `key` is null, the result is unspecified.
  **/
  @:arrayAccess public inline function get(key:K):Null<V>
    return this.get(key);

  /**
    Returns true if `key` has a mapping, false otherwise.

    If `key` is null, the result is unspecified.
  **/
  public inline function exists(key:K):Bool
    return this.exists(key);

  /**
    Removes the mapping of `key` and returns true if such a mapping existed,
    false otherwise.

    If `key` is null, the result is unspecified.
  **/
  public inline function remove(key:K):Bool
    return this.remove(key);

  /**
    Returns an Iterator over the keys of `this` map in order of insertion.
  **/
  public inline function keys():Iterator<K> {
    // see https://github.com/azrafe7/hxOrderedMap/issues/2#issuecomment-435195303
  #if cs
    return (cast this).keys();
  #else
    return this.keys();
  #end
  }

  /**
    Returns an Iterator over the values of `this` map in order of insertion.
  **/
  public inline function iterator():Iterator<V> {
    return this.iterator();
  }

  /**
    Returns an Iterator over the keys and values of `this` Map in order of insertion.
  **/
  public inline function keyValueIterator():KeyValueIterator<K, V> {
    // see https://github.com/azrafe7/hxOrderedMap/issues/2#issuecomment-435195303
  #if cs
    return (cast this).keyValueIterator();
  #else
    return this.keyValueIterator();
  #end
  }

  /**
    Returns a shallow copy of `this` map.

    Key-values ordering will be preserved.
  **/
  public inline function copy():OrderedMap<K, V> {
    return cast this.copy();
  }

  /**
    Returns a copy of the keys of `this` map in order of insertion.
  **/
  public inline function keysCopy():Array<K> {
    return this.keysCopy();
  }

  /**
    Returns the number of key-values in `this` map.
  **/
  public var length(get, never):Int;

  inline function get_length():Int {
    return this.length;
  }

  /**
    Empties the map. All key-values are removed.

    NOTE: A new *inner* map and orderedKeys array are constructed,
    so previous references to them are invalid.
  **/
  public inline function clear():Void {
    return this.clear();
  }

  /**
    Returns the inner map as a ReadOnlyMap.

    NOTE: it's not a copy, so altering it (via casting it to Map, for example),
    invalidates the state of the OrderedMap that wraps it.
   */
  public inline function getInnerMap<K, V>():ReadOnlyMap<K, V> {
    return @:privateAccess (cast this).map;
  }

  /**
    Returns a String representation of `this` map.

    The exact representation depends on the platform and key-type.
  **/
  public inline function toString():String {
    return this.toString();
  }

  @:arrayAccess inline function arrayWrite(k:K, v:V):V {
    this.set(k, v);
    return v;
  }

#if !(eval || macro)
  @:generic static public function fromKeysAndValues<K, V>(keys:Array<K>, values:Array<V>):OrderedMap<K, V> {
    if (keys.length != values.length)
      throw "`keys` and `values` must have the same length.";
    var omap:OrderedMap<K, V> = new OrderedMap<K, V>();
    for (i in 0...keys.length)
      omap[keys[i]] = values[i];
    return omap;
  }

  @:generic static public function fromMap<K, V>(map:Map<K, V>):OrderedMap<K, V> {
    var omap = new OrderedMap();
    for (k in map.keys()) @:privateAccess
      (cast omap).orderedKeys.push(k);
    @:privateAccess (cast omap).map = map;
    return omap;
  }
#end

  @:to static inline function toOrderedStringMap<K:String, V>(t:IOrderedMap<K, V>):OrderedStringMap<V> {
    return new OrderedStringMap<V>();
  }

  @:to static inline function toOrderedIntMap<K:Int, V>(t:IOrderedMap<K, V>):OrderedIntMap<V> {
    return new OrderedIntMap<V>();
  }

  @:to static inline function toOrderedEnumValueMap<K:EnumValue, V>(t:IOrderedMap<K, V>):OrderedEnumValueMap<K, V> {
    return new OrderedEnumValueMap<K, V>();
  }

  @:to static inline function toOrderedObjectMap<K:{}, V>(t:IOrderedMap<K, V>):OrderedObjectMap<K, V> {
    return new OrderedObjectMap<K, V>();
  }

  @:from static inline function fromOrderedStringMap<V>(map:OrderedStringMap<V>):OrderedMap<String, V> {
    return cast map;
  }

  @:from static inline function fromOrderedIntMap<V>(map:OrderedIntMap<V>):OrderedMap<Int, V> {
    return cast map;
  }

  @:from static inline function fromOrderedObjectMap<K:{}, V>(map:OrderedObjectMap<K, V>):OrderedMap<K, V> {
    return cast map;
  }
}
