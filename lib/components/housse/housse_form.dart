import 'package:emoraa/models/db_helper.dart';
import 'package:emoraa/models/house_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HoussePageForm extends StatefulWidget {
  const HoussePageForm({super.key, this.currentHousse});
  final Housse? currentHousse;
  @override
  State<HoussePageForm> createState() => _HoussePageFormState();
}

final TextEditingController _titleController = TextEditingController();
final TextEditingController _descController = TextEditingController();
final TextEditingController _priceController = TextEditingController();
final TextEditingController _chcountController = TextEditingController();
bool hasWcController = false;
bool hasDouchController = false;
bool hasCheckenController = false;

class _HoussePageFormState extends State<HoussePageForm> {
  void _addChambres() async {
    final provider = Provider.of<SQLHelper>(context, listen: false);
    try {
      await provider.insertChambre(
        Housse(
          title: _titleController.text,
          price: int.parse(_priceController.text),
          descrption: _descController.text,
          chCount: int.parse(_chcountController.text),
          createdAt: DateTime.now().toString(),
          hasChecken: 0,
          hasDouche: 1,
          hasWC: 0,
        ),
      );
      Fluttertoast.showToast(
        msg: 'Created successfull',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        textColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 131, 220, 91),
      );
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        textColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 254, 0, 0),
      );
    }
  }

  void _updatedChambres(int id, Housse currentHousse) async {
    final provider = Provider.of<SQLHelper>(context, listen: false);
    try {
      Housse updatedHousse = Housse(
        id: currentHousse.id,
        ownerId: currentHousse.ownerId,
        title: _titleController.text,
        price: int.parse(_priceController.text),
        chCount: int.parse(_chcountController.text),
        descrption: _descController.text,
        hasChecken: hasCheckenController ? 1 : 0,
        hasDouche: hasDouchController ? 1 : 0,
        hasWC: hasWcController ? 1 : 0,
        createdAt: currentHousse.createdAt,
      );

      await provider.updateChambre(id, updatedHousse);
      Fluttertoast.showToast(
        msg: 'Updated successfull',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        textColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 131, 220, 91),
      );
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        textColor: const Color.fromARGB(255, 225, 210, 210),
        backgroundColor: const Color.fromARGB(255, 158, 19, 19),
      );
    }
  }

  @override
  void initState() {
    setState(() {
      hasCheckenController = widget.currentHousse?.hasChecken == 1;
      hasWcController = widget.currentHousse?.hasWC == 1;
      hasDouchController = widget.currentHousse?.hasDouche == 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    late final Housse currentHousse;
    int? id;
    if (widget.currentHousse != null) {
      setState(() {
        currentHousse = widget.currentHousse as Housse;
        id = currentHousse.id;
      });
      _titleController.text = currentHousse.title;
      _descController.text = currentHousse.descrption;
      _priceController.text = currentHousse.price.toString();
      _chcountController.text = currentHousse.chCount.toString();
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: size.height * 0.07,
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
          icon: const Icon(
            Icons.arrow_back,
            size: 15,
          ),
          onPressed: () {
            Navigator.pop(context);
            id = null;
            _titleController.clear();
            _descController.clear();
            _priceController.clear();
            _chcountController.clear();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 50,
              width: size.width,
              margin: const EdgeInsets.only(bottom: 20, top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 40, 125, 237),
                    Color.fromARGB(255, 242, 75, 33),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      top: -10,
                      right: 5,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, left: 8, right: 20),
                    child: Text(
                      "Make sur, You have this house, You can delte it",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white60,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  hintText: "Nom du chambres",
                  labelText: "Nom",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
              cursorHeight: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: TextField(
                      controller: _chcountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Nombre",
                        labelText: "Nombre",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Combien",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Has Checken"),
                Switch(
                  value: hasCheckenController,
                  onChanged: (bool value) {
                    setState(() {
                      hasCheckenController = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Has Bathroom"),
                Switch(
                  value: hasDouchController,
                  onChanged: (bool value) {
                    setState(() {
                      hasDouchController = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Has Wc"),
                Switch(
                  value: hasWcController,
                  onChanged: (bool value) {
                    setState(() {
                      hasWcController = value;
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: id!=null?Alignment.topLeft: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  if (id == null) {
                    _addChambres();
                    id = null;
                  }
                  if (id != null) {
                    _updatedChambres(id!, currentHousse);
                    id = null;
                  }
                  _titleController.clear();
                  _descController.clear();
                  _priceController.clear();
                  _chcountController.clear();
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: id == null ? Colors.blue : Colors.green,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      )),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        id == null ? Icons.add : Icons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(id == null ? "Ajouter" : "Mettre à jours", 
                      style: const TextStyle(
                        color: Colors.white
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
