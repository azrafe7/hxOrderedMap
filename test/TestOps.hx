import utest.Assert;

class TestOps extends utest.Test {

  public function new() {
    super();
  }

  function testOStringMap() {
    new TestOrderedStringMap().setup();
    var omap = TestOrderedStringMap.buildOrderedMapFrom(TestOrderedStringMap.keys, TestOrderedStringMap.stringValues);

    var k = TestOrderedStringMap.keys[2];
    Assert.isTrue(omap.exists(k));
    omap.remove(k);
    Assert.isFalse(omap.exists(k));

    var v = TestOrderedStringMap.stringValues[2];
    omap[k] = v;
    Assert.isTrue(omap.exists(k) && omap[k] == v);
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    Assert.equals(k, orderedKeys[orderedKeys.length - 1]);
  }

  function testOIntMap() {
    new TestOrderedIntMap().setup();
    var omap = TestOrderedIntMap.buildOrderedMapFrom(TestOrderedIntMap.keys, TestOrderedIntMap.stringValues);

    var k = TestOrderedIntMap.keys[2];
    Assert.isTrue(omap.exists(k));
    omap.remove(k);
    Assert.isFalse(omap.exists(k));

    var v = TestOrderedIntMap.stringValues[2];
    omap[k] = v;
    Assert.isTrue(omap.exists(k) && omap[k] == v);
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    Assert.equals(k, orderedKeys[orderedKeys.length - 1]);
  }

  function testOObjectMap() {
    new TestOrderedObjectMap().setup();
    var omap = TestOrderedObjectMap.buildOrderedMapFrom(TestOrderedObjectMap.keys, TestOrderedObjectMap.stringValues);

    var k = TestOrderedObjectMap.keys[2];
    Assert.isTrue(omap.exists(k));
    omap.remove(k);
    Assert.isFalse(omap.exists(k));

    var v = TestOrderedObjectMap.stringValues[2];
    omap[k] = v;
    Assert.isTrue(omap.exists(k) && omap[k] == v);
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    Assert.equals(k, orderedKeys[orderedKeys.length - 1]);
  }

  function testOEnumValueMap() {
    new TestOrderedEnumValueMap().setup();
    var omap = TestOrderedEnumValueMap.buildOrderedMapFrom(TestOrderedEnumValueMap.keys, TestOrderedEnumValueMap.stringValues);

    var k = TestOrderedEnumValueMap.keys[2];
    Assert.isTrue(omap.exists(k));
    omap.remove(k);
    Assert.isFalse(omap.exists(k));

    var v = TestOrderedEnumValueMap.stringValues[2];
    omap[k] = v;
    Assert.isTrue(omap.exists(k) && omap[k] == v);
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    Assert.equals(k, orderedKeys[orderedKeys.length - 1]);
  }
}
