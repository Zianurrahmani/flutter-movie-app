import 'package:flutter/material.dart';
import 'package:movie_app/app_credentials.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/provider/movie_detail_provider.dart';
import 'package:movie_app/provider/movie_video_provider.dart';
import 'package:movie_app/widgets/video_player_widget.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final mediaqueryHeight = MediaQuery.of(context).size.height;
    // final myAppBar = AppBar(title: const Text("Home"));
    final bodyHeight = mediaqueryHeight - MediaQuery.of(context).padding.top;
    final bodyWidth = MediaQuery.of(context).size.width;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) =>
                getIt<MovieDetailProvider>()..getDetail(context, id: id),
          ),
          ChangeNotifierProvider(
            create: (_) =>
                getIt<MovieVideosProvider>()..getVideos(context, id: id),
          ),
        ],
        builder: (_, __) => Consumer<MovieDetailProvider>(
              builder: (_, provider, __) {
                final movie = provider.movie;

                if (movie != null) {
                  return Scaffold(
                    body: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          title: Text(movie.title),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: bodyHeight * 0.3,
                                    width: bodyWidth,
                                    child: ClipRRect(
                                      child: Image.network(
                                        '${AppCredentials.baseImageUrl}${movie.backdropPath}',
                                        height: bodyHeight * 0.3,
                                        width: bodyWidth,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) {
                                          return SizedBox(
                                            height: bodyHeight * 0.3,
                                            width: bodyWidth,
                                            child: const Icon(
                                                Icons.broken_image_rounded),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: bodyHeight * 0.3,
                                    width: bodyWidth,
                                    color: Colors.black45,
                                    child: Center(
                                      child: Text(
                                        movie.tagline,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Consumer<MovieVideosProvider>(
                          builder: (_, provider, __) {
                            final videos = provider.videos;
                            if (videos != null) {
                              return SliverToBoxAdapter(
                                child: _Content(
                                  title: 'Trailer',
                                  padding: 0,
                                  body: SizedBox(
                                    height: 160,
                                    child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, index) {
                                        final vidio = videos.results[index];
                                        return Stack(
                                          children: [
                                            SizedBox(
                                              height: bodyHeight * 0.2,
                                              width: bodyWidth * 0.95,
                                              child: ClipRRect(
                                                child: Image.network(
                                                  YoutubePlayer.getThumbnail(
                                                    videoId: vidio.key,
                                                  ),
                                                  height: bodyHeight * 0.3,
                                                  width: bodyWidth,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) {
                                                    return SizedBox(
                                                      height: bodyHeight * 0.3,
                                                      width: bodyWidth,
                                                      child: const Icon(Icons
                                                          .broken_image_rounded),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Center(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 6.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      6.0,
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.white,
                                                    size: 32.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            YoutubePlayerWldget(
                                                          youtubeKey: vidio.key,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(width: 8),
                                      itemCount: videos.results.length,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SliverToBoxAdapter();
                          },
                        ),
                        SubTitleWidget(title: "Descroption"),
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            // height: bodyHeight * 0.4,
                            // width: bodyWidth,
                            // color: Colors.amber,
                            child: Text(movie.overview),
                          ),
                        ),
                        SubTitleWidget(title: "Genres"),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Wrap(
                              spacing: 6,
                              children: movie.genres
                                  .map(
                                    (genre) => Chip(
                                      label: Text(genre.name),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        _WidgetSummary()
                      ],
                    ),
                  );
                }
                return Container();
              },
            ));
  }
}

class SubTitleWidget extends SliverToBoxAdapter {
  const SubTitleWidget({required this.title, super.key});
  final String title;

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}

class _Content extends StatelessWidget {
  const _Content(
      {required this.title, required this.body, this.padding = 16.0});

  final String title;
  final Widget body;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: 10.0,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: body,
        ),
      ],
    );
  }
}

class _WidgetSummary extends SliverToBoxAdapter {
  TableRow _tableContent({required String title, required String content}) =>
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(content),
        ),
      ]);

  @override
  Widget? get child => Consumer<MovieDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Content(
                  title: 'Release Date',
                  body: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        size: 20.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        movie.releaseDate.toString().split(' ').first,
                        style: const TextStyle(
                          // fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                _Content(
                  title: 'Summary',
                  body: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    children: [
                      _tableContent(
                        title: "Adult",
                        content: movie.adult ? "Yes" : "No",
                      ),
                      _tableContent(
                        title: "Popularity",
                        content: '${movie.popularity}',
                      ),
                      _tableContent(
                        title: "Status",
                        content: movie.status,
                      ),
                      _tableContent(
                        title: "Budget",
                        content: "${movie.budget}",
                      ),
                      _tableContent(
                        title: "Revenue",
                        content: "${movie.revenue}",
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      );
}
