import 'package:emoraa/components/bull_bull.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  final AnimationController animationController;
  const CardWidget({
    super.key,
    required this.size,
    required this.animationController,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animationController),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/payment_detail');
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, top: 10.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 40, 125, 237),
                Color.fromARGB(193, 243, 109, 76),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(5),
            ),
          ),
          width: 84 + 3,
          child: Container(
            margin: const EdgeInsets.only(top: 2),
            height: 130,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                const Positioned(
                  top: 1,
                  left: 10,
                  child: BullBull(height: 10, width: 10),
                ),
                Positioned(
                  top: -20,
                  left: -5,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color.fromARGB(96, 255, 255, 255),
                      ),
                      child: Stack(
                        children: const <Widget>[
                          Positioned(
                            left: 7,
                            top: 5,
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://th.bing.com/th/id/R.fa42c676414e764714ed10eab6118224?rik=BxHYh72EjCIgDA&riu=http%3a%2f%2fwww.creaflo.com%2fwp-content%2fuploads%2f2017%2f09%2fmoi-1.jpg&ehk=Ze2LFIr%2bLdVpXo8nLOCHW%2fkRsNNRBoFKD1m%2bp75G4Iw%3d&risl=&pid=ImgRaw&r=0")),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 35, bottom: 0),
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    children: [
                      const Text(
                        "Chambre N°2",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text.rich(
                        TextSpan(
                          text: "Rakoto",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 12.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            textBaseline: TextBaseline.ideographic,
                          ),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text(
                            "Delai : 02/03/2023",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 8.0,
                              fontFamily: "Lato",
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const <Widget>[
                          Text(
                            "Retard, il y a",
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 8.0,
                              color: Colors.white,
                              fontFamily: "Calibri",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "2 jours",
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 8.0,
                              color: Colors.white,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 23,
                        width: 23,
                        child: ElevatedButton(
                          clipBehavior: Clip.none,
                          style: ButtonStyle(
                            animationDuration: const Duration(microseconds: 2),
                            alignment: Alignment.topRight,
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 20),
                            ),
                            elevation: MaterialStateProperty.all(20),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: Image.asset(
                            'assets/images/cash-icon.png',
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
