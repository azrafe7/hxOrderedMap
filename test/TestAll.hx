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
    var target = TestUtils.detectedTarget().toUpperCase();
    var forceExtendIMap = #if force_extend_imap true #else false #end;
    trace("DETECTED TARGET  : " + target);
    trace("FORCE_EXTEND_IMAP: " + forceExtendIMap + "\n");

    utest.UTest.run([
      new TestOrderedStringMap(),
      new TestOrderedIntMap(),
      new TestOrderedObjectMap(),
      new TestOrderedEnumValueMap(),
      new TestOrderedMapCloning(),
      new TestOrderedMapOps(),
      new TestOrderedMapExtraOps(),
      new TestInnerMap(),
    ]);
  }

}
