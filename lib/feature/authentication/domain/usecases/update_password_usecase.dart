import 'package:flutter_clean_supabase_starter/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdatePasswordUseCase {
  final AuthRepository repository;

  Future<UserResponse> call(String newPassword) async {
    return await repository.updatePassword(newPassword);
  }

  UpdatePasswordUseCase(this.repository);
}
