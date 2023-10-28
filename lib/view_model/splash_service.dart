import 'package:chat_app_demo/view/auth/auth_gate.dart';
import 'package:chat_app_demo/view/auth/home_screen/home_screen.dart';
import 'package:chat_app_demo/view/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashService {
  static islogin(BuildContext context) {
    Future.delayed(const Duration(seconds: 1))
        .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthGate(),
              ),
              (route) => false,
            ));
  }
}
