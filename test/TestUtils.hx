class TestUtils {
  public static function iteratorToArray<K>(iterator:Iterator<K>):Array<K> {
    var array = [];
    for (i in iterator) {
      array.push(i);
    }
    return array;
  }
}
