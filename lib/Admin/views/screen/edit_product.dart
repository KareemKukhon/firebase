import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_18_firebase/Admin/views/screen/display_products.dart';
import 'package:flutter_application_18_firebase/router/router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_18_firebase/Admin/models/product.dart';

import '../../../components/customTextField.dart';
import '../../providers/admin_provider.dart';

class EditProduct extends StatefulWidget {
  Product product;
  EditProduct({
    required this.product,
  });

  @override
  State<EditProduct> createState() => _EditProductState(product);
}

class _EditProductState extends State<EditProduct> {
  String? catId;
  Product product;
  @override
  String? selectedValue;

  _EditProductState(this.product);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4C53A5),
        title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    AppRouter.appRouter
                        .NavigateWithReplacmentToWidget(AllProductsScreen());
                  },
                  icon: Icon(Icons.arrow_back)),
                  Text("Edit Product"),
            ],
          )
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      provider.pickImageForCategory();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.grey,
                      child: provider.imageFile == null
                          ? Center(
                              child: Image.network(product.imageUrl),
                            )
                          : Image.file(
                              provider.imageFile!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  value: product.name,
                  controller: provider.productNameController,
                  label: 'Product name: ',
                  validation: provider.requiredValidation,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  value: product.description,
                  controller: provider.productDescriptionController,
                  label: 'Product Description: ',
                  validation: provider.requiredValidation,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  value: product.price,
                  controller: provider.productPriceController,
                  label: 'Product Price: ',
                  validation: provider.requiredValidation,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  value: product.quantity.toString(),
                  controller: provider.quantityController,
                  label: 'Product quantity: ',
                  validation: provider.requiredValidation,
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Categories ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                    items: provider.allCategories!
                        .map((item) => DropdownMenuItem<String>(
                              value: item.nameEn,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  item.nameEn,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black26)),
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black26)),
                    buttonOverlayColor:
                        MaterialStateProperty.all(Color(0xFF4C53A5)),
                    buttonHeight: 40,
                    buttonWidth: 140,
                    itemHeight: 40,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF4C53A5))),
                    onPressed: () {
                      for (int i = 0; i < provider.allCategories!.length; i++) {
                        if (provider.allCategories![i].nameEn ==
                            selectedValue) {
                          catId = provider.allCategories![i].id;
                          break;
                        }
                      }
                      provider.updateProduct(product, catId);
                    },
                    child: const Text('Edit Product'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
