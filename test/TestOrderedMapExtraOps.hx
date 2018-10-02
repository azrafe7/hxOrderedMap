import utest.Assert;

class TestOrderedMapExtraOps extends utest.Test {
  public function new() {
    super();
  }

  function testOrderedStringMapExtraOps() {
    new TestOrderedStringMap().setup();
    var omap = TestOrderedStringMap.buildOrderedMapFrom(TestOrderedStringMap.keys, TestOrderedStringMap.stringValues);

    var keysCopy = omap.orderedKeysCopy;
    Assert.notEquals(keysCopy, @:privateAccess (omap:OrderedStringMap<String>).orderedKeys);
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
    
    var accessOMap = new OrderedStringMap();
    accessOMap[keysCopy[0]] = TestOrderedStringMap.stringValues[0];
  }

  function testOrderedIntMapExtraOps() {
    new TestOrderedIntMap().setup();
    var omap = TestOrderedIntMap.buildOrderedMapFrom(TestOrderedIntMap.keys, TestOrderedIntMap.stringValues);

    var keysCopy = omap.orderedKeysCopy;
    Assert.notEquals(keysCopy, @:privateAccess (omap:OrderedIntMap<String>).orderedKeys);
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
    
    var accessOMap = new OrderedIntMap();
    accessOMap[keysCopy[0]] = TestOrderedIntMap.stringValues[0];
  }

  function testOrderedObjectMapExtraOps() {
    new TestOrderedObjectMap().setup();
    var omap = TestOrderedObjectMap.buildOrderedMapFrom(TestOrderedObjectMap.keys, TestOrderedObjectMap.stringValues);

    var keysCopy = omap.orderedKeysCopy;
    Assert.notEquals(keysCopy, @:privateAccess (omap:OrderedObjectMap<{}, String>).orderedKeys);
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
    
    var accessOMap = new OrderedObjectMap();
    accessOMap[keysCopy[0]] = TestOrderedObjectMap.stringValues[0];
  }

  function testOrderedEnumValueMapExtraOps() {
    new TestOrderedEnumValueMap().setup();
    var omap = TestOrderedEnumValueMap.buildOrderedMapFrom(TestOrderedEnumValueMap.keys, TestOrderedEnumValueMap.stringValues);

    var keysCopy = omap.orderedKeysCopy;
    Assert.notEquals(keysCopy, @:privateAccess (omap:OrderedEnumValueMap<EnumValue, String>).orderedKeys);
    Assert.same(TestUtils.iteratorToArray(omap.keys()), keysCopy);

    var len = omap.length;
    omap.remove(keysCopy[1]);
    Assert.equals(len - 1, omap.length);

    omap.clear();
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
    
    var accessOMap = new OrderedEnumValueMap();
    accessOMap[keysCopy[0]] = TestOrderedEnumValueMap.stringValues[0];
  }
}
