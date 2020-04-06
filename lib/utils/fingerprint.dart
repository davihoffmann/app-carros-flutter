import 'package:local_auth/local_auth.dart';

class FingerPrint {

  static Future<bool> canCheckBiometrics() async {
    var localAuth = new LocalAuthentication();

    bool b = await localAuth.canCheckBiometrics;

    return b;
  }

  static Future<bool> canCheckFaceId() async {
    var localAuth = new LocalAuthentication();

    List<BiometricType> list = await localAuth.getAvailableBiometrics();

    print(list.length);

    if(list.contains(BiometricType.face)) {
      return true;
    }
    return false;
  }

  static Future<bool> verify() async {
    var localAuth = new LocalAuthentication();
    bool ok = await localAuth.authenticateWithBiometrics(localizedReason: 'Toque no sensor para autenticar com a sua digital');

    return ok;
  }

}