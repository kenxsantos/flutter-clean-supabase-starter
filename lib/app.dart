import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_supabase_starter/core/injector/dependency_injector.dart';
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
import 'package:flutter_clean_supabase_starter/router/router.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
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
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.router,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
        ),
      ),
    );
  }
}
