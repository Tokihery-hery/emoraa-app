import 'dart:io';
import 'package:emoraa/components/housse/housse_details.dart';
import 'package:emoraa/components/housse/housse_form.dart';
import 'package:emoraa/components/login.dart';
import 'package:emoraa/components/nav_bar.dart';
import 'package:emoraa/components/payment/payment_page.dart';
import 'package:emoraa/components/transition.dart';
import 'package:emoraa/models/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
  databaseFactory = databaseFactoryFfi;

  runApp(
      ChangeNotifierProvider(create: (_) => SQLHelper(), child: const MyApp()));
  }else{
     runApp(
      ChangeNotifierProvider(create: (_) => SQLHelper(), child: const MyApp()));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/housse_form') {
          return PageRouteBuilder(
            settings: RouteSettings(
              name: settings.name,
              arguments: settings.arguments
            ),
            pageBuilder: (_, __, ___) => const HoussePageForm(),
            transitionDuration: const Duration(milliseconds: 150),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return TransitionPage(animation: animation, child: child);
            },
          );
        }
        if (settings.name == '/housse_detail') {
          return PageRouteBuilder(
            settings: RouteSettings(
              name: settings.name,
              arguments: settings.arguments
            ),
            pageBuilder: (context, __, ___) => const HousseDetail(),
            transitionDuration: const Duration(milliseconds: 150),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return TransitionPage(animation: animation, child: child);
            },
          );
        }
        if (settings.name == '/payment_detail') {
          return PageRouteBuilder(
            settings: RouteSettings(
              name: settings.name,
              arguments: settings.arguments
            ),
            pageBuilder: (_, __, ___) => const PaymentPage(),
            transitionDuration: const Duration(milliseconds: 150),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return TransitionPage(animation: animation, child: child);
            },
          );
        }
        return null;
      },
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: const NavBar(),
    );
  }
}


class MyDesk extends StatefulWidget {
  const MyDesk({Key? key}) : super(key: key);

  @override
  State<MyDesk> createState() => MyDeskState();
}

class MyDeskState extends State<MyDesk> {
  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/housse_form') {
          return PageRouteBuilder(
            settings: RouteSettings(
              name: settings.name,
              arguments: settings.arguments
            ),
            pageBuilder: (_, __, ___) => const HoussePageForm(),
            transitionDuration: const Duration(milliseconds: 150),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return TransitionPage(animation: animation, child: child);
            },
          );
        }
        if (settings.name == '/housse_detail') {
          return PageRouteBuilder(
            settings: RouteSettings(
              name: settings.name,
              arguments: settings.arguments
            ),
            pageBuilder: (context, __, ___) => const HousseDetail(),
            transitionDuration: const Duration(milliseconds: 150),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return TransitionPage(animation: animation, child: child);
            },
          );
        }
        return null;
      },
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}