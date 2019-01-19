import utest.Runner;
import utest.Test;
import utest.ui.Report;
import utest.Assert;
import IOrderedMap;
import OrderedMap;
import OrderedStringMap;
import OrderedIntMap;
import OrderedObjectMap;
import OrderedEnumValueMap;

class TestAll {

  public static function main() {
    var target = TestUtils.detectedTarget();
    trace("DEFINES: \n" + TestUtils.getDefines());
    trace("TARGET: " + target + "\n");

    utest.UTest.run([
      new TestOrderedStringMap(),
      new TestOrderedIntMap(),
      new TestOrderedObjectMap(),
      new TestOrderedEnumValueMap(),
      new TestCloning(),
      new TestOps(),
      new TestExtraOps(),
      new TestInnerMap(),
      new TestKeyValueIterator(),
      new TestFromKeysAndValues(),
      new TestFromMap(),
    ]);
  }
}
