import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PasswordProvider {
  final _storage = new FlutterSecureStorage();

  Future<String?> getPassword(String login) async {
    return await _storage.read(key: login);
  }

  Future<Map<String, String>> getAllPasswords() async {
    return await _storage.readAll();
  }

  void writePassword(String login, String password) {
    _storage.write(key: login, value: password);
  }

  void deletePassword(String login) {
    _storage.delete(key: login);
  }
  void deleteAllPasswords() {
    _storage.deleteAll();
  }
}