
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'dart:convert';

class KeyManager {
  static const _keyBoxName = 'encryption_keys_box';
  static const _appKeyIdentifier = 'app_encryption_key';


  static Future<void> init() async {
    await Hive.openBox(_keyBoxName);
  }


  static Future<Uint8List> getOrCreateKey() async {
    final box = Hive.box(_keyBoxName);
    var key = box.get(_appKeyIdentifier);

    if (key == null) {
      key = Hive.generateSecureKey();
      await box.put(_appKeyIdentifier, base64Encode(key));
      return key;
    }

    return base64Decode(key);
  }

  // استرجاع المفتاح المشفر (للمستخدمين المتقدمين)
  static Future<String?> getEncodedKey() async {
    final box = Hive.box(_keyBoxName);
    return box.get(_appKeyIdentifier);
  }

  // حذف المفتاح (لحالات تسجيل الخروج)
  static Future<void> deleteKey() async {
    final box = Hive.box(_keyBoxName);
    await box.delete(_appKeyIdentifier);
  }
}