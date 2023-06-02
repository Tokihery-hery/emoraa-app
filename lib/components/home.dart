import 'dart:async';

import 'package:emoraa/components/crad.dart';
import 'package:emoraa/components/header_status_pages.dart';
import 'package:emoraa/components/header_with_bor_search.dart';
import 'package:emoraa/components/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    Timer(const Duration(milliseconds: 200),
        () => _animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(
            size: size,
            animationController: _animationController,
          ),
          FadeTransition(
            opacity: _animationController,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20.0 * 0.5, top: 20),
              height: size.height * 0.2,
              width: size.width * 0.9,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      offset: Offset.zero,
                      blurStyle: BlurStyle.inner),
                ],
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 82, 145, 228),
                  Color.fromARGB(255, 226, 162, 146),
                ], end: Alignment.topRight, begin: Alignment.topLeft),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text("12"),
                        const Text("89"),
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(50)),
                            margin: const EdgeInsets.only(left: 2.2),
                            child: Center(
                                child: IconButton(
                              color: Colors.white70,
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                print('ELLOP');
                              },
                            ))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          HeaderStatusPage(
              textTitle: "Retard en paiement",
              textButton: 'Voir plus +',
              showMore: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }),
          FadeTransition(
            opacity: _animationController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  CardWidget(
                      size: size, animationController: _animationController),
                  CardWidget(
                      size: size, animationController: _animationController),
                  CardWidget(
                      size: size, animationController: _animationController),
                  CardWidget(
                      size: size, animationController: _animationController),
                  CardWidget(
                      size: size, animationController: _animationController),
                  CardWidget(
                      size: size, animationController: _animationController),
                  CardWidget(
                      size: size, animationController: _animationController),
                  CardWidget(
                      size: size, animationController: _animationController),
                  CardWidget(
                      size: size, animationController: _animationController),
                  CardWidget(
                      size: size, animationController: _animationController),
                  CardWidget(
                      size: size, animationController: _animationController),
                  CardWidget(
                      size: size, animationController: _animationController),
                ],
              ),
            ),
          ),
          HeaderStatusPage(
            textButton: "Plus d'action",
            textTitle: "Action",
            showMore: () {},
          )
        ],
      ),
    );
  }
}
