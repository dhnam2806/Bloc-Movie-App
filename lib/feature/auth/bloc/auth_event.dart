
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
