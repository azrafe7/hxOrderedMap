import haxe.io.Path;
import haxe.macro.Compiler;
import haxe.macro.Context;
import sys.FileSystem;
import sys.io.File;

using StringTools;

// used only for testing on cpp
// not needed when compiling with -lib hxOrderedMap
// see https://github.com/HaxeFoundation/haxe/issues/7592
class PatchCppOutput {

  // run with --macro PatchCppOutput.use()
  static public function use() {
    if (Context.defined("cpp")) {
      trace("--- PatchCppOutput.use()");
      Compiler.define("no-compilation", "1");
      Context.onAfterGenerate(afterGenerate);
    } else {
      trace("--- [SKIP] PatchCppOutput.use()");
    }
  }

  // [cpp only] comment out some methods that are generated twice
  static public function afterGenerate() {
    function replaceDups(fileName:String, regexString:String, replaceWith:String):Void {
      var result = "";
      trace('Patching "$fileName"...');
      if (!FileSystem.exists(fileName)) {
        throw 'ERROR: "$fileName" not found.';
      } else {
        var text = File.getContent(fileName);
        var regex = new EReg(regexString, "m");
        if (!regex.match(text)) {
          throw "ERROR: Pattern not found.";
        } else {
          var matchInfo = regex.matchedPos();
          result = text.substring(0, matchInfo.pos + matchInfo.len);
          var remainingText = text.substring(matchInfo.pos + matchInfo.len);
          regex = new EReg(regexString, "mg"); // global
          result += regex.replace(remainingText, replaceWith);
        }
      }
      File.saveContent(fileName, result);
    }

    var outputDir = Compiler.getOutput();

    var typesToPatch = ["OrderedStringMapImpl", "OrderedIntMapImpl"];
    for (typeName in typesToPatch) {
      var hFileName = Path.join([outputDir, "include", typeName + ".h"]);
      var cppFileName = Path.join([outputDir, "src", typeName + ".cpp"]);

      // .h
      replaceDups(hFileName, "(s*void set_[^\n]+)$", '\n// PATCHED \n/*$1*/');
      trace("Done.");
      // .cpp
      replaceDups(cppFileName, "(void " + typeName + "_obj::set_[^}]+})$", '\n// PATCHED \n/*$1*/');
      trace("Done.");
    }

    runHxcpp(outputDir);
  }

  // mimick gencpp.ml code (search for "haxelib run hxcpp")
  static function runHxcpp(buildXmlDir:String):Void {
    function escapeCommand(cmd:String):String {
      return ~/(["\\])/g.replace(cmd, "\\$1");
    }

    var cwd = Sys.getCwd();
    Sys.setCwd(buildXmlDir);
    var hxcppCommand = ["haxelib", "run", "hxcpp", "Build.xml", "haxe"];

    // add defines
    var defines = Context.getDefines();
    var skipDefines = ["true", "sys", "dce", "cpp", "debug"];
    if (Context.defined("debug"))
      hxcppCommand.push("-Ddebug");
    for (k in defines.keys()) {
      if (skipDefines.indexOf(k) >= 0)
        continue;
      else
        hxcppCommand.push('-D' + k + '="' + escapeCommand(defines[k]) + '"');
    }

    // include classpaths
    for (path in Context.getClassPath()) {
      hxcppCommand.push('-I"' + escapeCommand(path) + '"');
    }

    // run
    trace("Running hxcpp...\n" + hxcppCommand.join(" ") + "\n");
    var exitCode = Sys.command(hxcppCommand.shift(), hxcppCommand);
    if (exitCode != 0)
      trace("Build failed (exitCode: " + exitCode + ").");
    Sys.setCwd(cwd);
  }
}
