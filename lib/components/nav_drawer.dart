import 'package:flutter/material.dart';
import 'package:flutter_application_18_firebase/Admin/views/screen/display_categories.dart';
import 'package:flutter_application_18_firebase/Admin/views/screen/display_products.dart';
import 'package:flutter_application_18_firebase/provider/auth_provider.dart';
import 'package:flutter_application_18_firebase/router/router.dart';
import 'package:flutter_application_18_firebase/screens/main_screen.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                // image: DecorationImage(
                //     fit: BoxFit.fill,
                //     image: NetworkImage((Provider.of<AuthProvider>(context)
                //         .loggedUser
                //         ?.imageUrl)))
                ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {AppRouter.appRouter
                  .NavigateWithReplacmentToWidget(MainScreen())},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Products'),
            onTap: () => {AppRouter.appRouter
                  .NavigateWithReplacmentToWidget(AllProductsScreen())},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Category'),
            onTap: () => {
              AppRouter.appRouter
                  .NavigateWithReplacmentToWidget(AllCategoriesScreen())
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () =>
                {Provider.of<AuthProvider>(context, listen: false).signOut()},
          ),
        ],
      ),
    );
  }
}
