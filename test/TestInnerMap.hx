import utest.Assert;
import haxe.macro.Expr;

class TestInnerMap extends utest.Test {

  public function new() {
    super();
  }

  public function _testMap<K, V>(map:Map<K, V>, k:K, v:V) {
    map.set(k, v);
    Assert.equals(v, map.get(k));
  }

  function testOStringMap() {
    new TestOrderedStringMap().setup();
    var omap = TestOrderedStringMap.buildOrderedMapFrom(TestOrderedStringMap.keys, TestOrderedStringMap.stringValues);

    var map = omap.getInnerMap();
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    var defaultKeys = TestUtils.iteratorToArray(omap.getInnerMap().keys());

    Assert.notEquals(map, omap);
    Assert.equals(defaultKeys.length, orderedKeys.length);
    for (k in defaultKeys) {
      Assert.contains(k, orderedKeys);
      Assert.equals(map[k], omap[k]);
    }
    for (k in orderedKeys) {
      Assert.contains(k, defaultKeys);
      Assert.equals(omap[k], map[k]);
    }

    var newKey = "newKey";
    var newValue = "newValue";
    omap[newKey] = newValue;
    Assert.isTrue(map.exists(newKey));

    /* cannot modify read-only inner map */
    Assert.raises(function() {
      omap.getInnerMap()[newKey] = newValue;
    });

    _testMap(cast map, newKey, "newer value for string key");
  }

  function testOIntMap() {
    new TestOrderedIntMap().setup();
    var omap = TestOrderedIntMap.buildOrderedMapFrom(TestOrderedIntMap.keys, TestOrderedIntMap.stringValues);

    var map = omap.getInnerMap();
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    var defaultKeys = TestUtils.iteratorToArray(omap.getInnerMap().keys());

    Assert.notEquals(map, omap);
    Assert.equals(defaultKeys.length, orderedKeys.length);
    for (k in defaultKeys) {
      Assert.contains(k, orderedKeys);
      Assert.equals(map[k], omap[k]);
    }
    for (k in orderedKeys) {
      Assert.contains(k, defaultKeys);
      Assert.equals(omap[k], map[k]);
    }

    var newKey = 123;
    var newValue = "newValue";
    omap[newKey] = newValue;
    Assert.isTrue(map.exists(newKey));

    /* cannot modify read-only inner map */
    Assert.raises(function() {
      omap.getInnerMap()[newKey] = newValue;
    });

    _testMap(cast map, newKey, "newer value for int key");
  }

  function testOObjectMap() {
    new TestOrderedObjectMap().setup();
    var omap = TestOrderedObjectMap.buildOrderedMapFrom(TestOrderedObjectMap.keys, TestOrderedObjectMap.stringValues);

    var map = omap.getInnerMap();
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    var defaultKeys = TestUtils.iteratorToArray(omap.getInnerMap().keys());

    Assert.notEquals(map, omap);
    Assert.equals(defaultKeys.length, orderedKeys.length);
    for (k in defaultKeys) {
      Assert.contains(k, orderedKeys);
      Assert.equals(map[k], omap[k]);
    }
    for (k in orderedKeys) {
      Assert.contains(k, defaultKeys);
      Assert.equals(omap[k], map[k]);
    }

    var newKey = {name: "newKey"};
    var newValue = "newValue";
    omap[newKey] = newValue;
    Assert.isTrue(map.exists(newKey));

    /* cannot modify read-only inner map */
    Assert.raises(function() {
      omap.getInnerMap()[newKey] = newValue;
    });

    _testMap(cast map, newKey, "newer value for obj key");
  }

  function testOEnumValueMap() {
    new TestOrderedEnumValueMap().setup();
    var omap = TestOrderedEnumValueMap.buildOrderedMapFrom(TestOrderedEnumValueMap.keys, TestOrderedEnumValueMap.stringValues);

    var map = omap.getInnerMap();
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    var defaultKeys = TestUtils.iteratorToArray(omap.getInnerMap().keys());

    Assert.notEquals(map, omap);
    Assert.equals(defaultKeys.length, orderedKeys.length);
    for (k in defaultKeys) {
      Assert.contains(k, orderedKeys);
      Assert.equals(map[k], omap[k]);
    }
    for (k in orderedKeys) {
      Assert.contains(k, defaultKeys);
      Assert.equals(omap[k], map[k]);
    }

    var newKey = EConst(CString("newKey"));
    var newValue = "newValue";
    omap[newKey] = newValue;
    Assert.isTrue(map.exists(newKey));

    /* cannot modify read-only inner map */
    Assert.raises(function() {
      omap.getInnerMap()[newKey] = newValue;
    });

    _testMap(cast map, newKey, "newer value for enum key");
  }
}
