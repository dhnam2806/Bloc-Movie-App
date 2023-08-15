// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  List<Object> get props => [];
}

class SignUpRequest extends AuthEvent {
  final String email;
  final String username;
  final String password;
  final String confirmPassword;

  SignUpRequest({
    required this.email,
    required this.username,
    required this.password,
    required this.confirmPassword,
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
