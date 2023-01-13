library my_prj.globals;

import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_18_firebase/Admin/models/catrgory.dart';
import 'package:flutter_application_18_firebase/Admin/providers/admin_provider.dart';
import 'package:flutter_application_18_firebase/Admin/views/screen/display_categories.dart';
import 'package:flutter_application_18_firebase/components/widget/category_widget.dart';
import 'package:flutter_application_18_firebase/models/app_user.dart';
import 'package:flutter_application_18_firebase/provider/auth_provider.dart';
import 'package:flutter_application_18_firebase/screens/main_screen.dart';
import 'package:provider/provider.dart';
import '../components/widget/item_widget.dart';
import '../router/router.dart';
import 'cart_screen.dart';

bool catFlag = true;

class HomeScreen extends StatelessWidget {
  String? userId;
  int page = 0;
  HomeScreen({
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    Provider.of<AdminProvider>(context).getAllCategories();
    //print("user id: " + appUser.id.toString());
    Provider.of<AdminProvider>(context).getCart(userId);
    if (catFlag) Provider.of<AdminProvider>(context).getAllProducts();
    return Scaffold(
      body: ListView(children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(25),
          child: Row(children: [
            Icon(
              Icons.sort,
              size: 30,
              color: Color(0xFF4C53A5),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                "DP Shop",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5)),
              ),
            ),
            Spacer(),
            Badge(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(7),
              badgeContent: Text(
                Provider.of<AuthProvider>(context).loggedUser!.numOfItemInCart.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: InkWell(
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                  color: Color(0xFF4C53A5),
                ),
                onTap: () {
                  AppRouter.appRouter
                      .goToWidgetAndReplace(CartScreen(userId: userId!));
                },
              ),
            )
          ]),
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search here..."),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.camera_alt,
                      size: 25,
                      color: Color(0xFF4C53A5),
                    ),
                  ],
                ),
              ),
              Container(
                //alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text("Categories",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5))),
              ),
              Container(
                height: 50,
                child: Consumer<AdminProvider>(builder: (context, provider, w) {
                  return provider.allCategories == null
                      ? Center(
                          child: Text('No Categories Found'),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.allCategories!.length,
                          itemBuilder: (context, index) {
                            return categorywidget(
                                category: provider.allCategories?[index]);
                          });
                }),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  "Best Selling",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5)),
                ),
              ),
              Provider.of<AdminProvider>(context).allCategories == null
                  ? Center(
                      child: Container(
                          height: 400,
                          width: 150,
                          color: Colors.white,
                          child: Text('No Products Found')),
                    )
                  : Container(height: 500, child: ItemWidget()),
            ],
          ),
        )
      ]),
      bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            if (index == 0)
              AppRouter.appRouter
                  .NavigateWithReplacmentToWidget(CartScreen(userId: userId!));
            else if (index == 2) {
              AppRouter.appRouter.NavigateWithReplacmentToWidget(MainScreen());
            }
          },
          height: 70,
          color: Color(0xFF4C53A5),
          items: [
            Icon(
              CupertinoIcons.cart_fill,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.home,
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
