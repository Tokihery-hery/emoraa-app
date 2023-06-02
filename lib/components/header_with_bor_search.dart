import 'package:emoraa/components/bull_bull.dart';
import 'package:flutter/material.dart';

class HeaderWithSearchBox extends StatelessWidget {
  final AnimationController animationController;

  const HeaderWithSearchBox({
    super.key,
    required this.size, 
    required this.animationController,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: const EdgeInsets.only(
        bottom: 20.0 * 1.5
      )     ,
      height: size.height * 0.2 - 27,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          const Positioned(left: 10,  top: 5 ,child: BullBull(height: 90, width: 90)),
          const Positioned(left: 30,  top: 13 ,child: BullBull(height: 20, width: 20)),
          Container(
            padding:
                const EdgeInsets.only(left: 22.0, right: 20.0, bottom: 56.0),
            height: size.height * 0.2 - 27,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 40, 125, 237),
                  Color.fromARGB(255, 242, 75, 33),
                ], end: Alignment.topRight, begin: Alignment.topLeft),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
            child: Row(
              children: <Widget>[
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero
                  ).animate(animationController),
                  child: FadeTransition(
                    opacity: animationController,
                    child: Text(
                      'Hi emoraa !',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Spacer(),
                 SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-2, 0),
                    end: Offset.zero
                  ).animate(animationController),
                  child: Image.asset("assets/images/logo.png", width: 100
                  )
                )
              ],
            ),
          ),
          Positioned(
              bottom: -27,
              left: 10,
              right: 10,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 54,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(8, 10),
                        blurRadius: 50,
                        color: const Color.fromARGB(186, 162, 82, 232)
                            .withOpacity(0.23),
                      )
                    ]),
                child: TextField(
                  onChanged: (value) => {print("'$value' rhis a val")},
                  decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.blue.shade200),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 40, 125, 237),
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
