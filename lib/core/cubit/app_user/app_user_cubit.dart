import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_auracode_app/core/data/chat_datasource.dart';
import 'package:my_auracode_app/core/model/user.dart' as userModel;

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  userModel.User? user;
  final FirebaseAuth firebaseAuth;
  final ChatDataSource chatDataSource;
  AppUserCubit({required this.firebaseAuth, required this.chatDataSource})
      : super(AppUserInitial());

  Future<void> updateUser() async {
    emit(AppUserLoading());
    try {
      firebaseAuth.authStateChanges().listen((user1) async {
        emit(AppUserLoading());
        if (user1 != null) {
          final user_ = await chatDataSource.getUserData(user1.uid);
          user = user_;
          emit(AppUserLoginSuccess());
        } else {
          emit(AppUserInitial());
        }
      });
    } catch (e) {
      emit(AppUserFailure(e.toString()));
    }
  }

  void userLogout() async {
    emit(AppUserLoading());
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      emit(AppUserFailure(e.toString()));
    }
  }
}
