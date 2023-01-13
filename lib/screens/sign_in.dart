import 'package:flutter/material.dart';
import 'package:flutter_application_18_firebase/screens/sign_up.dart';
import 'package:provider/provider.dart';

import '../components/customTextField.dart';
import '../provider/auth_provider.dart';
import '../router/router.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Color(0xFF4C53A5)),
        title: Text('Sign In'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Consumer<AuthProvider>(builder: (context, provider, x) {
          return Form(
              key: provider.signInKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextfield(
                    validation: provider.emailValidation,
                    label: 'Email',
                    value: "",
                    controller: provider.loginEmailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                    validation: provider.passwordValidation,
                    label: 'Password',
                    value: "",
                    controller: provider.passwordLoginController,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF4C53A5)),
                      ),
                      onPressed: () {
                        provider.signIn();
                      },
                      child: Text('Sign In')),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF4C53A5)),
                      ),
                      onPressed: () {
                        AppRouter.appRouter.goToWidgetAndReplace(SignUp());
                      },
                      child: Text('Go to SignUp Page')),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF4C53A5)),
                      ),
                      onPressed: () {
                        provider.forgetPassword("kareemkukhon1@gmail.com");
                      },
                      child: Text('Forget Password'))
                ],
              ));
        }),
      ),
    );
  }
}
