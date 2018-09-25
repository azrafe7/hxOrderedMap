import utest.Runner;
import utest.Test;
import utest.ui.Report;
import utest.Assert;

class TestAll {
	public static function main() {
		utest.UTest.run([new TestOrderedStringMap(), new TestOrderedIntMap(),]);
	}
}
