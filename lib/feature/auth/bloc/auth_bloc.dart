import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../../../repositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignUpRequest>(signUpRequest);
    on<SignInRequest>(signInRequest);
    on<SignUpNavigateEvent>(signUpNavigateEvent);
    on<SignInNavigateEvent>(signInNavigateEvent);
    on<SignOutRequest>(signOutRequest);
    on<ForgotPasswordRequestEvent>(forgotPasswordRequestEvent);
    on<ForgotPasswordNavigateEvent>(forgotPasswordNavigateEvent);
  }

  Future<FutureOr<void>> signUpRequest(
      SignUpRequest event, Emitter<AuthState> emit) async {
    final bool isValidEmail = EmailValidator.validate(event.email);
    if (event.email.isEmpty ||
        event.password.isEmpty ||
        event.username.isEmpty ||
        event.confirmPassword.isEmpty) {
      emit(SignUpFailedState(message: 'Please fill all fields'));
    } else {
      if (isValidEmail) {
        if (event.password != event.confirmPassword) {
          emit(SignUpFailedState(message: 'Password is not match'));
        }
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
      } else {
        emit(SignUpFailedState(message: 'Email is not valid'));
      }
    }
  }

  Future<FutureOr<void>> signInRequest(
      SignInRequest event, Emitter<AuthState> emit) async {
    final bool isValidEmail = EmailValidator.validate(event.email);

    if (isValidEmail) {
      if (event.email.isEmpty || event.password.isEmpty) {
        emit(SignInFailedState(message: 'Email or Password is empty'));
      }
      try {
        await authRepository.signIn(
          email: event.email,
          password: event.password,
        );
        emit(SignInSuccessState(message: 'Sign In Success'));
      } catch (e) {
        emit(SignInFailedState(message: e.toString()));
      }
    } else {
      emit(SignInFailedState(message: 'Email is not valid'));
    }
  }

  FutureOr<void> signUpNavigateEvent(
      SignUpNavigateEvent event, Emitter<AuthState> emit) {
    emit(SignUpNavigateState());
  }

  FutureOr<void> signInNavigateEvent(
      SignInNavigateEvent event, Emitter<AuthState> emit) {
    emit(SignInNavigateState());
  }

  FutureOr<void> signOutRequest(SignOutRequest event, Emitter<AuthState> emit) {
    authRepository.signOut();
    emit(SignOutSuccessState(message: 'Sign Out Success'));
  }

  FutureOr<void> forgotPasswordNavigateEvent(
      ForgotPasswordNavigateEvent event, Emitter<AuthState> emit) {
    emit(ForgotPasswordNavigateState());
  }

  FutureOr<void> forgotPasswordRequestEvent(
      ForgotPasswordRequestEvent event, Emitter<AuthState> emit) async {
    final bool isValidEmail = EmailValidator.validate(event.email);
    if (isValidEmail) {
      try {
        await authRepository.forgotPassword(email: event.email);
        emit(ForgotPasswordSuccessState(message: 'Forgot Password Success'));
      } on FirebaseAuthException catch (e) {
        emit(ForgotPasswordFailedState(message: e.toString()));
      }
    }
    if (!isValidEmail) {
      emit(ForgotPasswordFailedState(message: 'Email is not valid'));
    }
  }
}
