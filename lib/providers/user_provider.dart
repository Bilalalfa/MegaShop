import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  // Fungsi Login (Simulasi API)
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulasi delay jaringan
      await Future.delayed(const Duration(seconds: 2));

      // Simulasi validasi sederhana
      if (username.isNotEmpty && password.length >= 6) {
        _currentUser = User(
          id: 'u1',
          username: username,
          profileImageUrl:
              'https://ui-avatars.com/api/?name=$username&background=random&size=200',
          bio: 'MegaShop Developer | Tech Enthusiast 🚀',
          followersCount: 1250,
          followingCount: 450,
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Username atau password salah (min. 6 karakter)';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan sistem';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Fungsi Logout
  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // Clear error message jika dibutuhkan di UI
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
