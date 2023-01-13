import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_18_firebase/Admin/models/cart.dart';
import 'package:flutter_application_18_firebase/Admin/models/catrgory.dart';
import 'package:flutter_application_18_firebase/provider/auth_provider.dart';
import 'package:flutter_application_18_firebase/router/router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../data/firestore_helper.dart';
import '../../data/storage_heper.dart';
import '../models/product.dart';
import '../views/screen/edit_category.dart';

class AdminProvider extends ChangeNotifier {
  List<Category>? allCategories;
  List<Product>? allProducts;
  List<Cart>? allItemInCart;
  File? imageFile;
  int counter = 0;
  int price = 0;
  num total = 0;
  clearCounter() {
    counter = 0;
    price = 0;
    notifyListeners();
  }

  decrement(int counter, int price) {
    counter--;
    this.counter = counter;
    this.price = price * counter;
    notifyListeners();
  }

  increment(int counter, int price) {
    counter++;
    this.counter = counter;
    this.price = price * counter;
    notifyListeners();
  }

  getTotal() {
    total = 0;
    for (int i = 0; i < allItemInCart!.length; i++) {
      total += allItemInCart![i].price * allItemInCart![i].count;
    }
    notifyListeners();
  }

  AdminProvider() {
    getAllCategories();
    getAllProducts();
  }

  String? requiredValidation(String? content) {
    if (content == null || content.isEmpty) {
      return "Required field";
    }
  }

  TextEditingController catNameArController = TextEditingController();
  TextEditingController catNameEnController = TextEditingController();
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  pickImageForCategory() async {
    XFile? pickerFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      imageFile = File(pickerFile.path);
      notifyListeners();
    }
  }

  addNewCategory() async {
    if (imageFile != null) {
      if (categoryFormKey.currentState!.validate()) {
        AppRouter.appRouter.showLoadingDialoug();
        String imageUrl = await StorageHelper.storageHelper
            .uploadNewImage("cats_images", imageFile!);
        Category category = Category(
            imageUrl: imageUrl,
            nameAr: catNameArController.text,
            nameEn: catNameEnController.text);
        String? id =
            await FirestoreHelper.firestoreHelper.addNewCategory(category);

        AppRouter.appRouter.hideDialog();
        if (id != null) {
          category.id = id;
          allCategories!.add(category);
          notifyListeners();
          catNameArController.clear();
          catNameEnController.clear();
          imageFile = null;
          notifyListeners();
          AppRouter.appRouter
              .showCustomDialoug('Success', 'Your category has been added');
        }
      }
    } else {
      AppRouter.appRouter
          .showCustomDialoug('Error', 'Your have to pick image first');
    }
  }

  getAllCategories() async {
    allCategories = (await FirestoreHelper.firestoreHelper.getAllCategories())!;
    allCategories?.insert(
        0,
        Category(
            id: "all",
            imageUrl:
                "https://firebasestorage.googleapis.com/v0/b/ecommerce-app-55953.appspot.com/o/cats_images%2Fimage_picker4223293256023411424.jpg?alt=media&token=b535443c-cb45-4fea-ae16-414051bb517b",
            nameAr: "الكل",
            nameEn: "All"));
    notifyListeners();
  }

  deleteCategory(Category category) async {
    AppRouter.appRouter.showLoadingDialoug();
    bool deleteSuccess =
        await FirestoreHelper.firestoreHelper.deleteCategory(category.id!);
    if (deleteSuccess) {
      allCategories!.remove(category);
      notifyListeners();
    }
    AppRouter.appRouter.hideDialog();
  }

  goToEditCategoryPage(Category category) {
    catNameArController.text = category.nameAr;
    catNameEnController.text = category.nameEn;
    AppRouter.appRouter.goToWidget(EditCategory(category));
  }

  updateCategory(Category category) async {
    AppRouter.appRouter.showLoadingDialoug();
    if (imageFile != null) {
      String imageUrl = await StorageHelper.storageHelper
          .uploadNewImage("cats_images", imageFile!);
      category.imageUrl = imageUrl;
    }
    Category newCategory = Category(
        id: category.id,
        imageUrl: category.imageUrl,
        nameAr: catNameArController.text.isEmpty
            ? category.nameAr
            : catNameArController.text,
        nameEn: catNameEnController.text.isEmpty
            ? category.nameEn
            : catNameEnController.text);

    bool? isUpdated =
        await FirestoreHelper.firestoreHelper.updateCategory(newCategory);

    if (isUpdated != null && isUpdated) {
      int index = allCategories!.indexOf(category);
      allCategories![index] = newCategory;
      imageFile = null;
      catNameEnController.clear();
      catNameArController.clear();
      notifyListeners();
      AppRouter.appRouter.hideDialog();
      AppRouter.appRouter.hideDialog();
    }
  }

  getAllProducts([String? catId]) async {
    //allProducts = null;
    if (catId != null) {
      allProducts = await FirestoreHelper.firestoreHelper.getAllProducts(catId);
    } else
      allProducts = await FirestoreHelper.firestoreHelper.getAllProducts();
    notifyListeners();
  }

  TextEditingController sliderTitleController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController sliderUrlController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  GlobalKey<FormState> addProductKey = GlobalKey();

  addNewProduct(String catId) async {
    if (imageFile != null) {
      if (addProductKey.currentState!.validate()) {
        AppRouter.appRouter.showLoadingDialoug();
        String imageUrl = await StorageHelper.storageHelper
            .uploadNewImage("products_images", imageFile!);

        Product product = Product(
            imageUrl: imageUrl,
            name: productNameController.text,
            description: productDescriptionController.text,
            price: productPriceController.text,
            catId: catId,
            quantity: int.parse(quantityController.text));

        String? id =
            await FirestoreHelper.firestoreHelper.addNewProduct(product);

        AppRouter.appRouter.hideDialog();
        if (id != null) {
          product.id = id;
          allProducts?.add(product);
          notifyListeners();
          productNameController.clear();
          productDescriptionController.clear();
          productPriceController.clear();
          quantityController.clear();
          imageFile = null;
          notifyListeners();
          AppRouter.appRouter
              .showCustomDialoug('Success', 'Your Product has been added');
        }
      }
    } else {
      AppRouter.appRouter
          .showCustomDialoug('Error', 'You have to pick image first');
    }
  }

  updateProduct(Product product, String? catId) async {
    print("product");
    AppRouter.appRouter.showLoadingDialoug();
    if (imageFile != null) {
      String imageUrl = await StorageHelper.storageHelper
          .uploadNewImage("cats_images", imageFile!);
      product.imageUrl = imageUrl;
    }
    Product newProduct = Product(
        id: product.id,
        imageUrl: product.imageUrl,
        name: productNameController.text.isEmpty
            ? product.name
            : productNameController.text,
        catId: catId == null ? product.catId : catId,
        description: productDescriptionController.text.isEmpty
            ? product.description
            : productDescriptionController.text,
        price: productPriceController.text.isEmpty
            ? product.price
            : productPriceController.text,
        quantity: quantityController.text.isEmpty
            ? product.quantity
            : int.parse(quantityController.text));
    print("done1: " + newProduct.id.toString());
    bool? isUpdated =
        await FirestoreHelper.firestoreHelper.updateProduct(newProduct);
    print("done..");
    if (isUpdated != null && isUpdated) {
      // print("index" + product.catId.toString());
      // int index = allProducts!.indexOf(product);
      // print("index" + index.toString());
      // allProducts![index] = newProduct;
      imageFile = null;
      AppRouter.appRouter.hideDialog();
      productNameController.clear();
      productPriceController.clear();
      productDescriptionController.clear();
      quantityController.clear();
      notifyListeners();
    } else {
      print("Field");
      AppRouter.appRouter.hideDialog();
    }
  }

  deleteProduct(Product product) async {
    print("productId: " + product.id.toString());
    AppRouter.appRouter.showLoadingDialoug();
    bool deleteSuccess =
        await FirestoreHelper.firestoreHelper.deleteProduct(product.id!);
    if (deleteSuccess) {
      allCategories!.remove(product);
      notifyListeners();
    }
    AppRouter.appRouter.hideDialog();
  }

  getCart(String? userId) async {
    allItemInCart = await FirestoreHelper.firestoreHelper.getCart(userId);
    notifyListeners();
  }

  deleteCart(String userId, Cart cart) async {
    AppRouter.appRouter.showLoadingDialoug();
    bool deleteSuccess =
        await FirestoreHelper.firestoreHelper.deleteCart(userId, cart);
    if (deleteSuccess) {
      allItemInCart!.remove(cart);
      notifyListeners();
    }
    AppRouter.appRouter.hideDialog();
  }

  AddToCart(Product product, String? userId) async {
    bool flag = true;
    int price = 0;
    await getCart(userId);
    if (counter > 0) {
      AppRouter.appRouter.showLoadingDialoug();
      Cart cart = Cart(
          count: counter,
          price: num.parse(product.price),
          product_id: product.id,
          id: product.id);
      for (int i = 0;
          (allItemInCart != null) && (i < allItemInCart!.length);
          i++) {
        if (allItemInCart![i].id == product.id) {
          cart.count += allItemInCart![i].count;
          cart.price += allItemInCart![i].price;
          await FirestoreHelper.firestoreHelper.updateCart(cart, userId);
          flag = false;
          break;
        }
      }
      if (flag) {
        allItemInCart?.add(cart);
        await FirestoreHelper.firestoreHelper.addToCart(cart, userId);
      }

      AppRouter.appRouter.hideDialog();

      notifyListeners();
      AppRouter.appRouter
          .showCustomDialoug('Success', 'Your items has been added');
    } else {
      AppRouter.appRouter
          .showCustomDialoug('Feild', 'You have to chose the quantity');
    }
  }

  updateCart(Cart cart, String userId) async {
    AppRouter.appRouter.showLoadingDialoug();
    Cart newCart = Cart(
      id: cart.id,
      count: cart.count,
      product_id: cart.product_id,
      price: cart.price,
    );

    bool? isUpdated =
        await FirestoreHelper.firestoreHelper.updateCart(newCart, userId);

    if (isUpdated != null && isUpdated) {
      int index = allItemInCart!.indexOf(cart);
      allItemInCart![index] = newCart;
      notifyListeners();
      AppRouter.appRouter.hideDialog();
    }
  }
}
