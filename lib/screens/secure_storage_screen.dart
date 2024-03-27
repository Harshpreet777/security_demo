import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  writeSecureData(String key, String value) async {
    
    await secureStorage.write(key: key, value: value);
  }
  

  readSecureData(String key) async {
    String? value = await secureStorage.read(key: key) ?? 'No Value Found';

    log(value);
  }
  
  deleteSecureData(String key)async{
    await secureStorage.delete(key: key);
  }
}
