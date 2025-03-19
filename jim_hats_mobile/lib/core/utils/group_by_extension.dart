extension GroupByExtension<T> on Iterable<T> {
  Map<K, List<T>> groupBy<K>(K Function(T) key) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final k = key(element);
      if (!map.containsKey(k)) {
        map[k] = [];
      }
      map[k]!.add(element);
    }
    return map;
  }
}
