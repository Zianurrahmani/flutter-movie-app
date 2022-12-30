import 'package:flutter/material.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/provider/movie_detail_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<MovieDetailProvider>()..getDetail(context, id: id),
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            Consumer<MovieDetailProvider>(
              builder: (_, provider, __) {
                return SliverAppBar(
                  title:
                      Text(provider.movie != null ? provider.movie!.title : ''),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
