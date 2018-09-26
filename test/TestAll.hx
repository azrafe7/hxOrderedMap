import utest.Runner;
import utest.Test;
import utest.ui.Report;
import utest.Assert;

class TestAll {
  public static function main() {
    utest.UTest.run([
      new TestOrderedStringMap(),
      new TestOrderedIntMap(),
      new TestOrderedObjectMap(),
      new TestOrderedEnumValueMap(),
      new TestOrderedMapCloning(),
      new TestOrderedMapOps()
    ]);
  }
}
