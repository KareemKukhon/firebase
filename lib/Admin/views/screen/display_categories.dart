import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_18_firebase/Admin/views/screen/display_products.dart';
import 'package:flutter_application_18_firebase/components/nav_drawer.dart';
import 'package:flutter_application_18_firebase/screens/main_screen.dart';
import 'package:provider/provider.dart';

import '../../../router/router.dart';
import '../../providers/admin_provider.dart';
import '../components/category_widget.dart';
import 'add_categories.dart';

class AllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController(
      initialScrollOffset: 1, // or whatever offset you wish
      keepScrollOffset: true,
    );
    // TODO: implement build
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF4C53A5),
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.appRouter.goToWidget(AddNewCategory());
              },
              icon: Icon(Icons.add))
        ],
        title: Text('All Categories'),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return provider.allCategories == null
            ? Center(
                child: Text('No Categories Found'),
              )
            : ListView.builder(
                controller: scrollController,
                itemCount: provider.allCategories!.length - 1,
                itemBuilder: (context, index) {
                  index++;
                  return CategoryWidget(provider.allCategories![index]);
                });
      }),
      bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            if (index == 0)
              AppRouter.appRouter
                  .NavigateWithReplacmentToWidget(AllProductsScreen());
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
