import 'package:flutter_clean_supabase_starter/feature/authentication/domain/repositories/auth_repository.dart';

class CheckEmailExistUseCase {
  final AuthRepository repository;

  CheckEmailExistUseCase(this.repository);

  Future<bool> call(String email) async {
    return await repository.isEmailExist(email);
  }
}
