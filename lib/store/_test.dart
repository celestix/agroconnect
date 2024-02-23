import 'package:FarmXpert/models/product_model.dart';

List<ProductModel> getFertz() {
  return [
    ProductModel(id: "22", name: "Ifco Fert", price: 398),
    ProductModel(id: "22", name: "Ifco Fert", price: 398),
    ProductModel(id: "22", name: "Ifco Fert", price: 398),
    ProductModel(id: "22", name: "Ifco Fert", price: 398),
    ProductModel(id: "22", name: "Ifco Fert", price: 398),
    ProductModel(id: "22", name: "Ifco Fert", price: 398),
    ProductModel(id: "22", name: "Ifco Fert", price: 398),
  ];
}

List<ProductModel> getPestz() {
  return [
    ProductModel(id: "22", name: "Ifco Pest", price: 484),
    ProductModel(id: "22", name: "Ifco Pest", price: 484),
    ProductModel(id: "22", name: "Ifco Pest", price: 484),
    ProductModel(id: "22", name: "Ifco Pest", price: 484),
    ProductModel(id: "22", name: "Ifco Pest", price: 484),
    ProductModel(id: "22", name: "Ifco Pest", price: 484),
    ProductModel(id: "22", name: "Ifco Pest", price: 484),
    ProductModel(id: "22", name: "Ifco Pest", price: 484),
  ];
}

List<ProductModel> getProducts(String sectionName) {
  if (sectionName == "Fertilizers") {
    return getFertz();
  } else if (sectionName == "Pesticides") {
    return getPestz();
  } else {
    return [];
  }
}
