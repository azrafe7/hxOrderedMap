import utest.Assert;

class TestOrderedObjectMap extends utest.Test {
  static public var keys:Array<{}>;
  static public var stringValues:Array<String>;

  public function new() {
    super();
  }

  static public function buildOrderedMapFrom(keys:Array<{}>, values) {
    var omap = new OrderedMap();

    for (i in 0...keys.length) {
      var k = keys[i];
      var v = values[i];

      omap[k] = v;
    }

    return omap;
  }

  static public function buildMapFrom(keys:Array<{}>, values) {
    var map = new Map();

    for (i in 0...keys.length) {
      var k = keys[i];
      var v = values[i];

      map[k] = v;
    }

    return map;
  }

  function setup() {
    // trace("-- SETUP");
    keys = [
      {number: "1"},
      {fruit: "apple"},
      {fruit: "banana"},
      {fruit: "orange"},
      {pos: "one"},
      {post: "two"},
      {pos: "three"}
    ];
    stringValues = [for (i in 0...keys.length) Std.string(i)];

    // trace("ORDERED_MAP  : " + buildOrderedMapFrom(keys, stringValues));
    // trace("DEFAULT_MAP  : " + buildMapFrom(keys, stringValues));
    // trace("-- END SETUP");
  }

  function testOrderAndLength() {
    var omap = buildOrderedMapFrom(keys, stringValues);
    var map = buildMapFrom(keys, stringValues);

    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    var defaultKeys = TestUtils.iteratorToArray(map.keys());

    Assert.equals(orderedKeys.length, defaultKeys.length);
    Assert.same(keys, orderedKeys);
  }

  function testValues() {
    var omap = buildOrderedMapFrom(keys, stringValues);
    var map = buildMapFrom(keys, stringValues);

    for (k in map.keys()) {
      Assert.equals(map[k], omap[k]);
    }
  }
}
