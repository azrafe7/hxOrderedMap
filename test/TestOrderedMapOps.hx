import utest.Assert;

class TestOrderedMapOps extends utest.Test {

  public function new() {
    super();
  }

  function testOrderedEnumValueMapOps() {
    new TestOrderedEnumValueMap().setup();
    var omap = TestOrderedEnumValueMap.buildOrderedMapFrom(TestOrderedEnumValueMap.keys, TestOrderedEnumValueMap.stringValues);
    
    trace(omap);
    var k = TestOrderedEnumValueMap.keys[2];
    Assert.isTrue(omap.exists(k));
    omap.remove(k);
    Assert.isFalse(omap.exists(k));
    
    var v = TestOrderedEnumValueMap.stringValues[2];
    omap.set(k, v);
    Assert.isTrue(omap.exists(k) && omap[k] == v);
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    Assert.equals(k, orderedKeys[orderedKeys.length - 1]);
    
    trace(omap);
    for (k in omap.keys()) omap.remove(k);
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }


  function testOrderedIntMapOps() {
    new TestOrderedIntMap().setup();
    var omap = TestOrderedIntMap.buildOrderedMapFrom(TestOrderedIntMap.keys, TestOrderedIntMap.stringValues);
    
    trace(omap);
    var k = TestOrderedIntMap.keys[2];
    Assert.isTrue(omap.exists(k));
    omap.remove(k);
    Assert.isFalse(omap.exists(k));
    
    var v = TestOrderedIntMap.stringValues[2];
    omap.set(k, v);
    Assert.isTrue(omap.exists(k) && omap[k] == v);
    var orderedKeys = TestUtils.iteratorToArray(omap.keys());
    Assert.equals(k, orderedKeys[orderedKeys.length - 1]);
    
    trace(omap);
    var it = TestUtils.iteratorToArray(omap.keys());
    for (k2 in omap.keys()) {
      
      omap.remove(k2);
      trace("  " + k2 + " :" + omap);
    }
    Assert.equals(0, TestUtils.iteratorToArray(omap.iterator()).length);
  }

}
