import 'package:elitestate/core/services/auth_services.dart';
import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthServices _services = AuthServices();
  bool isLoading = false;
  String userName = "";
  String userEmail = "";

  Future<void> getUserData() async {
    try {
      final snapshot = await _services.getUserData();

      if (snapshot.exists) {
        userName = snapshot.data()?['name'] ?? "";
        userEmail = snapshot.data()?['email'] ?? "";
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loginn(String email, String password) async {
    isLoading = true;
    notifyListeners();

    await _services.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> signup(String name, String email, String password) async {
    isLoading = true;
    notifyListeners();
    await _services.signUpWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );
    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _services.signOut();
  }
}
