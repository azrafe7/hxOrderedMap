import utest.Assert;

class TestAsPlainMap extends utest.Test {

  public function new() {
    super();
  }

  function _testAsMap<K, V>(map:Map<K, V>, omap:OrderedMap<K, V>) {
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    var defaultKeys = TestUtils.iteratorToArray(omap.getInnerMap().keys());

    trace(map);
    trace(omap);
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
  }

  function testOStringMap() {
    new TestOrderedStringMap().setup();
    var omap = TestOrderedStringMap.buildOrderedMapFrom(TestOrderedStringMap.keys, TestOrderedStringMap.stringValues);

    var map = omap.getInnerMap();
    _testAsMap(map, omap);

    var newKey = "newKey";
    var newValue = "newValue";
    omap.getInnerMap()[newKey] = newValue;
    Assert.isTrue(map.exists(newKey) && omap.exists(newKey));
    Assert.notContains(newKey, omap.keysCopy());
    Assert.contains(newKey, [for (k in map.keys()) k]);
  }

  /*
  function testOIntMap() {
    new TestOrderedIntMap().setup();
    var omap = TestOrderedIntMap.buildOrderedMapFrom(TestOrderedIntMap.keys, TestOrderedIntMap.stringValues);

    var keysCopy = omap.keysCopy();
    // @formatter:off
    Assert.notEquals(keysCopy, @:privateAccess (omap:OrderedIntMap<String>).orderedKeys);
    // @formatter:on
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);

    var accessOMap = new OrderedIntMap();
    accessOMap[keysCopy[0]] = TestOrderedIntMap.stringValues[0];
  }

  function testOObjectMap() {
    new TestOrderedObjectMap().setup();
    var omap = TestOrderedObjectMap.buildOrderedMapFrom(TestOrderedObjectMap.keys, TestOrderedObjectMap.stringValues);

    var keysCopy = omap.keysCopy();
    // @formatter:off
    Assert.notEquals(keysCopy, @:privateAccess (omap:OrderedObjectMap<{}, String>).orderedKeys);
    // @formatter:on
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);

    var accessOMap = new OrderedObjectMap();
    accessOMap[keysCopy[0]] = TestOrderedObjectMap.stringValues[0];
  }

  function testOEnumValueMap() {
    new TestOrderedEnumValueMap().setup();
    var omap = TestOrderedEnumValueMap.buildOrderedMapFrom(TestOrderedEnumValueMap.keys, TestOrderedEnumValueMap.stringValues);

    var keysCopy = omap.keysCopy();
    // @formatter:off
    Assert.notEquals(keysCopy, @:privateAccess (omap:OrderedEnumValueMap<EnumValue, String>).orderedKeys);
    // @formatter:on
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);

    var accessOMap = new OrderedEnumValueMap();
    accessOMap[keysCopy[0]] = TestOrderedEnumValueMap.stringValues[0];
  }
  */
}
