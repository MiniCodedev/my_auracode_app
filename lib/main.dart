import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_auracode_app/core/cubit/app_user/app_user_cubit.dart';
import 'package:my_auracode_app/core/data/chat_datasource.dart';
import 'package:my_auracode_app/core/utils/loader.dart';
import 'package:my_auracode_app/core/utils/show_snackbar.dart';
import 'package:my_auracode_app/features/auth/data/auth_datasources.dart';
import 'package:my_auracode_app/features/auth/domain/auth_repository.dart';
import 'package:my_auracode_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:my_auracode_app/features/auth/presentation/pages/signup_page.dart';
import 'package:my_auracode_app/features/home/presentation/pages/home_page.dart';
import 'package:my_auracode_app/firebase_options.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ChatDataSource chatDataSource = ChatDataSource();
  final AppUserCubit appUserCubit =
      AppUserCubit(firebaseAuth: firebaseAuth, chatDataSource: chatDataSource);

  final AuthDataSource authDataSource = AuthDataSource(
      chatDatasource: chatDataSource, firebaseAuth: firebaseAuth);
  final AuthRepository authRepository =
      AuthRepository(authDataSource: authDataSource);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => appUserCubit,
    ),
    BlocProvider(
      create: (context) =>
          AuthBloc(authRepository: authRepository, appUserCubit: appUserCubit),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AppUserCubit>().updateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocConsumer<AppUserCubit, AppUserState>(
        listener: (context, state) {
          if (state is AppUserFailure) {
            showSnackBar(context: context, text: state.message);
          }
        },
        builder: (context, state) {
          if (state is AppUserLoading) {
            return Loader();
          }
          if (state is AppUserLoginSuccess) {
            return HomePage();
          }
          return const SignupPage();
        },
      ),
      theme: AppTheme.darkTheme,
    );
  }
}
