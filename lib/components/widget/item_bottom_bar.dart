import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_18_firebase/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_18_firebase/Admin/models/product.dart';
import 'package:flutter_application_18_firebase/Admin/providers/admin_provider.dart';

class ItemBottomBar extends StatelessWidget {
  Product product;
  ItemBottomBar({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 3))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\$${Provider.of<AdminProvider>(context,listen: false).price}",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              String? userId = Provider.of<AuthProvider>(context,listen: false).userId;
              Provider.of<AdminProvider>(context, listen: false)
                  .AddToCart(product,userId);
              Provider.of<AuthProvider>(context, listen: false).updateProfile(Provider.of<AdminProvider>(context).allItemInCart!.length);
            },
            icon: Icon(CupertinoIcons.cart_badge_plus),
            label: Text(
              "Add to Cart",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF4C53A5)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 13, horizontal: 15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)))),
          )
        ],
      ),
    );
  }
}
