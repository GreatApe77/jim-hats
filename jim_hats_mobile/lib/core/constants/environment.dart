abstract class Environment {
  static const jimHatsApiUrl = String.fromEnvironment(
    'JIM_HATS_API_URL',
    defaultValue: 'http://10.0.2.2:4000',
  );
}
