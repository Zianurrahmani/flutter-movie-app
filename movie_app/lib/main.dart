import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_app/app_credentials.dart';
import 'package:movie_app/linking/movie_linking.dart';
import 'package:movie_app/linking/movie_linking_impl.dart';
import 'package:movie_app/pages/dashboard_page.dart';
import 'package:movie_app/provider/movie_nowplaying_provider.dart';
import 'package:movie_app/provider/movie_toprated_provider.dart';
import 'package:movie_app/provider/movie_upcoming_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final dioOptions = BaseOptions(
    baseUrl: AppCredentials.baseUrl,
    queryParameters: {'api_key': AppCredentials.apikey},
  );

  final Dio dio = Dio(dioOptions);
  final MovieLinking movieLinking = MovieLingkingImpl(dio);

  runApp(MyApp(movieLinking: movieLinking));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.movieLinking});

  final MovieLinking movieLinking;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieDiscoverProvider(movieLinking),
        ),
        ChangeNotifierProvider(
          create: (_) => MovieTopRatedProvider(movieLinking),
        ),
        ChangeNotifierProvider(
          create: (_) => MovieUpcomingProvider(movieLinking),
        ),
      ],
      child: const MaterialApp(
        home: DashboardPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
