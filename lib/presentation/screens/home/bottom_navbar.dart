import 'package:flutter/material.dart';
import 'package:found_one/presentation/screens/home/home_screen.dart';
import 'package:found_one/presentation/screens/post/create_post_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _page = 0;

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [const HomeScreen(), const CreatePostScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: onPageChanged,
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add), 
            label: "Post"
          ),
        ],
      ),
    );
  }
}
