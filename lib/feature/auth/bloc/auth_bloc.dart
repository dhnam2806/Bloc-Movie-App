import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../repositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignUpRequest>(signUpRequest);
    on<SignInRequest>(signInRequest);
  }

  Future<FutureOr<void>> signUpRequest(
      SignUpRequest event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      await authRepository.signUp(
        email: event.email,
        password: event.password,
        username: event.username,
      );
      emit(SignUpSuccessState(message: 'Sign Up Success'));
    } catch (e) {
      emit(SignUpFailedState(message: e.toString()));
    }
  }

  FutureOr<void> signInRequest(SignInRequest event, Emitter<AuthState> emit) {
    emit(LoadingState());
    try {
      authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      emit(SignInSuccessState(message: 'Sign In Success'));
    } catch (e) {
      emit(SignInFailedState(message: e.toString()));
    }
  }
}
