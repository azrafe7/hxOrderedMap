class TravisUtils {

  static public function successMsg(msg:String):Void {
  #if (sys || nodejs)
    Sys.println('\x1b[32m' + msg + '\x1b[0m');
  #end
  }

  static public function failMsg(msg:String):Void {
  #if (sys || nodejs)
    Sys.println('\x1b[31m' + msg + '\x1b[0m');
  #end
  }

  static public function infoMsg(msg:String):Void {
  #if (sys || nodejs)
    Sys.println('\x1b[36m' + msg + '\x1b[0m');
  #end
  }
}
