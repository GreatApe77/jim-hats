///Extension on Iterable for allowing Group by property logic in Iterator implementations.
extension GroupByExtension<T> on Iterable<T> {
  ///Example:
  ///```dart
  ///final users = [
  ///  {
  ///    'name': 'Mateus',
  ///    'birth': '01/01/1999',
  ///  },
  ///  {
  ///    'name': 'Lucas',
  ///    'birth': '02/02/2002',
  ///  },
  ///];
  /// final groupedByBirth = users.groupBy(
  ///  (user) => user['birth'],
  ///);
  ///```
  ///the `groupedByBirth` variable should look like this:
  ///```dart
  ///{
  ///  '01/01/1999': [
  ///    {'name': 'Mateus', 'birth': '01/01/1999'}
  ///  ],
  ///  '02/02/2002': [
  ///    {'name': 'Lucas', ' birth': '02/02/2002'}
  ///  ]
  ///};
  ///```
  ///
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