package cases;

import haxe.ds.Map;
import hxbenchmark.Suite;

class ValuesIterator extends TestCase {

  var MAX_TIME_PER_CASE:Float = .5;
  var N = 1000;

  function measureInt() {
    var data = [for (i in 0...N) i];
    TestUtils.shuffle(data);
    var map = new Map();
    var omap = new OrderedMap();
    for (d in data) {
      map.set(d, d);
      omap.set(d, d);
    }
    TestUtils.shuffle(data);

    var suite = new Suite('IntMap.iterator()', MAX_TIME_PER_CASE);

    suite.add("map.iterator() (unordered)", {
      for (k in map.iterator())
        var x = k;
    });
    suite.add("omap.iterator() (ordered)", {
      for (k in omap.iterator())
        var x = k;
    });

    return suite.run();
  }

  function measureString() {
    var data = [for (i in 0...N) "" + i];
    TestUtils.shuffle(data);
    var map = new Map();
    var omap = new OrderedMap();
    for (d in data) {
      map.set(d, d);
      omap.set(d, d);
    }
    TestUtils.shuffle(data);

    var suite = new Suite('StringMap.iterator()', MAX_TIME_PER_CASE);

    suite.add("map.iterator() (unordered)", {
      for (k in map.iterator())
        var x = k;
    });
    suite.add("omap.iterator() (ordered)", {
      for (k in omap.iterator())
        var x = k;
    });

    return suite.run();
  }
}
