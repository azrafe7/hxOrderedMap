import hxbenchmark.SuiteResult;
import hxbenchmark.ResultPrinter;
import TravisUtils.*;
import TestUtils.TargetType;

class Bench {
  static inline var RUN_BENCHMARKS = true;

	static function main() {
    /**
      BENCHMARKS

      these run after each target's tests (so all dependencies are already set up)
      and only for the targets that can write to the console
    */
    var target = TestUtils.detectedTarget();
    var isBenchable = [EVAL, NEKO, LUA, PHP, CPP, JAVA, CS, PYTHON, HL, /*Node*/JS].indexOf(target) >= 0;
    if (RUN_BENCHMARKS && isBenchable) {

      Sys.println('travis_fold:start:bench-${target}');

      var cases = Macro.getCases("cases");
      var printer = new ResultPrinter();
      function print(result:SuiteResult) {
        Sys.println(printer.print(result));
      }

      for (benchCase in cases) {
        Sys.println('Case: ${benchCase.name}');
        benchCase.exec.run(print);
      }

      Sys.println('travis_fold:end:bench-${target}');
    }
	}
}