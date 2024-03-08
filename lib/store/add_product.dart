import 'package:AgroConnect/misc/config.dart';
import 'package:AgroConnect/models/product_model.dart';
import 'package:AgroConnect/store/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/v4.dart';

class ProductUploadScreen extends StatefulWidget {
  const ProductUploadScreen({
    super.key,
    required this.parentSetState,
  });

  final void Function(void Function()) parentSetState;

  @override
  State<StatefulWidget> createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  _ProductUploadScreenState();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productCategoryController =
      TextEditingController();
  XFile? _productImage;

  final ImagePicker picker = ImagePicker();

  Future getImage() async {
    _productImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
  }

  Future submitProduct() async {
    if (_productNameController.text == "") {
      config.scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Product name cannot be empty."),
        ),
      );
      return;
    }
    if (_productDescriptionController.text == "") {
      config.scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Product description cannot be empty."),
        ),
      );
      return;
    }
    if (_productPriceController.text == "") {
      config.scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Product price cannot be empty."),
        ),
      );
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return const SimpleDialog(
            surfaceTintColor: Colors.white,
            elevation: 10,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
    String? imageUrl;
    final productUuid = (const UuidV4()).generate();
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    if (_productImage != null) {
      final productStorageRef =
          FirebaseStorage.instance.ref().child("product_storage").child(userId);
      final productImageRef = productStorageRef.child(productUuid);
      final metadata = SettableMetadata(
        contentType: _productImage!.mimeType,
      );
      if ((await _productImage!.length()) > 1000000) {
        config.scaffoldKey.currentState!.showSnackBar(
          const SnackBar(
            content: Text("Image size cannot exceed 1MB."),
          ),
        );
        return;
      }
      await productImageRef.putData(
        await _productImage!.readAsBytes(),
        metadata,
      );
      imageUrl = await productImageRef.getDownloadURL();
    }
    final productData = ProductModel(
      id: productUuid,
      name: _productNameController.text,
      price: double.parse(_productPriceController.text),
      category: productCategoryStringToInt(_productCategoryController.text),
      description: _productDescriptionController.text,
      seller: userId,
      image: imageUrl,
    );
    await productData.add();
    Navigator.pop(config.navigatorKey.currentContext!);
    widget.parentSetState(() => {});
    config.scaffoldKey.currentState!.showMaterialBanner(
      MaterialBanner(
        content: const Text(
          "Product added successfully.",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () {
              config.scaffoldKey.currentState!.hideCurrentMaterialBanner();
            },
            child: const Text(
              "OK",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            const Text(
              'Product Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _productNameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _productDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Product Description',
              ),
              maxLines: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _productPriceController,
              decoration: const InputDecoration(
                labelText: 'Product Price',
              ),
              keyboardType: TextInputType.number,
            ),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                DropdownMenu<ProductCategory>(
                  initialSelection: ProductCategory.fertilizers,
                  controller: _productCategoryController,
                  label: const Text('Category'),
                  menuStyle: const MenuStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.white,
                    ),
                  ),
                  dropdownMenuEntries: ProductCategory.values
                      .map<DropdownMenuEntry<ProductCategory>>(
                          (ProductCategory category) {
                    return DropdownMenuEntry<ProductCategory>(
                      value: category,
                      label: category.name,
                    );
                  }).toList(),
                ),
                const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: getImage,
                    child: Text(
                      "Upload Image",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 50,
                        height: -0.2,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
            const Spacer(),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 16,
                width: MediaQuery.of(context).size.width / 1.3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: submitProduct,
                  child: Text(
                    "Add Product",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      height: -0.2,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
