import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/provider/movie_discover_provider.dart';
import 'package:movie_app/widgets/drawer.dart';
import 'package:movie_app/widgets/image.dart';
import 'package:movie_app/widgets/items.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaqueryHeight = MediaQuery.of(context).size.height;
    final myAppBar = AppBar(title: const Text("Home"));
    final bodyHeight = mediaqueryHeight -
        myAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final bodyWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        drawer: DrawerContent(bodyWidth: bodyWidth, bodyHeight: bodyHeight),
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(title: Text("Home")),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Now Playing",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: null,
                        child: Text(
                          "MORE",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
            const WidgetDiscoverMovie()
          ],
        ));
  }
}

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
                  return ItemMovie(movie);
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
