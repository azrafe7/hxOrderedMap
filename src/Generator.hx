import haxe.io.Path;
#if !sys
  #error "Can be used only on sys targets"
#end
import sys.io.File;

using StringTools;

class Generator {

  static var templateFile = "./src/Ordered_TYPE_Map.template.hx";
  
  static function main() {
    var args = Sys.args();
    trace(args);
    
    if (args.length < 1) throw "You must pass a type to generator. E.g.: Generator Int";
    
    generateFor(args[0]);
  }
  
  static function generateFor(type:String, outputFolder:String = "") {
    var outputType = templateFile.replace("_TYPE_", type).replace(".template", "");
    var outputPath = Path.join([outputFolder, outputType]);

    var template = File.getContent(templateFile);
    var output = template.replace("_TYPE_", type);
    
    File.saveContent(outputPath, output);
    trace('File generated and saved in $outputPath.');
  }
}