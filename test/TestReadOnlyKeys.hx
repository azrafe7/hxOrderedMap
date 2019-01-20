import utest.Assert;

class TestReadOnlyKeys extends utest.Test {

  public function new() {
    super();
  }

  function testOStringMap() {
    new TestOrderedStringMap().setup();
    var keys = TestOrderedStringMap.keys;
    var values = TestOrderedStringMap.stringValues;
    var omap = TestOrderedStringMap.buildOrderedMapFrom(keys, values);

    var readOnlyKeys = omap.orderedKeys;
    // readOnlyKeys[0] = values[0]; // compiler error

    // make it writeable
    var writeableKeys:Array<String> = cast readOnlyKeys;

    // reverse keys

    writeableKeys.reverse();
    keys.reverse();
    Assert.same(keys, TestUtils.iteratorToArray(omap.keys()));

    values.reverse();
    var omapValues = [for (v in omap.iterator()) v];
    Assert.same(values, omapValues);
  }

  function testOIntMap() {
    new TestOrderedIntMap().setup();
    var keys = TestOrderedIntMap.keys;
    var values = TestOrderedIntMap.stringValues;
    var omap = TestOrderedIntMap.buildOrderedMapFrom(keys, values);

    var readOnlyKeys = omap.orderedKeys;
    // readOnlyKeys[0] = values[0]; // compiler error

    // make it writeable
    var writeableKeys:Array<Int> = cast readOnlyKeys;

    // reverse keys

    writeableKeys.reverse();
    keys.reverse();
    Assert.same(keys, TestUtils.iteratorToArray(omap.keys()));

    values.reverse();
    var omapValues = [for (v in omap.iterator()) v];
    Assert.same(values, omapValues);
  }

  function testOObjectMap() {
    new TestOrderedObjectMap().setup();
    var keys = TestOrderedObjectMap.keys;
    var values = TestOrderedObjectMap.stringValues;
    var omap = TestOrderedObjectMap.buildOrderedMapFrom(keys, values);

    var readOnlyKeys = omap.orderedKeys;
    // readOnlyKeys[0] = values[0]; // compiler error

    // make it writeable
    var writeableKeys:Array<{}> = cast readOnlyKeys;

    // reverse keys

    writeableKeys.reverse();
    keys.reverse();
    Assert.same(keys, TestUtils.iteratorToArray(omap.keys()));

    values.reverse();
    var omapValues = [for (v in omap.iterator()) v];
    Assert.same(values, omapValues);
  }

  function testOEnumValueMap() {
    new TestOrderedEnumValueMap().setup();
    var keys = TestOrderedEnumValueMap.keys;
    var values = TestOrderedEnumValueMap.stringValues;
    var omap = TestOrderedEnumValueMap.buildOrderedMapFrom(keys, values);

    var readOnlyKeys = omap.orderedKeys;
    // readOnlyKeys[0] = values[0]; // compiler error

    // make it writeable
    var writeableKeys:Array<EnumValue> = cast readOnlyKeys;

    // reverse keys

    writeableKeys.reverse();
    keys.reverse();
    Assert.same(keys, TestUtils.iteratorToArray(omap.keys()));

    values.reverse();
    var omapValues = [for (v in omap.iterator()) v];
    Assert.same(values, omapValues);
  }
}
