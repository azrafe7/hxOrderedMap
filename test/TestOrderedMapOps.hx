import utest.Assert;

class TestOrderedMapOps extends utest.Test {
  public function new() {
    super();
  }

  function testOrderedStringMapOps() {
    new TestOrderedStringMap().setup();
    var omap = TestOrderedStringMap.buildOrderedMapFrom(TestOrderedStringMap.keys, TestOrderedStringMap.stringValues);

    var k = TestOrderedStringMap.keys[2];
    Assert.isTrue(omap.exists(k));
    omap.remove(k);
    Assert.isFalse(omap.exists(k));

    var v = TestOrderedStringMap.stringValues[2];
    omap.set(k, v);
    Assert.isTrue(omap.exists(k) && omap[k] == v);
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    Assert.equals(k, orderedKeys[orderedKeys.length - 1]);

    for (k in omap.keys())
      omap.remove(k);
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }

  function testOrderedIntMapOps() {
    new TestOrderedIntMap().setup();
    var omap = TestOrderedIntMap.buildOrderedMapFrom(TestOrderedIntMap.keys, TestOrderedIntMap.stringValues);

    var k = TestOrderedIntMap.keys[2];
    Assert.isTrue(omap.exists(k));
    omap.remove(k);
    Assert.isFalse(omap.exists(k));

    var v = TestOrderedIntMap.stringValues[2];
    omap.set(k, v);
    Assert.isTrue(omap.exists(k) && omap[k] == v);
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    Assert.equals(k, orderedKeys[orderedKeys.length - 1]);

    for (k in omap.keys())
      omap.remove(k);
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }

  function testOrderedObjectMapOps() {
    new TestOrderedObjectMap().setup();
    var omap = TestOrderedObjectMap.buildOrderedMapFrom(TestOrderedObjectMap.keys, TestOrderedObjectMap.stringValues);

    var k = TestOrderedObjectMap.keys[2];
    Assert.isTrue(omap.exists(k));
    omap.remove(k);
    Assert.isFalse(omap.exists(k));

    var v = TestOrderedObjectMap.stringValues[2];
    omap.set(k, v);
    Assert.isTrue(omap.exists(k) && omap[k] == v);
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    Assert.equals(k, orderedKeys[orderedKeys.length - 1]);

    for (k in omap.keys())
      omap.remove(k);
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }

  function testOrderedEnumValueMapOps() {
    new TestOrderedEnumValueMap().setup();
    var omap = TestOrderedEnumValueMap.buildOrderedMapFrom(TestOrderedEnumValueMap.keys, TestOrderedEnumValueMap.stringValues);

    var k = TestOrderedEnumValueMap.keys[2];
    Assert.isTrue(omap.exists(k));
    omap.remove(k);
    Assert.isFalse(omap.exists(k));

    var v = TestOrderedEnumValueMap.stringValues[2];
    omap.set(k, v);
    Assert.isTrue(omap.exists(k) && omap[k] == v);
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    Assert.equals(k, orderedKeys[orderedKeys.length - 1]);

    for (k in omap.keys())
      omap.remove(k);
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }
}
