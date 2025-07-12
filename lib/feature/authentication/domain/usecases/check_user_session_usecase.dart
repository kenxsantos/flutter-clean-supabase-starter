import 'package:flutter_clean_supabase_starter/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CheckUserSessionUseCase {
  final AuthRepository repository;
  CheckUserSessionUseCase(this.repository);

  Session? call() {
    return repository.checkUserSession();
  }
}
