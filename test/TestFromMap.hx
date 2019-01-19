import utest.Assert;

class TestFromMap extends utest.Test {

  public function new() {
    super();
  }

#if (eval || macro)
  @Ignored("skipped (not supported on eval)")
  function tests() {}
#else
  function testEmpty() {
    var map = new Map<Int, Int>();
    var omap = OrderedMap.fromMap(map);
    Assert.isTrue(omap.keysCopy().length == 0);
  }

  function testOStringMap() {
    new TestOrderedStringMap().setup();
    var keys = TestOrderedStringMap.keys;
    var values = TestOrderedStringMap.stringValues;
    var map = TestOrderedStringMap.buildMapFrom(keys, values);

    var omap = OrderedMap.fromMap(map);
    Assert.equals(TestUtils.iteratorToArray(map.keys()).length, omap.keysCopy().length);
    Assert.equals(map, omap.getInnerMap());

    var sliceLen = 3;
    var slice = keys.slice(0, sliceLen);
    for (i in 0...sliceLen) {
      omap.remove(slice[i]);
      omap.set(slice[i], values[i]);
    }
    var orderedKeys = @:privateAccess (omap:OrderedStringMap<String>).orderedKeys;
    Assert.same(slice, orderedKeys.slice(orderedKeys.length - sliceLen));

    Assert.equals(map, omap.getInnerMap());
  }

  function testOIntMap() {
    new TestOrderedIntMap().setup();
    var keys = TestOrderedIntMap.keys;
    var values = TestOrderedIntMap.stringValues;
    var map = TestOrderedIntMap.buildMapFrom(keys, values);

    var omap = OrderedMap.fromMap(map);
    Assert.equals(TestUtils.iteratorToArray(map.keys()).length, omap.keysCopy().length);
    Assert.equals(map, omap.getInnerMap());

    var sliceLen = 3;
    var slice = keys.slice(0, sliceLen);
    for (i in 0...sliceLen) {
      omap.remove(slice[i]);
      omap.set(slice[i], values[i]);
    }
    var orderedKeys = @:privateAccess (omap:OrderedIntMap<String>).orderedKeys;
    Assert.same(slice, orderedKeys.slice(orderedKeys.length - sliceLen));

    Assert.equals(map, omap.getInnerMap());
  }

  function testOObjectMap() {
    new TestOrderedObjectMap().setup();
    var keys = TestOrderedObjectMap.keys;
    var values = TestOrderedObjectMap.stringValues;
    var map = TestOrderedObjectMap.buildMapFrom(keys, values);

    var omap = OrderedMap.fromMap(map);
    Assert.equals(TestUtils.iteratorToArray(map.keys()).length, omap.keysCopy().length);
    Assert.equals(map, omap.getInnerMap());

    var sliceLen = 3;
    var slice = keys.slice(0, sliceLen);
    for (i in 0...sliceLen) {
      omap.remove(slice[i]);
      omap.set(slice[i], values[i]);
    }
    var orderedKeys = @:privateAccess (omap:OrderedObjectMap<{}, String>).orderedKeys;
    Assert.same(slice, orderedKeys.slice(orderedKeys.length - sliceLen));

    Assert.equals(map, omap.getInnerMap());
  }

  function testOEnumValueMap() {
    new TestOrderedEnumValueMap().setup();
    var keys = TestOrderedEnumValueMap.keys;
    var values = TestOrderedEnumValueMap.stringValues;
    var map = TestOrderedEnumValueMap.buildMapFrom(keys, values);

    var omap = OrderedMap.fromMap(map);
    Assert.equals(TestUtils.iteratorToArray(map.keys()).length, omap.keysCopy().length);
    Assert.equals(map, omap.getInnerMap());

    var sliceLen = 3;
    var slice = keys.slice(0, sliceLen);
    for (i in 0...sliceLen) {
      omap.remove(slice[i]);
      omap.set(slice[i], values[i]);
    }
    var orderedKeys = @:privateAccess (omap:OrderedEnumValueMap<EnumValue, String>).orderedKeys;
    Assert.same(slice, orderedKeys.slice(orderedKeys.length - sliceLen));

    Assert.equals(map, omap.getInnerMap());
  }
#end
}
