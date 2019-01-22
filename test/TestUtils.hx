class TestUtils {

  public static function iteratorToArray<K>(iterator:Iterator<K>):Array<K> {
    var array = [];

    for (i in iterator) {
      array.push(i);
    }

    return array;
  }

  // @formatter:off
  public static function detectedTarget():TargetType {
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
  // @formatter:on
  /** Fisher-Yates shuffle */
  static public function shuffle<T>(a:Array<T>):Void {
    var len = a.length;
    for (i in 0...len - 1) {
      var j = i + Std.random(len - i);
      swap(a, i, j);
    }
  }

  /** Fisher-Yates shuffle range [lo-hi) */
  static public function shuffleRange<T>(a:Array<T>, lo:Int, hi:Int):Void {
    var len = hi - lo;
    for (i in 0...len - 1) {
      var j = i + Std.random(len - i);
      swap(a, lo + i, lo + j);
    }
  }

  /** Swap item at `i` with item at `j` */
  static public inline function swap<T>(a:Array<T>, i:Int, j:Int):Void {
    var tmp = a[i];
    a[i] = a[j];
    a[j] = tmp;
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
