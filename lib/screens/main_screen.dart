import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_18_firebase/Admin/views/screen/display_categories.dart';
import 'package:flutter_application_18_firebase/Admin/views/screen/display_products.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_18_firebase/Admin/providers/admin_provider.dart';
import 'package:flutter_application_18_firebase/components/customTextField.dart';
import 'package:flutter_application_18_firebase/models/app_user.dart';
import 'package:flutter_application_18_firebase/screens/cart_screen.dart';

import '../components/nav_drawer.dart';
import '../provider/auth_provider.dart';
import '../router/router.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  bool clicked = false;

  Widget build(BuildContext context) {
    // Provider.of<AuthProvider>(context, listen: false)
    //                           .clearFields();
    // TODO: implement build
    int length = 0;
    bool isAdmin = Provider.of<AuthProvider>(context).loggedUser!.isAdmin;
    if (Provider.of<AdminProvider>(context).allItemInCart != null)
      int length = Provider.of<AdminProvider>(context).allItemInCart!.length;
    String? userId;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              if (clicked)
                Row(
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF4C53A5)),
                        ),
                        onPressed: () {
                          clicked = false;
                          Provider.of<AuthProvider>(context, listen: false)
                              .updateProfile(length);
                          setState(() {});
                        },
                        child: Container(
                          color: Color(0xFF4C53A5),
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF4C53A5)),
                        ),
                        onPressed: () {
                          clicked = false;
                          Provider.of<AuthProvider>(context, listen: false)
                              .clearFields();
                          setState(() {});
                        },
                        child: Container(
                          color: Color(0xFF4C53A5),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF4C53A5)),
                  ),
                  onPressed: () {
                    clicked = true;
                    setState(() {});
                  },
                  child: Container(
                    color: Color(0xFF4C53A5),
                    child: Row(
                      children: [
                        Text(
                          "Edit ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.edit)
                      ],
                    ),
                  )),
            ],
          )
        ],
        backgroundColor: Color(0xFF4C53A5),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, w) {
          userId = provider.userId;
          return SingleChildScrollView(
            child: Container(
              color: Colors.grey.withOpacity(0.2),
              child: provider.loggedUser == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (clicked) provider.uploadNewFile();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 60,
                              child: provider.loggedUser?.imageUrl == null
                                  ? const Center(
                                      child: Icon(Icons.person_outline_sharp),
                                    )
                                  : CircleAvatar(
                                      radius: 60,
                                      // backgroundImage: NetworkImage(
                                      //   (provider.loggedUser?.imageUrl)!,
                                      // ),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomProfileWidget(
                            clicked: clicked,
                            label: "Name: ",
                            value: provider.loggedUser!.userName,
                            controller: provider.userNameController,
                            validation: provider.requiredValidation,
                            loggedUser: provider.loggedUser!.userName,
                          ),
                          CustomProfileWidget(
                            clicked: clicked,
                            label: "Email: ",
                            value: provider.loggedUser!.email,
                            controller: provider.loginEmailController,
                            validation: provider.requiredValidation,
                            loggedUser: provider.loggedUser!.email,
                          ),
                          CustomProfileWidget(
                            clicked: clicked,
                            label: "Phone: ",
                            value: provider.loggedUser!.phoneNumber,
                            controller: provider.phoneController,
                            validation: provider.requiredValidation,
                            loggedUser: provider.loggedUser!.phoneNumber,
                          ),
                          CustomProfileWidget(
                            clicked: clicked,
                            label: "Address: ",
                            value: provider.loggedUser!.address,
                            controller: provider.adressController,
                            validation: provider.requiredValidation,
                            loggedUser: provider.loggedUser!.address,
                          ),
                        ],
                      ),
                    ),
            ),
          );
          
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Provider.of<AuthProvider>(context, listen: false).signOut();
        },
        backgroundColor: Color(0xFF4C53A5),
        label: Text("LogOut"),
        icon: Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          index: 2,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            if (index == 0) {
              isAdmin
                  ? AppRouter.appRouter
                      .NavigateWithReplacmentToWidget(AllProductsScreen())
                  : AppRouter.appRouter.NavigateWithReplacmentToWidget(
                      CartScreen(userId: userId!));
            } else if (index == 1) {
              print("isAdmin: " + isAdmin.toString());
              isAdmin
                  ? AppRouter.appRouter
                      .NavigateWithReplacmentToWidget(AllCategoriesScreen())
                  : AppRouter.appRouter.NavigateWithReplacmentToWidget(
                      Provider.of<AuthProvider>(context, listen: false)
                          .checkUser());
            }
          },
          height: 70,
          color: Color(0xFF4C53A5),
          items: [
            !isAdmin
                ? Icon(
                    CupertinoIcons.cart_fill,
                    size: 30,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.production_quantity_limits,
                    size: 30,
                    color: Colors.white,
                  ),
            isAdmin
                ? Icon(
                    Icons.category,
                    size: 30,
                    color: Colors.white,
                  )
                : Icon(
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

class CustomProfileWidget extends StatelessWidget {
  final String label;
  final String loggedUser;
  Function validation;
  String value;
  bool clicked;
  TextEditingController controller;
  CustomProfileWidget({
    Key? key,
    required this.label,
    required this.loggedUser,
    required this.validation,
    required this.value,
    required this.clicked,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: CustomTextfield(
                  enabled: clicked,
                  validation: validation,
                  value: value,
                  label: label,
                  controller: controller))
        ],
      ),
    );
  }
}
