hxOrderedMap
==========================================

Hxperimental implementation of ordered maps for Haxe 4.0+ (wrapping haxe.ds.Map).


## Overview

This is a multi-type abstract that wraps `haxe.ds.Map` and can be used with the same API.

It also adds a few methods (like `length`, `keysCopy()`, `clear()`).

The main difference with Map is that the order of insertion is preserved when iterated.


## Minimal example

```haxe
var keys = ["1", "apple", "banana", "orange", "one", "two", "three"];
var values = [for (i in 0...keys.length) i];

var omap = new OrderedMap();
var map = new Map();

for (i in 0...keys.length) {
  var k = keys[i];
  var v = values[i];

  omap[k] = v;
  map[k] = v;
}

trace("ORDERED  : " + omap); // always  [1 => 0, apple => 1, banana => 2, orange => 3, one => 4, two => 5, three => 6]
trace("UNORDERED: " + map);  // may be  {orange => 3, three => 6, apple => 1, banana => 2, one => 4, 1 => 0, two => 5}
```


## Notes

Internal book-keeping to maintain the order of insertion makes using this lib a bit slower than using a Map directly
(approximately 1.5-2x slower). 

But retrieving some information about an OrderedMap instance is faster for the same reason 
(like getting the number of key-values, a copy of the keys, or clearing the map).

Hence this is not indended as a replacement for `haxe.ds.Map`, but it can be useful in some situations.


## License (MIT)

See [LICENSE](LICENSE).