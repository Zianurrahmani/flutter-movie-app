import 'package:flutter/material.dart';
import 'package:movie_app/pages/nowplaying_page.dart';
import 'package:movie_app/pages/search_page.dart';
import 'package:movie_app/pages/toprated_page.dart';
import 'package:movie_app/pages/upcoming_page.dart';
import 'package:movie_app/widgets/drawer.dart';
import 'package:movie_app/widgets/nowplaying_item_card.dart';
import 'package:movie_app/widgets/sliver_title.dart';
import 'package:movie_app/widgets/toprated_item_card.dart';
import 'package:movie_app/widgets/upcoming_item_card.dart';

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
            SliverAppBar(
              title: const Text("Home"),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                  onPressed: () => showSearch(
                    context: context,
                    delegate: MovieSearchPage(),
                  ),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            SliverTitle(
              title: 'Now Playing',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NowPlayingPage(),
                    ));
              },
            ),
            const WidgetDiscoverMovie(),
            SliverTitle(
              title: 'Top Rated',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TopRatedPage(),
                    ));
              },
            ),
            const WidgetTopRatedMovie(),
            SliverTitle(
              title: 'Upcoming',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UpcomingPage(),
                    ));
              },
            ),
            const WidgetUpcomingMovie()
          ],
        ));
  }
}
