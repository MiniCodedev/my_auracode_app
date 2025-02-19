import 'package:fpdart/fpdart.dart';
import 'package:my_auracode_app/core/error/failure.dart';
import 'package:my_auracode_app/core/error/server_failure.dart';
import 'package:my_auracode_app/core/model/user.dart';
import 'package:my_auracode_app/features/auth/data/auth_datasources.dart';

class AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});

  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final user = await authDataSource.signInWithGoogle();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
