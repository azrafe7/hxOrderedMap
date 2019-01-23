package cases;

import haxe.ds.Map;
import hxbenchmark.Suite;

class KeysIterator extends TestCase {

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

    var suite = new Suite('IntMap.keys()', MAX_TIME_PER_CASE);

    suite.add("map.keys() (unordered)", {
      for (k in map.keys())
        var x = k;
    });
    suite.add("omap.keys() (ordered)", {
      for (k in omap.keys())
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

    var suite = new Suite('StringMap.keys()', MAX_TIME_PER_CASE);

    suite.add("map.keys() (unordered)", {
      for (k in map.keys())
        var x = k;
    });
    suite.add("omap.keys() (ordered)", {
      for (k in omap.keys())
        var x = k;
    });

    return suite.run();
  }
}
