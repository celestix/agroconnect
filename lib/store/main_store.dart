import 'package:FarmXpert/store/helpers.dart';
import 'package:FarmXpert/store/sub_store.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final Map<String, bool> _filterChecklist = {};
  Row getChecklistElement(
      String name, void Function(void Function()) setState) {
    if (_filterChecklist[name] == null) {
      _filterChecklist[name] = true;
    }
    return Row(
      children: [
        Checkbox(
          value: _filterChecklist[name]!,
          onChanged: (value) {
            setState(() {
              _filterChecklist[name] = value ?? false;
            });
          },
          fillColor: MaterialStatePropertyAll(
            _filterChecklist[name]! ? Colors.black : Colors.white,
          ),
          checkColor: Colors.white,
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget getSection(String sectionName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Row(
            children: [
              Text(
                sectionName,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0),
                  backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 252, 252, 252),
                  ),
                  overlayColor: MaterialStatePropertyAll(Colors.grey[200]),
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SubStoreScreen(
                    sectionName: sectionName,
                  ),
                )),
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Color.fromARGB(255, 77, 77, 77),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              children: [
                getProductCard("1", "Test Product 1", 100),
                getProductCard("2", "Test Product 2", 100),
                getProductCard("3", "Test Product 3", 100),
                getProductCard("4", "Test Product 4", 100),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
        appBar: AppBar(
          title: const Text(
            "Store",
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
          elevation: 1,
          surfaceTintColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 252, 252, 252),
          // shadowColor: Colors.black,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "All Products",
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return SimpleDialog(
                                  surfaceTintColor: Colors.white,
                                  elevation: 0,
                                  title: const Text(
                                    "Filter",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  titlePadding: const EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  children: [
                                    getChecklistElement(
                                        "Fertilizers", setState),
                                    getChecklistElement("Pesticides", setState),
                                    getChecklistElement("Crops", setState),
                                    getChecklistElement("Seeds", setState),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("OK"),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(0),
                        backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 252, 252, 252),
                        ),
                        overlayColor:
                            MaterialStatePropertyAll(Colors.grey[200]),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filter",
                            style: TextStyle(
                              fontFamily: "SF Pro Display",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[500],
                            ),
                          ),
                          Icon(
                            Icons.arrow_downward,
                            size: 15,
                            color: Colors.grey[500],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView(
                  children: [
                    getSection("Fertilizers"),
                    getSection("Pesticides"),
                    getSection("Seeds"),
                    getSection("Crops"),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
