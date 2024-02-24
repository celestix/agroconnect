enum ProductCategory {
  fertilizers(1, "Fertilizers"),
  pesticides(2, "Pesticides"),
  seeds(3, "Seeds"),
  crops(4, "Crops");

  const ProductCategory(this.id, this.name);
  final int id;
  final String name;
}

int productCategoryStringToInt(String category) {
  switch (category) {
    case "Fertilizers":
      return ProductCategory.fertilizers.id;
    case "Pesticides":
      return ProductCategory.pesticides.id;
    case "Seeds":
      return ProductCategory.seeds.id;
    case "Crops":
      return ProductCategory.crops.id;
    default:
      return -1;
  }
}

String productCategoryIntToString(int category) {
  switch (category) {
    case 1:
      return ProductCategory.fertilizers.name;
    case 2:
      return ProductCategory.pesticides.name;
    case 3:
      return ProductCategory.seeds.name;
    case 4:
      return ProductCategory.crops.name;
    default:
      return "Unknown";
  }
}
