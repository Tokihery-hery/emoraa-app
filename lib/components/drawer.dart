import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool _isDrawerOpen = false;

  void _showDrawer() {
    setState(() {
      _isDrawerOpen = true;
    });
  }

  void _hideDrawer() {
    setState(() {
      _isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 40, 125, 237),
              Color.fromARGB(255, 242, 75, 33),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text(
                'John Doe',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              accountEmail: Text(
                'johndoe@example.com',
                textAlign: TextAlign.center,
              ),
              currentAccountPicture:CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/200/300'),
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              arrowColor: Color.fromRGBO(4, 243, 60, 1),
            ),
            ListTile(
              leading: const Icon(Icons.menu_open_sharp),
              title: const Text('Home'),
              onTap: () {
                // Handle drawer item tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle drawer item tap
              },
            ),
          ],
        ),
      ),
    );
  }

  void toggleDrawer() {
    _isDrawerOpen ? _hideDrawer() : _showDrawer();
  }
}
