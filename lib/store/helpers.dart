import 'package:FarmXpert/models/product_model.dart';
import 'package:flutter/material.dart';

List<Row> getProductGrid(List<ProductModel> products) {
  List<Row> productGrid = [];
  int elemsCount = 0;
  List<Card> elems = [];
  for (int i = 0; i < products.length; i++) {
    final ProductModel product = products[i];
    elemsCount++;
    elems.add(getProductCard(product.id, product.name, product.price));
    if (elemsCount == 2 || i == products.length - 1) {
      productGrid.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: elems,
        ),
      );
      elems = [];
      elemsCount = 0;
    }
  }
  return productGrid;
}

Card getProductCard(String productId, String productName, double productPrice,
    {Image? productImage}) {
  return Card(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
      Radius.circular(10),
    )),
    elevation: 1,
    surfaceTintColor: Colors.white,
    color: Colors.white,
    child: InkWell(
      onTap: () => {
        // do something using product id
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
            width: 150,
            child:
                productImage ?? Image.asset("assets/images/store/img404.jpg"),
          ),
          Text(
            productName,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 34, 78),
              fontFamily: "SF Pro Display",
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.currency_rupee,
                size: 17,
                fill: 1,
                grade: 100,
                weight: 100,
                color: Color.fromARGB(255, 0, 34, 78),
              ),
              Text(
                "$productPrice",
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 34, 78),
                  fontFamily: "SF Pro Display",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
