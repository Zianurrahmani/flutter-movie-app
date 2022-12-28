import 'package:flutter/material.dart';
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
      appBar: myAppBar,
      drawer: DrawerContent(bodyWidth: bodyWidth, bodyHeight: bodyHeight),
      body: Consumer<MovieDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.movies.isNotEmpty) {
            return ListView.builder(itemBuilder: ((context, index) {
              final movie = provider.movies[index];

              return ListTile(
                title: Text(movie.title),
                subtitle: Text(movie.overview),
              );
            }));
          }

          return Center(
            child: Text("Internal Server Error"),
          );
        },
      ),
    );
  }
}
