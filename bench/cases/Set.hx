package cases;

import hxbenchmark.Suite;

class Set extends TestCase {

  var MAX_TIME_PER_CASE:Float = .5;
  var N = 1000;

  function measureInt() {
    var data = [for (i in 0...N) i];
    TestUtils.shuffle(data);

    var suite = new Suite('IntMap .set)', MAX_TIME_PER_CASE);

    suite.add("map.set()", {
      var map = new Map();
      for (d in data)
        map.set(d, d);
    });
    suite.add("omap.set()", {
      var omap = new OrderedMap();
      for (d in data)
        omap.set(d, d);
    });
    suite.add("map[]", {
      var map = new Map();
      for (d in data)
        map[d] = d;
    });
    suite.add("omap[]", {
      var omap = new OrderedMap();
      for (d in data)
        omap[d] = d;
    });

    return suite.run();
  }

  function measureString() {
    var data = [for (i in 0...N) "" + i];
    TestUtils.shuffle(data);

    var suite = new Suite('StringMap .set)', MAX_TIME_PER_CASE);

    suite.add("map.set()", {
      var map = new Map();
      for (d in data)
        map.set(d, d);
    });
    suite.add("omap.set()", {
      var omap = new OrderedMap();
      for (d in data)
        omap.set(d, d);
    });
    suite.add("map[]", {
      var map = new Map();
      for (d in data)
        map[d] = d;
    });
    suite.add("omap[]", {
      var omap = new OrderedMap();
      for (d in data)
        omap[d] = d;
    });

    return suite.run();
  }
}
