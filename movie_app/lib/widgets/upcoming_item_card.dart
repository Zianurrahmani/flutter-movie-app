import 'package:flutter/material.dart';
import 'package:movie_app/app_credentials.dart';
import 'package:movie_app/provider/movie_upcoming_provider.dart';
import 'package:provider/provider.dart';

class WidgetUpcomingMovie extends StatefulWidget {
  const WidgetUpcomingMovie({super.key});

  @override
  State<WidgetUpcomingMovie> createState() => _WidgetUpcomingMovieState();
}

class _WidgetUpcomingMovieState extends State<WidgetUpcomingMovie> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieUpcomingProvider>().getUpcoming(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieUpcomingProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (provider.movies.isNotEmpty) {
            return SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            '${AppCredentials.baseImageUrl}${provider.movies[index].posterPath}',
                            height: 180,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            provider.movies[index].title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                        width: 10,
                      ),
                  itemCount: provider.movies.length),
            );
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
