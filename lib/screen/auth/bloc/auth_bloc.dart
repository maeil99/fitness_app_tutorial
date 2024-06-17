import 'package:fitness_app_tutorial/screen/auth/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }

  Future<void> _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());

      final userData = await User.addNewUser(
        username: event.name,
        email: event.email,
        password: event.password,
      );

      if (userData != null) {
        emit(AuthSuccess(user: userData));
      } else {
        emit(const AuthFailure(message: "Failed to register user"));
      }
    } catch (e) {
      emit(AuthFailure(message: "Unexpected error ocurred: $e"));
    }
  }

  Future<void> _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());

      final userData = await User.loginUser(
        email: event.email,
        password: event.password,
      );

      if (userData != null) {
        emit(AuthSuccess(user: userData));
      } else {
        emit(const AuthFailure(message: "Failed to login user"));
      }
    } catch (e) {
      emit(AuthFailure(message: "Unexpected error ocurred: $e"));
    }
  }
}
