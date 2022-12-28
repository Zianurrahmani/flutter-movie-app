import 'package:dartz/dartz.dart';
import 'package:movie_app/models/movie_model.dart';

abstract class MovieLinking {
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
}
