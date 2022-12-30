import 'package:dartz/dartz.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/movie_video_model.dart';

abstract class MovieLinking {
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1});
  Future<Either<String, MovieResponseModel>> getUpcoming({int page = 1});
  Future<Either<String, MovieResponseModel>> search({required String query});
  Future<Either<String, MovieDetailResponse>> getDetail({required int id});
  Future<Either<String, MovieVideosModel>> getVideos({required int id});
}
