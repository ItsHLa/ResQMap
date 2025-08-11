import 'package:hive/hive.dart';
import 'package:resq_map/features/authentication/model/token_models/token.dart';
import 'package:resq_map/features/authentication/utils/key_manager.dart' show KeyManager;

class AuthService {
  
  static const String _tokenBoxName = 'tokenBox';
  static const String _authTokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  static Future<void> init() async {

    Hive.registerAdapter(TokenAdapter());
    await KeyManager.init();
  }

 

  static Future<Box> _openTokenBox() async {
    final key = await KeyManager.getOrCreateKey();
    return await Hive.openBox(
      _tokenBoxName,
      encryptionCipher: HiveAesCipher(key),
    );
  }


  static Future<void> saveTokenData({
    required String token,
    required String refreshToken,
  }) async {
    try {
      final box = await _openTokenBox();
      await box.putAll({
        _authTokenKey: token,
        _refreshTokenKey: refreshToken,
      });
    } catch (e) {
      // Add logging here
      rethrow;
    }
  }

  static Future<String?> getAuthToken() async {
    try {
      final box = await _openTokenBox();
      return box.get(_authTokenKey);
    } catch (e) {
      // Add logging here
      return null;
    }
  }

  static Future<String?> getRefreshToken() async {
    try {
      final box = await _openTokenBox();
      return box.get(_refreshTokenKey);
    } catch (e) {
      // Add logging here
      return null;
    }
  }

  static Future<void> clearAllData() async {
    try {
      final tokenBox = await _openTokenBox();
      await Future.wait([
        tokenBox.clear(),
      ]);
    } catch (e) {
      // Add logging here
      rethrow;
    }
  }
}