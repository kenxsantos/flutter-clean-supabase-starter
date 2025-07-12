import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/auth_repository.dart';

class SignInUserUseCase {
  final AuthRepository repository;

  SignInUserUseCase(this.repository);

  Future<AuthResponse> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}
