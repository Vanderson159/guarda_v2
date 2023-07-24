import 'dart:io';

class HttpOverridesProvider {
  static overrides() {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return ioc;
  }
}