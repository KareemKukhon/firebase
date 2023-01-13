import 'package:flutter/material.dart';
import 'package:flutter_application_18_firebase/components/product_customer_widget.dart';
import 'package:provider/provider.dart';

import '../Admin/models/catrgory.dart';
import '../Admin/providers/admin_provider.dart';

class AllProductsScreen extends StatelessWidget {
  Category category;
  AllProductsScreen(this.category);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(category.nameEn + " Products"),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return provider.allProducts == null
            ? const Expanded(
                child: Center(
                child: CircularProgressIndicator(),
              ))
            : ListView.builder(
                itemCount: provider.allProducts?.length ?? 0,
                itemBuilder: (context, index) {
                  return ProductCustomerWidget(provider.allProducts![index]);
                });
      }),
    );
  }
}
