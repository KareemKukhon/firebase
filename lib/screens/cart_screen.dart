import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_18_firebase/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_18_firebase/Admin/providers/admin_provider.dart';
import 'package:flutter_application_18_firebase/router/router.dart';
import 'package:flutter_application_18_firebase/screens/home_screen.dart';

import '../components/widget/cart_bottom_bar.dart';
import '../components/widget/cart_widget.dart';
import 'main_screen.dart';

class CartScreen extends StatelessWidget {
  String userId;
  CartScreen({
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false).checkUser();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Color(0xFF4C53A5),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Cart",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5)),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.more_vert,
                  size: 30,
                  color: Color(0xFF4C53A5),
                )
              ],
            ),
          ),
          Container(
              height: 500,
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: Color(0xFFEDECF2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: CartWidget(
                userId: userId,
              )),
          CartBottomBar(),
        ],
        
      ),
      bottomNavigationBar: CurvedNavigationBar(
        
        index:0,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            if (index == 1)
              AppRouter.appRouter.NavigateWithReplacmentToWidget(Provider.of<AuthProvider>(context,listen: false).checkUser());
            else if(index == 2){
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
