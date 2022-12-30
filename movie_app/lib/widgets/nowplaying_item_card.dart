import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/provider/movie_nowplaying_provider.dart';
import 'package:movie_app/widgets/items.dart';
import 'package:provider/provider.dart';

class WidgetDiscoverMovie extends StatefulWidget {
  const WidgetDiscoverMovie({super.key});

  @override
  State<WidgetDiscoverMovie> createState() => _WidgetDiscoverMovieState();
}

class _WidgetDiscoverMovieState extends State<WidgetDiscoverMovie> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieDiscoverProvider>().getDiscover(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return const SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
                itemCount: provider.movies.length,
                itemBuilder: (_, index, __) {
                  final movie = provider.movies[index];
                  return ItemMovie(
                    movie: movie,
                    widthBackdrop: double.infinity,
                    heightBackdrop: 200,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MovieDetailPage(id: movie.id);
                          },
                        ),
                      );
                    },
                  );
                },
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 0.8,
                  reverse: false,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  scrollDirection: Axis.horizontal,
                ));
          }

          return Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[400]),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Center(
              child: Text("Internal Server Error"),
            ),
          );
        },
      ),
    );
  }
}
