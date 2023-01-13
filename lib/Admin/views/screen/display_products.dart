import 'dart:developer';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_18_firebase/Admin/views/screen/add_product.dart';
import 'package:provider/provider.dart';

import '../../../router/router.dart';
import '../../../screens/main_screen.dart';
import '../../providers/admin_provider.dart';
import '../components/product_widget.dart';
import 'add_categories.dart';
import 'display_categories.dart';

class AllProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4C53A5),
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.appRouter.goToWidget(AddNewProduct());
              },
              icon: Icon(Icons.add))
        ],
        title: Text('All Products'),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        provider.getAllProducts();
        return provider.allProducts == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: provider.allProducts!.length,
                itemBuilder: (context, index) {
                  return ProductWidget(provider.allProducts![index]);
                });
      }),
      bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            if (index == 1)
              AppRouter.appRouter
                  .NavigateWithReplacmentToWidget(AllCategoriesScreen());
            else if (index == 2) {
              AppRouter.appRouter.NavigateWithReplacmentToWidget(MainScreen());
            }
          },
          height: 70,
          color: Color(0xFF4C53A5),
          items: [
            Icon(
              Icons.production_quantity_limits,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.category,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.list,
              size: 30,
              color: Colors.white,
            )
          ]),
    );
  }
}
