import 'package:hive/hive.dart';
import 'package:resq_map/features/authentication/model/token_models/token.dart';
import 'package:resq_map/features/authentication/model/user_models/user.dart';
import 'package:resq_map/features/authentication/utils/key_manager.dart' show KeyManager;

class AuthService {
  static const String _userBoxName = 'userBox';
  static const String _tokenBoxName = 'tokenBox';
  static const String _currentUserKey = 'currentUser';
  static const String _authTokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  static Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(TokenAdapter());
    await KeyManager.init();
  }

  static Future<Box<User>> _openUserBox() async {
    return await Hive.openBox<User>(_userBoxName);
  }

  static Future<Box> _openTokenBox() async {
    final key = await KeyManager.getOrCreateKey();
    return await Hive.openBox(
      _tokenBoxName,
      encryptionCipher: HiveAesCipher(key),
    );
  }

  static Future<void> saveUserData({required User user}) async {
    try {
      final box = await _openUserBox();
      await box.put(_currentUserKey, user);
    } catch (e) {
      // Add logging here
      rethrow;
    }
  }

  static Future<User?> getUser() async {
    try {
      final box = await _openUserBox();
      return box.get(_currentUserKey);
    } catch (e) {
      // Add logging here
      return null;
    }
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
      final userBox = await _openUserBox();
      final tokenBox = await _openTokenBox();
      await Future.wait([
        userBox.clear(),
        tokenBox.clear(),
      ]);
    } catch (e) {
      // Add logging here
      rethrow;
    }
  }
}