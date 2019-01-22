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
    var isBenchable = [EVAL, NEKO, LUA, PHP, CPP, JAVA, CS, PYTHON, HL, NODEJS].indexOf(target) >= 0;

  #if !(sys || nodejs)
    trace("Skipping benchmarks for " + target + " (doesn't support Sys.println())");
  #else

    if (RUN_BENCHMARKS && isBenchable) {

      infoMsg('travis_fold:start:bench-${target}');
      Sys.println("DEFINES: \n" + TestUtils.getDefines());
      Sys.println("TARGET: " + target + "\n");

      var cases = Macro.getCases("cases");
      var printer = new ResultPrinter();
      function print(result:SuiteResult) {
        Sys.println(printer.print(result));
      }

      for (benchCase in cases) {
        Sys.println('Case: ${benchCase.name}');
        benchCase.exec.run(print);
      }

      infoMsg('travis_fold:end:bench-${target}');
    }
  #end
	}
}