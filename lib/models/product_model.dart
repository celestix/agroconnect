import 'package:cloud_firestore/cloud_firestore.dart';

const _productCollection = 'products';

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.description,
    this.seller,
    this.image,
  });

  late final String id;
  late final String name;
  late final double price;
  late final int category;
  late final String? description;
  late final String? seller;
  late final String? image;

  ProductModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
    seller = map['seller'];
    image = map['image'];
    description = map['description'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'seller': seller,
      'image': image,
    };
  }

  Future<void> add({FirebaseFirestore? dbInstance}) async {
    await (dbInstance ?? FirebaseFirestore.instance)
        .collection("$_productCollection-$category")
        .doc(id)
        .set(toMap());
  }

  Future<void> update({FirebaseFirestore? dbInstance}) async {
    await (dbInstance ?? FirebaseFirestore.instance)
        .collection("$_productCollection-$category")
        .doc(id)
        .update(toMap());
  }

  Future<void> delete({FirebaseFirestore? dbInstance}) async {
    await (dbInstance ?? FirebaseFirestore.instance)
        .collection("$_productCollection-$category")
        .doc(id)
        .delete();
  }
}

Future<ProductModel> getProduct(String id, int category,
    {FirebaseFirestore? dbInstance}) async {
  final product = await (dbInstance ?? FirebaseFirestore.instance)
      .collection("$_productCollection-$category")
      .doc(id)
      .get();
  return ProductModel.fromMap(product.data()!);
}

Future<List<ProductModel>> getProducts(int category,
    {FirebaseFirestore? dbInstance, int? limit}) async {
  final products = await (dbInstance ?? FirebaseFirestore.instance)
      .collection("$_productCollection-$category")
      .limit(limit ?? 100)
      .get();
  return products.docs
      .map((product) => ProductModel.fromMap(product.data()))
      .toList();
}

Future<List<ProductModel>> getProductsBySeller(int category, String seller,
    {FirebaseFirestore? dbInstance, int? limit}) async {
  final products = await (dbInstance ?? FirebaseFirestore.instance)
      .collection("$_productCollection-$category")
      .where('seller', isEqualTo: seller)
      .limit(limit ?? 100)
      .get();
  return products.docs
      .map((product) => ProductModel.fromMap(product.data()))
      .toList();
}
