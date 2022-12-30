import 'package:flutter/material.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/provider/movie_search_provider.dart';
import 'package:movie_app/widgets/image.dart';
import 'package:provider/provider.dart';

class MovieSearchPage extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search Movies";
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final mediaqueryHeight = MediaQuery.of(context).size.height;
    final myAppBar = AppBar(title: const Text("Now Playing Movies"));
    final bodyHeight = mediaqueryHeight -
        myAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (query.isNotEmpty) {
        context.read<MovieSearchProvider>().search(context, query: query);
      }
    });

    return Consumer<MovieSearchProvider>(
      builder: (_, provider, __) {
        if (provider.isLoading) {
          return const Center(child: Text("Search Movies"));
        }
        if (provider.movies.isEmpty) {
          return const Center(
            child: Text("Movie Not Found"),
          );
        }
        if (provider.movies.isNotEmpty) {
          return ListView.separated(
            itemBuilder: (_, index) {
              final movie = provider.movies[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: bodyHeight * 0.2,
                  width: double.infinity,
                  child: Row(
                    children: [
                      ImageWidget(
                        imageSrc: '${movie.posterPath}',
                        height: double.infinity,
                        width: 100,
                        radius: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Text('${movie.voteAverage}'),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  width: 180,
                                  child: Text(
                                    movie.title,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 70,
                              width: 250,
                              child: Text(
                                movie.overview,
                                maxLines: 4,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Vote: ${movie.popularity}"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return MovieDetailPage(
                                                id: movie.id);
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text("Detail"),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(),
            itemCount: provider.movies.length,
          );
        }

        return const Center(
          child: Text("Internal Server Error"),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
