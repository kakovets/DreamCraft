import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Utils {
  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'auth');
    return token;
  }

  static List<String> langCodes = ['en', 'uk'];
  static List<String> languages = ['English', 'Українська'];

}
