part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoading extends AppUserState {}

final class AppUserFailure extends AppUserState {
  final String message;
  AppUserFailure(this.message);
}

final class AppUserLoginSuccess extends AppUserState {}
