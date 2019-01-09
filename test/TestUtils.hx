class TestUtils {

  public static function iteratorToArray<K>(iterator:Iterator<K>):Array<K> {
    var array = [];

    for (i in iterator) {
      array.push(i);
    }

    return array;
  }

  public static function detectedTarget():String {
  // @formatter:off
    return
    #if eval
      EVAL;
    #elseif flash
      FLASH;
    #elseif (js && nodejs)
      NODEJS;
    #elseif js
      JS;
    #elseif cpp
      CPP;
    #elseif neko
      NEKO;
    #elseif hl
      HL;
    #elseif cs
      CS;
    #elseif java
      JAVA;
    #elseif python
      PYTHON;
    #elseif php
      PHP;
    #elseif lua
      LUA;
    #else
      UNKNOWN;
    #end
  // @formatter:on
  }

  #if (!macro) macro #end
  static public function getDefines():haxe.macro.Expr {
    var defines:Map<String, String> = haxe.macro.Context.getDefines();
    var buffer = new StringBuf();
    for (key in defines.keys()) {
      var keyValue = ('  ' + key + '="' + Std.string(defines.get(key)) + '"\n');
      buffer.add(keyValue);
    }
    return macro $v{buffer.toString()};
  }
}

@:enum abstract TargetType(String) to String {
  var EVAL = "eval";
  var FLASH = "flash";
  var NODEJS = "nodejs";
  var JS = "js";
  var CPP = "cpp";
  var NEKO = "neko";
  var HL = "hl";
  var CS = "cs";
  var JAVA = "java";
  var PYTHON = "python";
  var PHP = "php";
  var LUA = "lua";
  var UNKNOWN = "unknown";
}
