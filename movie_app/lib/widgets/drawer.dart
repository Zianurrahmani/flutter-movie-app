import 'package:flutter/material.dart';

import '../pages/about_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/nowplaying_page.dart';
import '../pages/toprated_page.dart';
import '../pages/upcoming_page.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({
    Key? key,
    required this.bodyWidth,
    required this.bodyHeight,
  }) : super(key: key);

  final double bodyWidth;
  final double bodyHeight;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://thumbs.dreamstime.com/b/light-blue-abstract-background-square-shapes-bright-navy-dynamic-vector-diagonal-lines-cover-business-presentation-sale-207204578.jpg"))),
            width: bodyWidth,
            height: bodyHeight * 0.2,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(70))),
                  height: 70,
                  width: 70,
                ),
                const Text(
                  "Zianurrahmani",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            width: bodyWidth,
            height: bodyHeight * 0.55,
            color: Colors.white,
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const DashboardPage())));
                  },
                  leading: const Icon(
                    Icons.home,
                    size: 20,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const NowPlayingPage())));
                  },
                  leading: const Icon(
                    Icons.play_circle_outlined,
                    size: 20,
                  ),
                  title: const Text(
                    "Now Playing",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const TopRatedPage())));
                  },
                  leading: const Icon(
                    Icons.show_chart_outlined,
                    size: 20,
                  ),
                  title: const Text(
                    "Top Rated",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const UpcomingPage())));
                  },
                  leading: const Icon(
                    Icons.live_tv_outlined,
                    size: 20,
                  ),
                  title: const Text(
                    "Upcoming",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const AboutPage())));
                  },
                  leading: const Icon(
                    Icons.help_outlined,
                    size: 20,
                  ),
                  title: const Text(
                    "About",
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
