class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.seller,
    this.image,
  });

  final String id;
  final String name;
  final double price;
  final String? description;
  final String? seller;
  final String? image;
}
