import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/customTextField.dart';
import '../../providers/admin_provider.dart';

class AddNewProduct extends StatefulWidget {
  AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  //String catId;
  String? catId;

  @override
  String? selectedValue;

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4C53A5),
        title: Text("New Product"),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: provider.addProductKey,
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
                            ? const Center(
                                child: Icon(Icons.camera),
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
                    value: "",
                    controller: provider.productNameController,
                    label: 'Product name',
                    validation: provider.requiredValidation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                    value: "",
                    controller: provider.productDescriptionController,
                    label: 'Product Description',
                    validation: provider.requiredValidation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                    value: "",
                    controller: provider.productPriceController,
                    label: 'Product Price',
                    validation: provider.requiredValidation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                    value: "",
                    controller: provider.quantityController,
                    label: 'Product quantity',
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
                        provider.quantityController.clear();
                        for (int i = 0;
                            i < provider.allCategories!.length;
                            i++) {
                          if (provider.allCategories![i].nameEn ==
                              selectedValue) {
                            catId = provider.allCategories![i].id;
                          }
                        }
                        provider.addNewProduct(catId!);
                      },
                      child: const Text('Add New Product'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
