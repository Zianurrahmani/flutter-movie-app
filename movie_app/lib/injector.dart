import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/app_credentials.dart';
import 'package:movie_app/linking/movie_linking.dart';
import 'package:movie_app/linking/movie_linking_impl.dart';
import 'package:movie_app/provider/movie_detail_provider.dart';
import 'package:movie_app/provider/movie_nowplaying_provider.dart';
import 'package:movie_app/provider/movie_toprated_provider.dart';
import 'package:movie_app/provider/movie_upcoming_provider.dart';
import 'package:movie_app/provider/movie_video_provider.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerFactory<MovieDiscoverProvider>(
    () => MovieDiscoverProvider(getIt()),
  );
  getIt.registerFactory<MovieTopRatedProvider>(
    () => MovieTopRatedProvider(getIt()),
  );
  getIt.registerFactory<MovieUpcomingProvider>(
    () => MovieUpcomingProvider(getIt()),
  );
  getIt.registerFactory<MovieDetailProvider>(
    () => MovieDetailProvider(getIt()),
  );
  getIt.registerFactory<MovieVideosProvider>(
    () => MovieVideosProvider(getIt()),
  );

  getIt.registerLazySingleton<MovieLinking>(() => MovieLingkingImpl(getIt()));

  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        baseUrl: AppCredentials.baseUrl,
        queryParameters: {'api_key': AppCredentials.apikey},
      )));
}
