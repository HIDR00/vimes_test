import '../../shared.dart';
import '../utils/log_utils.dart';

class EnvConstants {
  const EnvConstants._();
  static const flavorKey = 'FLAVOR';
  static const appApiUrlKey = 'APP_API_URL';

  static late Flavor flavor = Flavor.values.byName(const String.fromEnvironment(flavorKey, defaultValue: "develop"));
  static late String appApiUrl = const String.fromEnvironment(appApiUrlKey);

  static void init() {
    Log.d(flavor, name: EnvConstants.flavorKey);
    Log.d(appApiUrl, name: EnvConstants.appApiUrlKey);
  }
}
