import 'package:FarmXpert/store/_test.dart';
import 'package:FarmXpert/store/helpers.dart';
import 'package:flutter/material.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("E-Seller Portal"),
          elevation: 1,
          surfaceTintColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 252, 252, 252),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Row(
                  children: [
                    const Text(
                      "My Products",
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_box),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 155,
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 19,
                  ),
                  children: getProductGrid(getProducts("Fertilizers")),
                ),
              ),
            ],
          ),
        ));
  }
}
