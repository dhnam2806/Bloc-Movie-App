part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {
  final String message;

  SignUpSuccessState({required this.message});
}

class SignUpFailedState extends AuthState {
  final String message;

  SignUpFailedState({required this.message});
}
