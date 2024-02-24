import 'package:FarmXpert/models/product_model.dart';
import 'package:FarmXpert/store/category.dart';
import 'package:FarmXpert/store/helpers.dart';
import 'package:FarmXpert/store/seller_profile.dart';
import 'package:FarmXpert/store/sub_store.dart';
import 'package:FarmXpert/store/seller_signup.dart';
import 'package:FarmXpert/misc/config.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final Map<String, bool> _filterChecklist = {
    "Fertilizers": true,
    "Pesticides": true,
    "Crops": true,
    "Seeds": true,
  };

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

  Future<Widget> getFilteredProducts() async {
    List<String> sectionNames = [];
    _filterChecklist.forEach((key, value) {
      if (value == false) {
        return;
      }
      sectionNames.add(key);
    });
    List<Widget> sections = [];
    for (int i = 0; i < sectionNames.length; i++) {
      sections.add(await getSection(sectionNames[i]));
    }
    return Expanded(
      child: ListView(
        children: [
          ...sections,
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Future<Widget> getSection(String sectionName) async {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(config.navigatorKey.currentContext!).size.width *
                    0.05,
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
            horizontal:
                MediaQuery.of(config.navigatorKey.currentContext!).size.width *
                    0.05,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              children: getProductCards(
                  await getProducts(productCategoryStringToInt(sectionName))),
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
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (config.user!.isSeller == null ||
                          config.user!.isSeller == false)
                      ? const SellerSignupScreen()
                      : const SellerProfileScreen(),
                ));
              },
              icon: const Icon(Icons.account_box),
            ),
            const SizedBox(
              width: 5,
            )
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
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              super.setState(() {});
                                            },
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
              FutureBuilder<Widget>(
                future: getFilteredProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error!}"),
                      );
                    }
                    return snapshot.data!;
                  }
                  return const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.black,
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}
