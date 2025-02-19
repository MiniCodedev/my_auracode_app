import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_auracode_app/core/cubit/app_user/app_user_cubit.dart';
import 'package:my_auracode_app/features/auth/domain/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final AppUserCubit appUserCubit;

  AuthBloc({required this.authRepository, required this.appUserCubit})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthLoading());
    });
    on<AuthSignUp>(_onAuthSignUp);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter emit) async {
    emit(AuthLoading());
    final result = await authRepository.signInWithGoogle();

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) async {
        await appUserCubit.updateUser();
        emit(AuthSuccess());
      },
    );
  }
}
