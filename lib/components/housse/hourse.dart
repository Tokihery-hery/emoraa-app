import 'dart:async';
import 'dart:math';

import 'package:emoraa/models/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class HoussePage extends StatefulWidget {
  const HoussePage({super.key});

  @override
  State<HoussePage> createState() => _HoussePageState();
}

final TextEditingController _searchController = TextEditingController();

class _HoussePageState extends State<HoussePage>
    with SingleTickerProviderStateMixin {
  late Future _housses;
  late AnimationController _animationController;

  Future _getHOusses() async {
    final provider = Provider.of<SQLHelper>(context, listen: false);
    return await provider.getChambres();
  }

  bool _isLoading = true;
  void _refresh() async {
    setState(() {
      _housses = _getHOusses();
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    Timer(const Duration(milliseconds: 100),
        () => _animationController.forward());
    print("...numbre of chnamgre ${_housses}");
  }

  String _formatDate(String? dateString) {
    print(dateString);
    dateString ??= "2023-05-29 16:22:02.495450";
    final inputFormat = DateFormat('yyyy-dd-MM', 'en_US');
    final date = inputFormat.parse(dateString);
    initializeDateFormatting('fr_FR');
    final dateFormat = DateFormat('MMMM, d yyyy', 'fr_FR');

    return dateFormat.format(date);
  }

  String formatCurrency(int amount, String currencyCode) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_US', // Specify the desired locale
      symbol: currencyCode, // Specify the currency symbol
    );

    return currencyFormat.format(amount);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _housses,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Consumer<SQLHelper>(builder: (_, db, __) {
                var housses = db.housses;
                return Scaffold(
                    body: RefreshIndicator(
                      onRefresh: () async {
                        _refresh();
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 40, 125, 237),
                              Color.fromARGB(255, 242, 75, 33),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: size.height * 0.045,
                                margin: const EdgeInsets.only(
                                  bottom: 5,
                                  left: 5,
                                  right: 5,
                                ),
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (value) {
                                    db.searchHouse = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Search",
                                    hintStyle: TextStyle(
                                      color: Colors.blue.shade200,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    suffixIcon: const Icon(
                                      Icons.search,
                                      color: Color.fromARGB(
                                        255,
                                        40,
                                        125,
                                        237,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              _searchController.text.isNotEmpty
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                      ),
                                      alignment: Alignment.topLeft,
                                      height: size.height * 0.035,
                                      child: Text(
                                          "${housses.length} Results found"),
                                    )
                                  : const Text(''),
                              Expanded(
                                child: FadeTransition(
                                  opacity: _animationController,
                                  child: ListView.builder(
                                    itemCount: housses.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/housse_detail',
                                              arguments: housses[index]);
                                        },
                                        child: SlideTransition(
                                          position: Tween<Offset>(
                                                  begin: Offset(
                                                      Random().nextInt(2) - 1,
                                                      Random().nextInt(2) - 1),
                                                  end: Offset.zero)
                                              .animate(_animationController),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              bottom: 5.0,
                                              left: 5.0,
                                              right: 5.0,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 1.0,
                                              vertical: 3.0,
                                            ),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.0),
                                              ),
                                            ),
                                            child: ListTile(
                                              isThreeLine: true,
                                              trailing: Stack(
                                                fit: StackFit.passthrough,
                                                alignment: AlignmentDirectional
                                                    .bottomEnd,
                                                children: [
                                                  Text(
                                                    formatCurrency(
                                                            housses[index]
                                                                .price,
                                                            'Ar')
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 50,
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(Icons.add),
                                                  )
                                                ],
                                              ),
                                              title: Text(
                                                housses[index].title.trim(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _formatDate(housses[index]
                                                        .createdAt),
                                                    style: const TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(housses[index]
                                                              .descrption
                                                              .trim()
                                                              .length <
                                                          80
                                                      ? housses[index]
                                                          .descrption
                                                          .trim()
                                                      : "${housses[index].descrption.trim().substring(0, 80)} ..."),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      if (housses[index]
                                                              .hasWC ==
                                                          1)
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 3.0,
                                                            horizontal: 8.0,
                                                          ),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    114,
                                                                    219,
                                                                    100),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                20.0,
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            'WC',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      if (housses[index]
                                                              .hasDouche ==
                                                          1)
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 3.0,
                                                            horizontal: 8.0,
                                                          ),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.amber,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                20.0,
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            'Douche',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      if (housses[index]
                                                              .hasChecken ==
                                                          1)
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 3.0,
                                                            horizontal: 8.0,
                                                          ),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.amber,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                20.0,
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            'Cuissine',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/housse_form');
                      },
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.add),
                    ));
              });
            }
          } else {
            return Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 40, 125, 237),
                  Color.fromARGB(255, 242, 75, 33)
                ])),
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
        });
  }
}
