import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_supabase_starter/core/validators/supabase_auth_exception_handler.dart';
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
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUserUseCase signInUserUseCase;
  final SignUpUserUseCase signUpUserUseCase;
  final SignOutUserUseCase signOutUserUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignInWithFacebookUseCase signInWithFacebookUseCase;
  final CheckEmailExistUseCase checkEmailExistUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final GetUserEmailUseCase getUserEmailUseCase;
  final CheckUserSessionUseCase checkUserSessionUseCase;
  AuthBloc({
    required this.signInUserUseCase,
    required this.signUpUserUseCase,
    required this.signOutUserUseCase,
    required this.signInWithGoogleUseCase,
    required this.signInWithFacebookUseCase,
    required this.checkEmailExistUseCase,
    required this.resetPasswordUseCase,
    required this.updatePasswordUseCase,
    required this.getUserEmailUseCase,
    required this.checkUserSessionUseCase,
  }) : super(AuthInitial()) {
    on<AuthReset>((event, emit) {
      emit(AuthInitial());
    });

    on<UserSignedUp>((event, emit) async {
      emit(AuthLoading());
      try {
        final isEmailAlreadyExist = await checkEmailExistUseCase.call(
          event.email,
        );

        if (isEmailAlreadyExist) {
          return emit(AuthError(errorMsg: "Email already exist!"));
        } else {
          await signUpUserUseCase.call(event.email, event.password);
          emit(EmailVerificationRequired(event.email));
        }
      } catch (e) {
        emit(AuthError(errorMsg: SupabaseAuthExceptionHandler.parse(e)));
      }
    });

    on<UserSignedIn>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signInUserUseCase.call(event.email, event.password);
        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthError(errorMsg: SupabaseAuthExceptionHandler.parse(e)));
      }
    });

    on<UserSignedOutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await signOutUserUseCase.call();
        emit(AuthSignedOutSuccess());
      } catch (e) {
        emit(AuthError(errorMsg: e.toString()));
      }
    });

    on<GetCurrentUserEmail>((event, emit) {
      emit(AuthLoading());
      final email = getUserEmailUseCase.call();

      if (email != null) {
        emit(AuthEmailSuccess(email));
      } else {
        emit(AuthError(errorMsg: "No user email found."));
      }
    });

    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final response = await signInWithGoogleUseCase.call();
        final email = response.user?.email ?? 'No Email';
        emit(AuthGoogleSignInSuccess(email));
      } catch (e) {
        print("Error: ${e.toString()}}");
        emit(AuthError(errorMsg: e.toString()));
      }
    });

    on<FacebookSignInRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await signInWithFacebookUseCase.call();

        emit(AuthFacebookSignInSuccess());
      } catch (e) {
        emit(AuthError(errorMsg: e.toString()));
      }
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await resetPasswordUseCase.call(event.email);
        emit(ResetPasswordRequestSuccess());
      } catch (e) {
        emit(AuthError(errorMsg: SupabaseAuthExceptionHandler.parse(e)));
      }
    });

    on<UpdatePasswordRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await updatePasswordUseCase.call(event.newPassword);
        emit(UpdatePasswordSuccess());
      } catch (e) {
        emit(AuthError(errorMsg: SupabaseAuthExceptionHandler.parse(e)));
      }
    });

    on<CheckUserSessionRequested>((event, emit) {
      emit(AuthLoading());

      try {
        final session = checkUserSessionUseCase.call();
        if (session != null) {
          emit(CheckUserSessionSuccess(session.user));
        } else {
          emit(CheckUserSessionNotFound());
        }
      } catch (e) {
        emit(AuthError(errorMsg: e.toString()));
      }
    });
  }
}
