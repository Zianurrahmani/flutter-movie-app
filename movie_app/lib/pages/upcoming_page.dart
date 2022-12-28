import 'package:flutter/material.dart';
import 'package:movie_app/widgets/drawer.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaqueryHeight = MediaQuery.of(context).size.height;
    final myAppBar = AppBar(title: const Text("Upcoming"));
    final bodyHeight = mediaqueryHeight -
        myAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final bodyWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: myAppBar,
      drawer: DrawerContent(bodyWidth: bodyWidth, bodyHeight: bodyHeight),
      body: Center(
        child: Text("Upcoming"),
      ),
    );
  }
}
