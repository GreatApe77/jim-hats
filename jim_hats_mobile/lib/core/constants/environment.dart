abstract class Environment {
  ///Environment variable that points to correct API.
  ///Must be defined in a .env.flavor_name file or via command line arguments in flutter.
  static const jimHatsApiUrl = String.fromEnvironment(
    'JIM_HATS_API_URL',
    defaultValue: 'http://10.0.2.2:4000',
  );
}
