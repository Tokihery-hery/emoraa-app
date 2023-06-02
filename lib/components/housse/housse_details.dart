import 'package:emoraa/components/delete_dialog.dart';
import 'package:emoraa/components/housse/housse_form.dart';
import 'package:emoraa/models/house_model.dart';
import 'package:flutter/material.dart';

class HousseDetail extends StatefulWidget {
  const HousseDetail({super.key});

  @override
  State<HousseDetail> createState() => _HousseDetailState();
}

Housse? currentHousse;
double topPosition = 0.0;

class _HousseDetailState extends State<HousseDetail> {
  @override
  Widget build(BuildContext context) {
    final Housse argument =
        ModalRoute.of(context)?.settings.arguments as Housse;
    Size size = MediaQuery.of(context).size;
    topPosition = size.height * 0.4 - 10;
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
          )),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HoussePageForm(
                        currentHousse: argument,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.greenAccent,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteItemDialog(itemId: argument.id!);
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.blue,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                children: [
                  Container(
                    height: size.height * 0.4,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://th.bing.com/th/id/OIP.jzp35I3SdnJLNYISjfXjMAHaE7?pid=ImgDet&rs=1'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: const [
                      Positioned(
                          bottom: 0.3, left: 10, child: Text('Edit Image')),
                    ]),
                  ),
                  Container(
                      height: size.height * 0.2,
                      decoration: const BoxDecoration(color: Colors.red))
                ],
              );
            },
          ),
        ));
  }
}
