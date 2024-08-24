import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/views/favorite_view.dart';
import 'package:movie_app/views/home_view.dart';
import 'package:movie_app/views/search_view.dart';
import 'package:movie_app/views/widgets/custom_drawer.dart';

class StartView extends StatefulWidget {
  const StartView({super.key, required this.email});
  final String email;
  @override
  // ignore: library_private_types_in_public_api
  _StartViewState createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  int currentIndex = 0;
  void changeBottomNavBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget getCurrentScreen() {
    return screens[currentIndex];
  }

  final List<Widget> screens = [
    const HomeView(),
    const Searchview(),
    const FavoriteView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        email: widget.email,
      ),
      appBar: AppBar(
        title: const Text(
          'Night Movies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        backgroundColor: const Color.fromARGB(255, 142, 3, 3),
        elevation: 0,
        // leading: const Icon(Icons.menu, color: Colors.white, size: 30),
      ),
      body: getCurrentScreen(),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: changeBottomNavBar,
        items: const [
          Icon(
            Icons.home,
            size: 30,
            semanticLabel: 'Home',
          ),
          Icon(
            Icons.search,
            size: 30,
            semanticLabel: 'Search',
          ),
          Icon(
            Icons.favorite,
            size: 30,
            semanticLabel: 'Favorite',
          ),
        ],
        backgroundColor: Colors.black,
        color: const Color.fromARGB(255, 142, 3, 3),
      ),
    );
  }
}
