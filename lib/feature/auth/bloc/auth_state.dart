part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthActionState extends AuthState {}

class LoadingState extends AuthState {}

class SignUpSuccessState extends AuthActionState {
  final String message;

  SignUpSuccessState({required this.message});
}

class SignUpFailedState extends AuthActionState {
  final String message;

  SignUpFailedState({required this.message});
}

class SignInSuccessState extends AuthActionState {
  final String message;

  SignInSuccessState({required this.message});
}

class SignInFailedState extends AuthActionState {
  final String message;

  SignInFailedState({required this.message});
}

class SignUpNavigateState extends AuthActionState {}

class SignInNavigateState extends AuthActionState {}

class SignOutSuccessState extends AuthActionState {
  final String message;

  SignOutSuccessState({required this.message});
}

class ForgotPasswordNavigateState extends AuthActionState {}

class ForgotPasswordSuccessState extends AuthActionState {
  final String message;

  ForgotPasswordSuccessState({required this.message});
}

class ForgotPasswordFailedState extends AuthActionState {
  final String message;

  ForgotPasswordFailedState({required this.message});
}
