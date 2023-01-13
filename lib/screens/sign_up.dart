import 'package:flutter/material.dart';
import 'package:flutter_application_18_firebase/screens/sign_in.dart';
import 'package:provider/provider.dart';

import '../components/customTextField.dart';
import '../provider/auth_provider.dart';
import '../router/router.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4C53A5),
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Consumer<AuthProvider>(builder: (context, provider, x) {
          return Form(
              key: provider.signUpKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextfield(
                      value: "",
                      validation: provider.requiredValidation,
                      label: 'Name',
                      controller: provider.userNameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      value: "",
                      validation: provider.phoneValidation,
                      label: 'Phone Number',
                      controller: provider.phoneController,
                      textInputType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      value: "",
                      validation: provider.emailValidation,
                      label: 'Email',
                      controller: provider.registerEmailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      value: "",
                      validation: provider.passwordValidation,
                      label: 'Password',
                      controller: provider.passwordRegisterController,
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      value: "",
                      validation: provider.requiredValidation,
                      label: 'Address',
                      controller: provider.adressController,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF4C53A5)),
                      ),
                        onPressed: () {
                          provider.SignUp();
                        },
                        child: Text('Sign Up')),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF4C53A5)),
                      ),
                        onPressed: () {
                          AppRouter.appRouter
                              .goToWidgetAndReplace(SignIn());
                        },
                        child: Text('Go to login Page'))
                  ],
                ),
              ));
        }),
      ),
    );
  }
}
