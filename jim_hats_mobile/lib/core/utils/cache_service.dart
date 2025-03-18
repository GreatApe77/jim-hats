abstract interface class CacheService {
  void store<V>(
    String key,
    V value, {
    Duration duration = const Duration(seconds: 5),
  });

  void clearCache();

  void remove(String key);

  V? get<V>(String key);
}
