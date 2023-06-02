import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:emoraa/components/chatter/chatter.dart';
import 'package:emoraa/components/chatter/client_chatter.dart';
import 'package:emoraa/components/drawer.dart';
import 'package:emoraa/components/home.dart';
import 'package:emoraa/components/housse/hourse.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> Screens = [
    const Chatter(),
    const HoussePage(),
    const ClientChatter()
  ];
  int selectedIndex = 0;

  void _changeIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: non_constant_identifier_names

    // ignore: no_leading_underscores_for_local_identifiers

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          flexibleSpace: const FlexibleSpaceBar(
              background: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 40, 125, 237),
                  Color.fromARGB(255, 242, 75, 33),
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ))),
      drawer: const DrawerPage(),
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedIndex,
        buttonBackgroundColor: const Color.fromARGB(255, 230, 84, 138),
        items: const <Widget>[
          Icon(Icons.home, color: Colors.white, size: 15),
          Icon(Icons.person_3, color: Colors.white, size: 15),
          Icon(
            Icons.messenger,
            color: Colors.white,
            size: 15,
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        color: const Color.fromARGB(255, 91, 129, 225),
        animationDuration: const Duration(milliseconds: 200),
        animationCurve: Curves.linear,
        onTap: _changeIndex,
      ),
      body: Screens[selectedIndex],
    );
  }
}
