import 'package:cloud_firestore/cloud_firestore.dart';

const _productCollection = 'products';

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.seller,
    this.image,
  });

  late final String id;
  late final String name;
  late final double price;
  late final String? description;
  late final String? seller;
  late final String? image;

  ProductModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
    description = map['description'];
    seller = map['seller'];
    image = map['image'];
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
        .collection(_productCollection)
        .doc(id)
        .set(toMap());
  }

  Future<void> update({FirebaseFirestore? dbInstance}) async {
    await (dbInstance ?? FirebaseFirestore.instance)
        .collection(_productCollection)
        .doc(id)
        .update(toMap());
  }

  Future<void> delete({FirebaseFirestore? dbInstance}) async {
    await (dbInstance ?? FirebaseFirestore.instance)
        .collection(_productCollection)
        .doc(id)
        .delete();
  }
}
