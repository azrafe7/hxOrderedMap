import utest.Assert;

class TestOrderedMapCloning extends utest.Test {

  public function new() {
    super();
  }


  function testOStringMap() {
    new TestOrderedStringMap().setup();
    var omap = TestOrderedStringMap.buildOrderedMapFrom(TestOrderedStringMap.keys, TestOrderedStringMap.stringValues);
    var omapClone = omap.copy();

    Assert.isFalse(omap == omapClone);

    var keys = TestUtils.iteratorToArray(omap.keys());
    var keysClone = TestUtils.iteratorToArray(omapClone.keys());

    Assert.isTrue(keys.length == keysClone.length && keys.length > 0);
    Assert.same(keys, keysClone);

    var values = TestUtils.iteratorToArray(omap.iterator());
    var valuesClone = TestUtils.iteratorToArray(omapClone.iterator());

    Assert.isTrue(values.length == valuesClone.length && values.length > 0);
    Assert.same(values, valuesClone);
  }
}
