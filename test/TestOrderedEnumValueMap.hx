import utest.Assert;
import haxe.macro.Expr;

class TestOrderedEnumValueMap extends utest.Test {
  static public var keys:Array<EnumValue>;
  static public var stringValues:Array<String>;

  public function new() {
    super();
  }

  static public function buildOrderedMapFrom(keys:Array<EnumValue>, values) {
    var omap = new OrderedMap();

    for (i in 0...keys.length) {
      var k = keys[i];
      var v = values[i];

      omap[k] = v;
    }

    return omap;
  }

  static public function buildMapFrom(keys:Array<EnumValue>, values) {
    var map = new Map();

    for (i in 0...keys.length) {
      var k = keys[i];
      var v = values[i];

      map[k] = v;
    }

    return map;
  }

  public function setup() {
    // trace("-- SETUP");
    keys = [
      EContinue,
      EBreak,
      EConst(CString("bar")),
      EConst(CString("foo")),
      EArray(null, null),
      EConst(CString("5")),
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
