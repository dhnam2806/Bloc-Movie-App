
part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  List<Object> get props => [];
}

class SignUpRequest extends AuthEvent {
  final String email;
  final String password;
  final String username;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.username,
  });
}

class SignInRequest extends AuthEvent {
  final String email;
  final String password;

  SignInRequest({
    required this.email,
    required this.password,
  });
}

class SignOutRequest extends AuthEvent {}

class SignUpNavigateEvent extends AuthEvent {}

class SignInNavigateEvent extends AuthEvent {}

class ForgotPasswordRequestEvent extends AuthEvent {
  final String email;

  ForgotPasswordRequestEvent({required this.email});
}

class ForgotPasswordNavigateEvent extends AuthEvent {}
