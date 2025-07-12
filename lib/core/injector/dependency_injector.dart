import 'package:flutter/material.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/data/datasource/auth_datasource.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/data/irepositories/iauth_repository.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/usecases/check_email_exist_usecase.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/usecases/check_user_session_usecase.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/usecases/facebook_sign_in_usecase.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/usecases/get_user_email_usecase.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/usecases/google_sign_in_usecase.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/usecases/sign_in_user_usecase.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/usecases/sign_out_user_usecase.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/usecases/sign_up_user_usecase.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/domain/usecases/update_password_usecase.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

final inj = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  final SupabaseClient supabase = Supabase.instance.client;

  //Services

  //Data Sources
  inj.registerLazySingleton<AuthDataSource>(() => AuthDataSource(supabase));

  //Repositories
  inj.registerLazySingleton<AuthRepository>(
    () => IAuthRepository(inj<AuthDataSource>()),
  );

  //Use Cases
  inj.registerLazySingleton(() => SignInUserUseCase(inj<AuthRepository>()));
  inj.registerLazySingleton(() => SignUpUserUseCase(inj<AuthRepository>()));
  inj.registerLazySingleton(() => SignOutUserUseCase(inj<AuthRepository>()));
  inj.registerLazySingleton(() => GetUserEmailUseCase(inj<AuthRepository>()));
  inj.registerLazySingleton(
    () => SignInWithGoogleUseCase(inj<AuthRepository>()),
  );
  inj.registerLazySingleton(
    () => SignInWithFacebookUseCase(inj<AuthRepository>()),
  );
  inj.registerLazySingleton(
    () => CheckEmailExistUseCase(inj<AuthRepository>()),
  );
  inj.registerLazySingleton(() => ResetPasswordUseCase(inj<AuthRepository>()));
  inj.registerLazySingleton(() => UpdatePasswordUseCase(inj<AuthRepository>()));
  inj.registerLazySingleton(
    () => CheckUserSessionUseCase(inj<AuthRepository>()),
  );

  //Blocs
  inj.registerFactory<AuthBloc>(
    () => AuthBloc(
      signInUserUseCase: inj<SignInUserUseCase>(),
      signUpUserUseCase: inj<SignUpUserUseCase>(),
      signOutUserUseCase: inj<SignOutUserUseCase>(),
      signInWithGoogleUseCase: inj<SignInWithGoogleUseCase>(),
      signInWithFacebookUseCase: inj<SignInWithFacebookUseCase>(),
      checkEmailExistUseCase: inj<CheckEmailExistUseCase>(),
      resetPasswordUseCase: inj<ResetPasswordUseCase>(),
      updatePasswordUseCase: inj<UpdatePasswordUseCase>(),
      getUserEmailUseCase: inj<GetUserEmailUseCase>(),
      checkUserSessionUseCase: inj<CheckUserSessionUseCase>(),
    ),
  );
}
