import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/customTextField.dart';
import '../../models/catrgory.dart';
import '../../providers/admin_provider.dart';

class EditCategory extends StatelessWidget {
  Category category;
  EditCategory(this.category);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4C53A5),
        title: Text("New Category"),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: provider.categoryFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    provider.pickImageForCategory();
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.grey,
                    child: provider.imageFile == null
                        ? Image.network(
                            category.imageUrl,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            provider.imageFile!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  value: "",
                  controller: provider.catNameArController,
                  label: 'Category Arabic name',
                  validation: provider.requiredValidation,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  value: "",
                  controller: provider.catNameEnController,
                  label: 'Category English name',
                  validation: provider.requiredValidation,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,),
                   Container(
                     child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF4C53A5)),
                      ),
                      onPressed: () {
                        provider.updateCategory(category);
                      },
                      child: const Text('Update Category'),
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
