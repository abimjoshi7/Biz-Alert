import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future writeData({required String key, required String value}) async {
    var writeData = await _storage.write(key: key, value: value);
    // print(key);
    // print(value);
    return writeData;
  }

  Future readData({required String key}) async {
    // print(4);
    var readData = await _storage.read(key: key);
    return readData;
  }

  Future deleteData(String key) async {
    var deleteData = await _storage.delete(key: key);
    return deleteData;
  }

  Future deleteAll() {
    var deleteAll = _storage.deleteAll();
    return deleteAll;
  }
}
