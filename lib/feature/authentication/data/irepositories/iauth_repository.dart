import 'package:flutter_clean_supabase_starter/feature/authentication/data/datasource/auth_datasource.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IAuthRepository implements AuthRepository {
  final AuthDataSource authDataSource;

  IAuthRepository(this.authDataSource);

  @override
  Future<AuthResponse> signIn(String email, String password) {
    return authDataSource.signInWithEmailPassword(email, password);
  }

  @override
  Future<AuthResponse> signUp(String email, String password) {
    return authDataSource.signUpWithEmailPassword(email, password);
  }

  @override
  Future<bool> isEmailExist(String email) {
    return authDataSource.isEmailExist(email);
  }

  @override
  Future<AuthResponse> signInWithGoogle() => authDataSource.signInWithGoogle();

  @override
  Future<bool> signInWithFacebook() => authDataSource.signInWithFacebook();

  @override
  Future<void> resetPassword(String email) =>
      authDataSource.resetPassword(email);

  @override
  Future<UserResponse> updatePassword(String newPassword) =>
      authDataSource.updatePassword(newPassword);

  @override
  Future<void> signOut() => authDataSource.signOut();

  @override
  String? getCurrentUserEmail() {
    return authDataSource.getCurrentUserEmail();
  }

  @override
  Session? checkUserSession() {
    return authDataSource.checkUserSession();
  }
}
