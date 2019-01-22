package cases;

import haxe.ds.Map;
import hxbenchmark.Suite;

class Get extends TestCase {

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

    var suite = new Suite('IntMap.get()', MAX_TIME_PER_CASE);

    suite.add("map.get()", {
      for (d in data)
        var x = map.get(d);
    });
    suite.add("omap.get()", {
      for (d in data)
        var x = omap.get(d);
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

    var suite = new Suite('StringMap.get()', MAX_TIME_PER_CASE);

    suite.add("map.get()", {
      for (d in data)
        var x = map.get(d);
    });
    suite.add("omap.get()", {
      for (d in data)
        var x = omap.get(d);
    });

    return suite.run();
  }
}
