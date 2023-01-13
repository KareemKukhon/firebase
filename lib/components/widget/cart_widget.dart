import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_18_firebase/Admin/models/catrgory.dart';
import 'package:flutter_application_18_firebase/Admin/providers/admin_provider.dart';
import 'package:flutter_application_18_firebase/main.dart';

class CartWidget extends StatelessWidget {
  String userId;
  CartWidget({
    Key? key,
    required this.userId,
  });

  //Category category;
  String? imageUrl;
  String? name;
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, provider, child) {
        print("length: " + provider.allItemInCart!.length.toString());
        return ListView.builder(
          itemCount: provider.allItemInCart?.length,
          itemBuilder: (context, index) {
            for (int i = 0; i < provider.allProducts!.length; i++) {
              if (provider.allItemInCart?[index].product_id ==
                  provider.allProducts?[i].id) {
                imageUrl = provider.allProducts?[i].imageUrl;
                name = provider.allProducts?[i].name;
              }
            }
            return Container(
              //height: 700,

              child: Column(
                children: [
                  Container(
                    height: 110,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Radio(
                          value: "",
                          groupValue: "",
                          onChanged: (value) {},
                          activeColor: Color(0xFF4C53A5),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.only(right: 15),
                          child: Image.network(imageUrl!),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name!,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4C53A5)),
                              ),
                              Text(
                                "\$${provider.allItemInCart![index].price}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4C53A5)),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  provider.deleteCart(
                                      userId, provider.allItemInCart![index]);
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      provider.allItemInCart![index].count++;
                                      print(
                                          provider.allItemInCart![index].price);
                                      provider.increment(
                                          provider.allItemInCart![index].count
                                              .toInt(),
                                          int.parse(provider
                                              .allProducts![index].price));
                                      provider.getTotal();
                                      provider.updateCart(
                                          provider.allItemInCart![index],
                                          userId);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 10)
                                          ]),
                                      child: Icon(
                                        CupertinoIcons.plus,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      provider.allItemInCart![index].count
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4C53A5)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (provider.allItemInCart![index].count >
                                          0) {
                                        provider.allItemInCart![index].count--;
                                        provider.decrement(
                                            provider.allItemInCart![index].count
                                                .toInt(),
                                            int.parse(provider
                                                .allProducts![index].price));
                                        provider.getTotal();
                                        provider.updateCart(
                                            provider.allItemInCart![index],
                                            userId);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 10)
                                          ]),
                                      child: Icon(
                                        CupertinoIcons.minus,
                                        size: 18,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
