import 'package:elitestate/core/services/auth_services.dart';
import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthServices _services = AuthServices();

  bool isLoading = false;

  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String? profileImageUrl;

  String? get currentUserId => _services.currentUserId;

  /////////// USER FUNCTION ///////////
  Future<void> getUserData() async {
    try {
      final user = await _services.getUserData();

      if (user != null) {
        userName = user.name;
        userEmail = user.email;
        userPhone = user.phone ?? "";
        profileImageUrl = user.profileImageUrl;

        notifyListeners();
      }
    } catch (e) {
      debugPrint("Get User Data Error: $e");
    }
  }

  ////////////////// LOGIN //////////////////
  Future<void> loginn(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await _services.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint("Login Error: $e");
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  ///////////////// SIGNUP //////////////////
  Future<void> signup(String name, String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await _services.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint("Signup Error: $e");
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  ////////// UPDATE PROFILE IMAGE //////////
  Future<void> updateProfileImage(String url) async {
    try {
      await _services.updateProfileImage(url);
      profileImageUrl = url;
      notifyListeners();
    } catch (e) {
      debugPrint("Update Profile Image Error: $e");
      rethrow;
    }
  }

  ////////// UPDATE PHONE NUMBER //////////
  Future<void> updatePhoneNumber(String phone) async {
    try {
      await _services.updatePhoneNumber(phone);
      userPhone = phone;
      notifyListeners();
    } catch (e) {
      debugPrint("Update Phone Number Error: $e");
      rethrow;
    }
  }

  ////////////// LOGOUT //////////////
  Future<void> logout() async {
    await _services.signOut();

    userName = "";
    userEmail = "";
    userPhone = "";
    profileImageUrl = "";

    notifyListeners();
  }
}
