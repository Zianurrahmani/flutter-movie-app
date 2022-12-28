import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app_credentials.dart';
import 'package:movie_app/provider/movie_discover_provider.dart';
import 'package:movie_app/widgets/drawer.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieDiscoverProvider>().getDiscover(context);
    });

    final mediaqueryHeight = MediaQuery.of(context).size.height;
    final myAppBar = AppBar(title: const Text("Home"));
    final bodyHeight = mediaqueryHeight -
        myAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final bodyWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        drawer: DrawerContent(bodyWidth: bodyWidth, bodyHeight: bodyHeight),
        body: CustomScrollView(
          slivers: [SliverAppBar(title: Text("Home")), WidgetDiscoverMovie()],
        ));
  }
}

class WidgetDiscoverMovie extends SliverToBoxAdapter {
  @override
  // TODO: implement child
  Widget? get child => Consumer<MovieDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Center(
              child: Container(
                child: Text("Loading"),
              ),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
                itemCount: provider.movies.length,
                itemBuilder: (_, index, __) {
                  final movie = provider.movies[index];
                  return Image.network(
                      '${AppCredentials.baseImageUrl}${movie.backdropPath}');
                },
                options: CarouselOptions(
                  viewportFraction: 0.8,
                  reverse: false,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ));
          }

          return Center(
            child: Container(child: Text("Internal Server Error")),
          );
        },
      );
}
