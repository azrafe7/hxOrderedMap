import utest.Assert;

class TestOrderedMapExtraOps extends utest.Test {
  public function new() {
    super();
  }

  function testOrderedStringMapExtraOps() {
    new TestOrderedStringMap().setup();
    var omap = TestOrderedStringMap.buildOrderedMapFrom(TestOrderedStringMap.keys, TestOrderedStringMap.stringValues);

    var keysCopy = omap.orderedKeysCopy;
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }

  function testOrderedIntMapExtraOps() {
    new TestOrderedIntMap().setup();
    var omap = TestOrderedIntMap.buildOrderedMapFrom(TestOrderedIntMap.keys, TestOrderedIntMap.stringValues);

    var keysCopy = omap.orderedKeysCopy;
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }

  function testOrderedObjectMapExtraOps() {
    new TestOrderedObjectMap().setup();
    var omap = TestOrderedObjectMap.buildOrderedMapFrom(TestOrderedObjectMap.keys, TestOrderedObjectMap.stringValues);

    var keysCopy = omap.orderedKeysCopy;
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }

  function testOrderedEnumValueMapExtraOps() {
    new TestOrderedEnumValueMap().setup();
    var omap = TestOrderedEnumValueMap.buildOrderedMapFrom(TestOrderedEnumValueMap.keys, TestOrderedEnumValueMap.stringValues);

    var keysCopy = omap.orderedKeysCopy;
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }
}
