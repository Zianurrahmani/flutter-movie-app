import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/pages/dashboard_page.dart';
import 'package:movie_app/provider/movie_nowplaying_provider.dart';
import 'package:movie_app/provider/movie_toprated_provider.dart';
import 'package:movie_app/provider/movie_upcoming_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();

  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<MovieDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<MovieTopRatedProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<MovieUpcomingProvider>(),
        ),
      ],
      child: const MaterialApp(
        home: DashboardPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
