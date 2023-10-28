import 'package:chat_app_demo/components/custome_text_field.dart';
import 'package:chat_app_demo/components/my_button.dart';
import 'package:chat_app_demo/view/auth/signup_screen.dart';
import 'package:chat_app_demo/view_model/auth_service/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('L O G I N'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                hintText: 'Enter the email',
                label: 'Email',
              ),
              CustomTextField(
                obscureText: true,
                controller: _passController,
                hintText: 'Enter the Password',
                label: 'Password',
              ),
              MyButton(
                text: 'L O G I N',
                onTap: () async {
                  if (_emailController.text.trim().isNotEmpty &&
                      _passController.text.trim().isNotEmpty) {
                    await _auth.login(_emailController.text.toString(),
                        _passController.text.toString());
                  } else {
                    Fluttertoast.showToast(msg: 'Something is going wrong');
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an accont?'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupSceen(),
                            ));
                      },
                      child: const Text('Signup'))
                ],
              )
            ],
          ),
        ));
  }
}
