import 'package:dartz/dartz.dart';
import 'package:snickz/features/data/models/response/get_shoes_response.dart';

abstract class Repository {
  Future<Either<Exception, List<GetShoesResponse>>> getAllShoes();
}
