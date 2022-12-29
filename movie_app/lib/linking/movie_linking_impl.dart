import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/models/movie_model.dart';
import 'movie_linking.dart';

class MovieLingkingImpl implements MovieLinking {
  final Dio _dio;

  MovieLingkingImpl(this._dio);

  @override
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result =
          await _dio.get('/movie/now_playing', queryParameters: {'page': page});

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get dicover');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Internal Server Error');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1}) async {
    try {
      final result =
          await _dio.get('/movie/top_rated', queryParameters: {'page': page});

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get dicover');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Internal Server Error');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getUpcoming({int page = 1}) async {
    try {
      final result =
          await _dio.get('/movie/upcoming', queryParameters: {'page': page});

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get dicover');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Internal Server Error');
    }
  }
}
