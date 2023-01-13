import 'dart:developer';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_18_firebase/Admin/models/catrgory.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import '../Admin/views/screen/display_categories.dart';
import '../Admin/views/screen/display_products.dart';
import '../data/auth_helper.dart';
import '../data/firestore_helper.dart';
import '../data/storage_heper.dart';
import '../models/app_user.dart';
import '../router/router.dart';
import '../screens/home_screen.dart';
import '../screens/main_screen.dart';
import '../screens/sign_in.dart';
import 'dart:io';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> signInKey = GlobalKey();
  GlobalKey<FormState> signUpKey = GlobalKey();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  late String email;
  late String password;
  String? userId;
  AppUser? loggedUser;
  saveEmail(String email) {
    this.email = email;
  }

  savePassword(String password) {
    this.password = password;
  }

  String? emailValidation(String email) {
    if (email == null || email.isEmpty) {
      return "Required field";
    } else if (!(isEmail(email))) {
      return "Incorrect email syntax";
    }
  }

  String? passwordValidation(String password) {
    if (password == null || password.isEmpty) {
      return "Required field";
    } else if (password.length <= 6) {
      return 'Error, the password must be larger than 6 letters';
    }
  }

  String? requiredValidation(String content) {
    if (content == null || content.isEmpty) {
      return "Required field";
    }
  }

  String? phoneValidation(String content) {
    if (!isNumeric(content)) {
      return "InCorrect phone number syntax";
    }
  }

  signIn() async {
    if (signInKey.currentState!.validate()) {
      signInKey.currentState!.save();
      String? userId = await AuthHelper.authHelper
          .signIn(loginEmailController.text, passwordLoginController.text);
      if (userId != null) {
        loggedUser =
            await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
        notifyListeners();
        AppRouter.appRouter.goToWidgetAndReplace(HomeScreen());
        log("login succefully");
      }
    }
  }

  SignUp() async {
    if (signUpKey.currentState!.validate()) {
      String? result = await AuthHelper.authHelper.signUp(
          registerEmailController.text, passwordRegisterController.text);
      if (result != null) {
        FirestoreHelper.firestoreHelper.addNewUser(AppUser(
            id: result,
            address: adressController.text,
            email: registerEmailController.text,
            userName: userNameController.text,
            phoneNumber: phoneController.text,
            numOfItemInCart: 0));
        AppRouter.appRouter.goToWidgetAndReplace(checkUser());
      }
    }
  }

  updateProfile(int numOfItemInCart) async {
    await AuthHelper.authHelper.updateProfile(loginEmailController.text.isEmpty
        ? loggedUser!.email
        : loginEmailController.text);
    print("adressController" + adressController.text);
    FirestoreHelper.firestoreHelper.updateTheUser(AppUser(
        id: userId,
        address: adressController.text.isEmpty
            ? loggedUser!.address
            : adressController.text,
        email: loginEmailController.text.isEmpty
            ? loggedUser!.email
            : loginEmailController.text,
        userName: userNameController.text.isEmpty
            ? loggedUser!.userName
            : userNameController.text,
        phoneNumber: phoneController.text.isEmpty
            ? loggedUser!.phoneNumber
            : phoneController.text,
        numOfItemInCart: numOfItemInCart,
        imageUrl: loggedUser!.imageUrl));
    clearFields();
    notifyListeners();
  }

  getUser(String? id) async {
    loggedUser = await FirestoreHelper.firestoreHelper.getUserFromFirestore(id);
    loggedUser!.id = id;
    print("check");
    notifyListeners();
  }

  checkUser() async {
    userId = await AuthHelper.authHelper.checkUser();
    notifyListeners();
    if (userId != null) {
      await getUser(userId);
      notifyListeners();
      print("checkUser");
      print("is Admin: "+loggedUser!.isAdmin.toString());
      if (loggedUser!.isAdmin)
        AppRouter.appRouter.goToWidgetAndReplace(AllCategoriesScreen());
      else
        AppRouter.appRouter.goToWidgetAndReplace(HomeScreen(
          userId: userId,
        ));
    } else {
      AppRouter.appRouter.goToWidgetAndReplace(SignIn());
    }
  }

  signOut() async {
    await AuthHelper.authHelper.signOut();
    AppRouter.appRouter.goToWidgetAndReplace(SignIn());
  }

  forgetPassword(String email) async {
    AuthHelper.authHelper.forgetPassword("kareemkukhon1@gmail.com");
  }

  uploadNewFile() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File file = File(pickedFile!.path);
    String imageUrl =
        await StorageHelper.storageHelper.uploadNewImage('user_images', file);

    loggedUser!.imageUrl = imageUrl;

    await FirestoreHelper.firestoreHelper.updateTheUser(loggedUser!);
    getUser(loggedUser!.id!);
    notifyListeners();
  }

  clearFields() {
    loginEmailController.clear();
    userNameController.clear();
    phoneController.clear();
    adressController.clear();
    notifyListeners();
  }
}
