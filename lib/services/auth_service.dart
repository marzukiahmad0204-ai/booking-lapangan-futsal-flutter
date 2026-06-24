import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'database_helper.dart';

class AuthService extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Map<String, dynamic>? _currentUser;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  Map<String, dynamic>? get currentUser => _currentUser;

  Future<bool> register({
    required String email,
    required String password,
    required String nama,
    required String noHp,
  }) async {
    try {
      const uuid = Uuid();
      String userId = uuid.v4();
      
      Map<String, dynamic> user = {
        'id': userId,
        'email': email,
        'nama': nama,
        'noHp': noHp,
        'password': password,
        'fotoProfil': '',
        'createdAt': DateTime.now().toString(),
      };

      await _dbHelper.insertUser(user);
      _currentUser = user;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        _currentUser = {
          'id': '${email.hashCode}',
          'email': email,
          'nama': email.split('@')[0],
          'noHp': '',
          'fotoProfil': '',
        };
        _isLoggedIn = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<bool> updateProfile({
    required String nama,
    required String noHp,
  }) async {
    try {
      if (_currentUser != null) {
        _currentUser!['nama'] = nama;
        _currentUser!['noHp'] = noHp;
        await _dbHelper.updateUser(_currentUser!);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Update profile error: $e');
      return false;
    }
  }
}
