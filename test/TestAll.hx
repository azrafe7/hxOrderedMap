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
    utest.UTest.run([
      new TestOrderedStringMap(),
      new TestOrderedIntMap(),
      new TestOrderedObjectMap(),
      new TestOrderedEnumValueMap(),
      new TestOrderedMapCloning(),
      new TestOrderedMapOps(),
      new TestOrderedMapExtraOps(),
    ]);
  }
}
