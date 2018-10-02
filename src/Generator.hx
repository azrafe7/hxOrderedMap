import haxe.Json;
import haxe.io.Path;
#if !sys
#error "Can be used only on sys targets"
#end
import sys.io.File;

using StringTools;

typedef Replacer = {
  var what:String;
  var with:String;
}

class Generator {
  static var templateFiles = [
    "./src/Ordered_TYPE_Map.template.hx",
    "./test/TestAll.template.hx",
    "./test/TestOrdered_TYPE_Map.template.hx",
  ];
  static var replacers:Array<Replacer> = [];

  static function main() {
    var args = Sys.args();

    if (args.length < 1)
      throw 'You must pass replacers definitions to the generator. \n  e.g.: Generator "_TYPE_=Object _KEY_={}"';

    var defs = args[0].split(" ");
    for (d in defs) {
      var p = d.split("=");
      replacers.push({what: p[0], with: p[1]});
    }

    Sys.println("\nReplacers:");
    Sys.println(" " + [for (r in replacers) '${r.with} => ${r.what}']);
    Sys.println("");

    generate(templateFiles, replacers);
  }

  static function generate(templateFiles:Array<String>, replacers:Array<Replacer>) {
    for (tf in templateFiles) {
      var outputFile = tf.replace(".template", "");
      for (rep in replacers) {
        outputFile = outputFile.replace(rep.what, rep.with);
      }
      Sys.println("Processing " + tf + " => " + outputFile + " ...");
      var template = File.getContent(tf);
      var output = template;
      for (rep in replacers) {
        output = output.replace(rep.what, rep.with);
      }

      File.saveContent(outputFile, output);
      Sys.println(' [OK]');
    }
  }
}
