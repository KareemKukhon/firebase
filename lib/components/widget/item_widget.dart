import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_18_firebase/router/router.dart';
import 'package:flutter_application_18_firebase/screens/item_page.dart';
import 'package:provider/provider.dart';

import '../../Admin/models/catrgory.dart';
import '../../Admin/models/product.dart';
import '../../Admin/providers/admin_provider.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

  //Category? category;
  // ItemWidget({
  //   this.category,
  // });

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, provider, w) {
      return GridView.builder(
        //physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,

        itemCount: provider.allProducts?.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          return Container(
              height: 300,
              width: 100,
              padding: EdgeInsets.only(left: 8.0),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, right: 10),
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      AppRouter.appRouter
                          .NavigateWithReplacmentToWidget(ItemPage(product: provider.allProducts![index]));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Image.network(
                        provider.allProducts![index].imageUrl,
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      provider.allProducts![index].name,
                      style: TextStyle(
                          color: Color(0xFF4C53A5),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      provider.allProducts![index].description,
                      style: TextStyle(
                        color: Color(0xFF4C53A5),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$ ${provider.allProducts![index].price}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5)),
                        ),
                        Icon(
                          Icons.shopping_cart_checkout,
                          color: Color(0xFF4C53A5),
                        )
                      ],
                    ),
                  )
                ],
              ));
        },
      );
    });
  }
}
