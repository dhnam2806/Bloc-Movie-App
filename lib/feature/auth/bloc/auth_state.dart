part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthActionState extends AuthState {}

class LoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {
  final String message;

  SignUpSuccessState({required this.message});
}

class SignUpFailedState extends AuthState {
  final String message;

  SignUpFailedState({required this.message});
}

class SignInSuccessState extends AuthState {
  final String message;

  SignInSuccessState({required this.message});
}

class SignInFailedState extends AuthState {
  final String message;

  SignInFailedState({required this.message});
}
