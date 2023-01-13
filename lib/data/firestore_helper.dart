import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_18_firebase/Admin/models/cart.dart';
import 'package:flutter_application_18_firebase/Admin/models/catrgory.dart';
import 'package:flutter_application_18_firebase/Admin/models/product.dart';

import '../models/app_user.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  addNewUser(AppUser appUser) async {
    await firestore.collection('user').doc(appUser.id).set(appUser.toMap());
  }

  Future<AppUser> getUserFromFirestore(String? id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestore.collection('user').doc(id).get();
    Map<String, dynamic>? data = documentSnapshot.data();
    AppUser appUser = AppUser.fromMap(data!);
    return appUser;
  }

  updateTheUser(AppUser appUser) async {
    print("userId: " + appUser.id!);
    await firestore.collection('user').doc(appUser.id).update(appUser.toMap());
  }

  Future<String?> addNewCategory(Category category) async {
    try {
      DocumentReference<Map<String, dynamic>> categoryDocument =
          await firestore.collection('categories').add(category.toMap());
      return categoryDocument.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool> deleteCategory(String catId) async {
    try {
      await firestore.collection('categories').doc(catId).delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
  Future<bool> deleteProduct(String productId) async {
    try {
      await firestore.collection('products').doc(productId).delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<Category>?> getAllCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> catsSnapshot = await firestore
          .collection('categories')
          .get(); // return snapshot : real data and mata data (data the generate by firebase like id)
      List<Category> categories = catsSnapshot.docs.map((doc) {
        // map is loop on doc , doc contain data = doc.data() as map represent data that i have add it not what the firebase generate.
        Category category = Category.fromMap(doc.data());
        category.id = doc.id;
        return category;
      }).toList();
      return categories;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool?> updateCategory(Category category) async {
    try {
      await firestore
          .collection('categories')
          .doc(category.id)
          .update(category.toMap());
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool?> updateProduct(Product product) async {
    print("object: "+product.id.toString());
    try {
      await firestore
          .collection('products')
          .doc(product.id.toString())
          .update(product.toMap());
      
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<String?> addNewProduct(Product product) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await firestore.collection('products').add(product.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<List<Product>?> getAllProducts([String? catId]) async {
    //print("cartid = " + catId);
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('products').get();
    if (catId != null)
      return querySnapshot.docs
          .map((e) {
            Product product = Product.fromMap(e.data());
            product.id = e.id;
            return product;
          })
          .where((element) => element.catId == catId)
          .toList();
    else {
      return querySnapshot.docs.map((e) {
        Product product = Product.fromMap(e.data());
        product.id = e.id;
        return product;
      }).toList();
    }
  }


  Future<String?> addToCart(Cart cart, String? userId) async {
    try {
      await firestore
          .collection('user')
          .doc(userId)
          .collection("cart item")
          .doc(cart.product_id)
          .set(cart.toMap());
      //return documentReference.id;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<bool?> updateCart(Cart cart, String? userId) async {
    try {
      await firestore
          .collection('user')
          .doc(userId)
          .collection("cart item")
          .doc(cart.product_id)
          .update(cart.toMap());
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<bool> deleteCart(String userId, Cart cart) async {
    try {
      await firestore
          .collection('user')
          .doc(userId)
          .collection("cart item")
          .doc(cart.id)
          .delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<Cart>?> getCart(String? userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> catsSnapshot = await firestore
          .collection('user')
          .doc(userId)
          .collection("cart item")
          .get();
      List<Cart> cart = catsSnapshot.docs.map((doc) {
        Cart cart = Cart.fromMap(doc.data());
        cart.id = doc.id;
        return cart;
      }).toList();
      return cart;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

}
