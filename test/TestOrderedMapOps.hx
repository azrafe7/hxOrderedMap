import utest.Assert;

class TestOrderedMapOps extends utest.Test {

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

    for (k in omap.keys())
      Assert.isTrue(omap.remove(k));
    Assert.isFalse(omap.remove(k));

    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }
}
