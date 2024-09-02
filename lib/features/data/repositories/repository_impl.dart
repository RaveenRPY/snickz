import 'package:dartz/dartz.dart';
import 'package:snickz/features/data/models/response/get_shoes_response.dart';

import '../../domain/repositories/repository.dart';
import '../datasources/remote_data_source.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSourceImpl? remoteDataSourceImpl;

  RepositoryImpl({
    required this.remoteDataSourceImpl,
  });

  /// Splash
  @override
  Future<Either<Exception, List<GetShoesResponse>>> getAllShoes() async {
    try {
      final parameters = await remoteDataSourceImpl!.getAllShoes();
      return Right(parameters);
    } catch (e) {
      rethrow;
    }
  }
}
