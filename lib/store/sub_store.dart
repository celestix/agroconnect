// ignore_for_file: no_logic_in_create_state
import 'package:AgroConnect/models/product_model.dart';
import 'package:AgroConnect/store/category.dart';
import 'package:AgroConnect/store/helpers.dart';
import 'package:flutter/material.dart';

class SubStoreScreen extends StatefulWidget {
  const SubStoreScreen({super.key, required this.sectionName});

  final String sectionName;

  @override
  State<StatefulWidget> createState() => _SubStoreScreenState(sectionName);
}

class _SubStoreScreenState extends State<SubStoreScreen> {
  _SubStoreScreenState(this.sectionName);

  final String sectionName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Text(
                sectionName,
                style: const TextStyle(
                  fontFamily: "SF Pro Display",
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Divider(
              color: Colors.grey[300],
            ),
            FutureBuilder<List<ProductModel>>(
                future: getProducts(productCategoryStringToInt(sectionName)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error!}"),
                      );
                    }
                    return Expanded(
                      child: (snapshot.data != null &&
                              snapshot.data!.isNotEmpty)
                          ? ListView(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              children: getProductGrid(snapshot.data!),
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text("No products found."),
                                ),
                              ],
                            ),
                    );
                  } else {
                    return const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
