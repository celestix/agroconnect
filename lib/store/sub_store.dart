// ignore_for_file: no_logic_in_create_state

import 'package:FarmXpert/store/_test.dart';
import 'package:FarmXpert/store/helpers.dart';
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
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 19,
                ),
                children: getProductGrid(getProducts(sectionName)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
