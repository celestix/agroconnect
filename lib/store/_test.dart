import 'package:FarmXpert/models/product_model.dart';

List<Product> getFertz() {
  return [
    const Product(id: "22", name: "Ifco Fert", price: 398),
    const Product(id: "22", name: "Ifco Fert", price: 398),
    const Product(id: "22", name: "Ifco Fert", price: 398),
    const Product(id: "22", name: "Ifco Fert", price: 398),
    const Product(id: "22", name: "Ifco Fert", price: 398),
    const Product(id: "22", name: "Ifco Fert", price: 398),
    const Product(id: "22", name: "Ifco Fert", price: 398),
  ];
}

List<Product> getPestz() {
  return [
    const Product(id: "22", name: "Ifco Pest", price: 484),
    const Product(id: "22", name: "Ifco Pest", price: 484),
    const Product(id: "22", name: "Ifco Pest", price: 484),
    const Product(id: "22", name: "Ifco Pest", price: 484),
    const Product(id: "22", name: "Ifco Pest", price: 484),
    const Product(id: "22", name: "Ifco Pest", price: 484),
    const Product(id: "22", name: "Ifco Pest", price: 484),
    const Product(id: "22", name: "Ifco Pest", price: 484),
  ];
}

List<Product> getProducts(String sectionName) {
  if (sectionName == "Fertilizers") {
    return getFertz();
  } else if (sectionName == "Pesticides") {
    return getPestz();
  } else {
    return [];
  }
}
