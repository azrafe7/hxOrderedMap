import utest.Assert;

class TestRemove extends utest.Test {

  public function new() {
    super();
  }

  function testOStringMap() {
    new TestOrderedStringMap().setup();
    var keys = TestOrderedStringMap.keys;
    var values = TestOrderedStringMap.stringValues;
    var omap = TestOrderedStringMap.buildOrderedMapFrom(keys, values);

    var k2 = TestOrderedStringMap.keys[2];

    // use keysCopy() (and not keys()!) to remove items from the map
    for (key in omap.keysCopy())
      Assert.isTrue(omap.remove(key));
    Assert.isFalse(omap.remove(k2));

    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }

  function testOIntMap() {
    new TestOrderedIntMap().setup();
    var keys = TestOrderedIntMap.keys;
    var values = TestOrderedIntMap.stringValues;
    var omap = TestOrderedIntMap.buildOrderedMapFrom(keys, values);

    var k2 = TestOrderedIntMap.keys[2];

    // use keysCopy() (and not keys()!) to remove items from the map
    for (key in omap.keysCopy())
      Assert.isTrue(omap.remove(key));
    Assert.isFalse(omap.remove(k2));

    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }

  function testOObjectMap() {
    new TestOrderedObjectMap().setup();
    var keys = TestOrderedObjectMap.keys;
    var values = TestOrderedObjectMap.stringValues;
    var omap = TestOrderedObjectMap.buildOrderedMapFrom(keys, values);

    var k2 = TestOrderedObjectMap.keys[2];

    // use keysCopy() (and not keys()!) to remove items from the map
    for (key in omap.keysCopy())
      Assert.isTrue(omap.remove(key));
    Assert.isFalse(omap.remove(k2));

    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }

  function testOEnumValueMap() {
    new TestOrderedEnumValueMap().setup();
    var keys = TestOrderedEnumValueMap.keys;
    var values = TestOrderedEnumValueMap.stringValues;
    var omap = TestOrderedEnumValueMap.buildOrderedMapFrom(keys, values);

    var k2 = TestOrderedEnumValueMap.keys[2];

    // use keysCopy() (and not keys()!) to remove items from the map
    for (key in omap.keysCopy())
      Assert.isTrue(omap.remove(key));
    Assert.isFalse(omap.remove(k2));

    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }
}
