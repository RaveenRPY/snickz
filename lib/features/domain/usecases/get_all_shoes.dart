import 'package:dartz/dartz.dart';
import 'package:snickz/features/data/models/response/get_shoes_response.dart';
import 'package:snickz/features/data/repositories/repository_impl.dart';

import '../repositories/repository.dart';

class GetAllShoesUseCase {
  final RepositoryImpl? repositoryImpl;

  GetAllShoesUseCase({this.repositoryImpl});

  @override
  Future<Either<Exception, List<GetShoesResponse>>> call() async {
    return await repositoryImpl!.getAllShoes();
  }
}
