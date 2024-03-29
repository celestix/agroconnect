import 'package:AgroConnect/models/product_model.dart';
import 'package:AgroConnect/store/add_product.dart';
import 'package:AgroConnect/store/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({
    super.key,
    required this.mainSetState,
  });

  final void Function(void Function()) mainSetState;

  @override
  State<StatefulWidget> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // Future<List<ProductModel>> getMyProducts() async {
    //   return (await getProductsBySeller(
    //           1, FirebaseAuth.instance.currentUser!.uid)) +
    //       (await getProductsBySeller(
    //           2, FirebaseAuth.instance.currentUser!.uid)) +
    //       (await getProductsBySeller(
    //           3, FirebaseAuth.instance.currentUser!.uid)) +
    //       (await getProductsBySeller(
    //           4, FirebaseAuth.instance.currentUser!.uid));
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Seller Portal"),
        elevation: 1,
        surfaceTintColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      ),
      body: Center(
        child: FutureBuilder<List<ProductModel>>(
          future: getProductsBySeller(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error!}"),
                );
              }
              return Column(
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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductUploadScreen(
                                parentSetState: (x) => {
                                  setState(() {
                                    widget.mainSetState(() {});
                                  })
                                },
                              ),
                            ));
                          },
                          icon: const Icon(Icons.add_box),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 155,
                    child: (snapshot.data != null && snapshot.data!.isNotEmpty)
                        ? ListView(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 30,
                            ),
                            children: getProductGrid(
                              snapshot.data!,
                            ),
                          )
                        : const Center(
                            child: Text(
                                "You have not published any products yet."),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
