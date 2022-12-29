import 'package:flutter/material.dart';
import 'package:movie_app/widgets/drawer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaqueryHeight = MediaQuery.of(context).size.height;
    final myAppBar = AppBar(title: const Text("About"));
    final bodyHeight = mediaqueryHeight -
        myAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final bodyWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: myAppBar,
      drawer: DrawerContent(bodyWidth: bodyWidth, bodyHeight: bodyHeight),
      body: const Center(
        child: Text("About"),
      ),
    );
  }
}
