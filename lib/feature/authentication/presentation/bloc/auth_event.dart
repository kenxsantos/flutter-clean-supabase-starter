part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserSignedIn extends AuthEvent {
  final String email;
  final String password;

  UserSignedIn({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class UserSignedUp extends AuthEvent {
  final String email;
  final String password;

  UserSignedUp({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthReset extends AuthEvent {}

class UserSignedOutRequested extends AuthEvent {}

class GetCurrentUserEmail extends AuthEvent {}

class GoogleSignInRequested extends AuthEvent {}

class FacebookSignInRequested extends AuthEvent {}

class ResetPasswordRequested extends AuthEvent {
  final String email;
  ResetPasswordRequested({required this.email});
}

class UpdatePasswordRequested extends AuthEvent {
  final String newPassword;
  UpdatePasswordRequested({required this.newPassword});
}

class CheckUserSessionRequested extends AuthEvent {}
