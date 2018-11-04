import utest.Assert;

class TestOrderedMapExtraOps extends utest.Test {

  public function new() {
    super();
  }

  function testOStringMap() {
    new TestOrderedStringMap().setup();
    var omap = TestOrderedStringMap.buildOrderedMapFrom(TestOrderedStringMap.keys, TestOrderedStringMap.stringValues);

    var keysCopy = omap.keysCopy();
    // @formatter:off
    Assert.notEquals(keysCopy, @:privateAccess (omap:OrderedStringMap<String>).orderedKeys);
    // @formatter:on
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);

    var accessOMap = new OrderedStringMap();
    accessOMap[keysCopy[0]] = TestOrderedStringMap.stringValues[0];

    Assert.equals(TestOrderedStringMap.stringValues[0], accessOMap[keysCopy[0]]);
  }
}
