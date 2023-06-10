
import 'package:get_storage/get_storage.dart';

mixin CasheManagerService {
  Future<bool> saveToken(String? token) async {
    final storage = GetStorage();
    await storage.write('token', token);
    return true;
  }

  Future<bool> saveUsername(String? username) async {
    final storage = GetStorage();
    await storage.write('username', username);
    return true;
  }

  Future<bool> saveEmail(String? email) async {
    final storage = GetStorage();
    await storage.write('email', email);
    return true;
  }

   Future<bool> saveDeviceId(String? deviceId) async {
    final storage = GetStorage();
    await storage.write('deviceId', deviceId);
    return true;
  }

  String getDeviceId() {
    final storage = GetStorage();
    return storage.read('deviceId');
  }

  String getEmail() {
    final storage = GetStorage();
    return storage.read('email');
  }

  String getUserName() {
    final storage = GetStorage();
    return storage.read('username');
  }

  String getToken() {
    final storage = GetStorage();
    return storage.read('token');
  }

  Future<void> removeToken() async {
    final storage = GetStorage();
    await storage.remove('token');
  }

  Future<void> removeUsername() async {
    final storage = GetStorage();
    await storage.remove('username');
  }

  Future<void> removeEmail() async {
    final storage = GetStorage();
    await storage.remove('email');
  }
}
