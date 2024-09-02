import 'dart:core';
import 'dart:developer';

import 'package:snickz/features/data/models/response/get_shoes_response.dart';
import 'package:dio/dio.dart';

abstract class RemoteDataSource {
  Future<List<GetShoesResponse>> getAllShoes();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio _dio = Dio();

  /// getShoes Request
  @override
  Future<List<GetShoesResponse>> getAllShoes() async {
    try {
      final response = await _dio.get(
        "https://66d16bcc62816af9a4f39165.mockapi.io/api/v1/products",
      );
      final List<dynamic> data = response.data;

      log(response.data.toString());

      return data.map((json) => GetShoesResponse.fromJson(json)).toList();
    } on Exception {
      rethrow;
    }
  }
}
