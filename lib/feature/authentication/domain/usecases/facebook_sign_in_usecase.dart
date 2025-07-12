import 'package:flutter_clean_supabase_starter/feature/authentication/domain/repositories/auth_repository.dart';

class SignInWithFacebookUseCase {
  final AuthRepository repository;

  SignInWithFacebookUseCase(this.repository);

  Future<bool> call() async {
    return await repository.signInWithFacebook();
  }
}
