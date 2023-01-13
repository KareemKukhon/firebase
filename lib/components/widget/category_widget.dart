import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_application_18_firebase/Admin/models/catrgory.dart';
import 'package:flutter_application_18_firebase/components/widget/item_widget.dart';
import 'package:flutter_application_18_firebase/router/router.dart';
import 'package:provider/provider.dart';

import '../../Admin/providers/admin_provider.dart';
import '../../screens/home_screen.dart'as globals;

class categorywidget extends StatelessWidget {
  Category? category;

  categorywidget({
    this.category,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (category?.id != "all")
          globals.catFlag = false;
        else
          globals.catFlag = true;
        Provider.of<AdminProvider>(context, listen: false)
            .getAllProducts(category?.id);
        //ItemWidget();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                category!.imageUrl,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                category!.nameEn,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF4C53A5)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
