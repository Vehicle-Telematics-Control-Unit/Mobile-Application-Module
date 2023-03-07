import 'package:get_storage/get_storage.dart';

mixin CasheManagerService {
  Future<bool> saveToken(String? token) async {
    final storage = GetStorage();
    await storage.write('token', token);
    return true;
  }

  Future<bool> saveUsername(String? username) async {
    await GetStorage.init();
    final storage = GetStorage();
    await storage.write('username', username);
    return true;
  }
   Future<bool> saveEmail(String? email) async {
    await GetStorage.init();
    final storage = GetStorage();
    await storage.write('email', email);
    return true;
  }

  String getEmail(){
    final storage = GetStorage();
    return storage.read('email');
  }

  String? getToken() {
    final storage = GetStorage();
    return storage.read('token');
  }

  Future<void> removeToken() async {
    final storage = GetStorage();
    await storage.remove('token');
  }
}
