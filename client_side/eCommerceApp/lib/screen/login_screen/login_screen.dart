import 'package:client_side/utility/extensions.dart';

import '../../utility/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlutterLogin(
          loginAfterSignUp: false,
          logo: const AssetImage('assets/images/logo.png'),
          onLogin: (loginData) async {
            context.userProvider.login(loginData);
          },
          onSignup: (SignupData data) {
            context.userProvider.register(data);
          },
          onSubmitAnimationCompleted: () {
            if (context.userProvider.getLoginUsr()?.sId != null) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              ));
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) {
                  return const LoginScreen();
                },
              ));
            }
          },
          onRecoverPassword: (_) => null,
          hideForgotPasswordButton: true,
          theme: LoginTheme(
              primaryColor: AppColor.darkGrey,
              accentColor: AppColor.darkOrange,
              buttonTheme: const LoginButtonTheme(
                backgroundColor: AppColor.darkOrange,
              ),
              cardTheme: const CardTheme(
                  color: Colors.white, surfaceTintColor: Colors.white),
              titleStyle: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}