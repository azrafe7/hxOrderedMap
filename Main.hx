import IOrderedMap;
import OrderedMap;
import OrderedStringMap;
import OrderedIntMap;
import OrderedObjectMap;
import OrderedEnumValueMap;

class Main {

  static function main() {
    var keys = ["1", "apple", "banana", "orange", "one", "two", "three"];
    var values = keys.copy();

    var omap = new OrderedMap();
    var map = new Map();

    for (i in 0...keys.length) {
      var k = keys[i];
      var v = values[i];

      omap[k] = v;
      map[k] = v;
    }

    trace("ORDERED  : " + omap);
    trace("UNORDERED: " + map);
  }
}
