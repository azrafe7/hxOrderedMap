import utest.Assert;

class TestFromKeysAndValues extends utest.Test {

  public function new() {
    super();
  }

#if (eval || macro)
  @Ignored("skipped (not supported on eval)")
  function tests() {}
#else

  function testEmpty()
  {
    var omap:OrderedMap<Int,Int> = OrderedMap.fromKeysAndValues([], []);
    Assert.isTrue(omap.keysCopy().length == 0);
  }

  function testInvalidKeysOrValues()
  {
    Assert.raises(function () {
      var omap = OrderedMap.fromKeysAndValues([1], [1,2]);
    });
    Assert.raises(function () {
      var omap = OrderedMap.fromKeysAndValues([1,2], [1]);
    });
  }

  function testOStringMap() {
    new TestOrderedStringMap().setup();
    var omap = OrderedMap.fromKeysAndValues(TestOrderedStringMap.keys, TestOrderedStringMap.stringValues);

    var keys = TestUtils.iteratorToArray(omap.keys());
    Assert.same(keys, TestOrderedStringMap.keys);

    var values = TestUtils.iteratorToArray(omap.iterator());
    Assert.same(values, TestOrderedStringMap.stringValues);
  }

  function testOIntMap() {
    new TestOrderedIntMap().setup();
    var omap = OrderedMap.fromKeysAndValues(TestOrderedIntMap.keys, TestOrderedIntMap.stringValues);

    var keys = TestUtils.iteratorToArray(omap.keys());
    Assert.same(keys, TestOrderedIntMap.keys);

    var values = TestUtils.iteratorToArray(omap.iterator());
    Assert.same(values, TestOrderedIntMap.stringValues);
  }

  function testOObjectMap() {
    new TestOrderedObjectMap().setup();
    var omap = OrderedMap.fromKeysAndValues(TestOrderedObjectMap.keys, TestOrderedObjectMap.stringValues);

    var keys = TestUtils.iteratorToArray(omap.keys());
    Assert.same(keys, TestOrderedObjectMap.keys);

    var values = TestUtils.iteratorToArray(omap.iterator());
    Assert.same(values, TestOrderedObjectMap.stringValues);
  }

  function testOEnumValueMap() {
    new TestOrderedEnumValueMap().setup();
    var omap = OrderedMap.fromKeysAndValues(TestOrderedEnumValueMap.keys, TestOrderedEnumValueMap.stringValues);

    var keys = TestUtils.iteratorToArray(omap.keys());
    Assert.same(keys, TestOrderedEnumValueMap.keys);

    var values = TestUtils.iteratorToArray(omap.iterator());
    Assert.same(values, TestOrderedEnumValueMap.stringValues);
  }
#end
}
