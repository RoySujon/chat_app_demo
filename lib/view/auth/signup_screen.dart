import 'package:chat_app_demo/view/auth/home_screen/home_screen.dart';
import 'package:chat_app_demo/view_model/auth_service/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/custome_text_field.dart';
import '../../components/my_button.dart';

class SignupSceen extends StatelessWidget {
  SignupSceen({super.key});
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('S I G N U P'),
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
                controller: _passController,
                hintText: 'Enter the password',
                label: 'Password',
                obscureText: true,
              ),
              CustomTextField(
                obscureText: true,
                controller: _confirmPassController,
                hintText: 'Enter the password agein',
                label: 'Password',
              ),
              MyButton(
                text: 'S I G N U P',
                onTap: () {
                  if (_passController.text.trim().isNotEmpty &&
                      _passController.text.trim() ==
                          _confirmPassController.text.trim() &&
                      _emailController.text.trim().isNotEmpty) {
                    _auth
                        .signUp(_emailController.text.trim().toString(),
                            _passController.text.trim().toString())
                        .then((value) {
                      Fluttertoast.showToast(msg: 'Successfull to Signup');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false);
                    }).onError((error, stackTrace) {
                      Fluttertoast.showToast(msg: error.toString());
                    });
                  } else {
                    Fluttertoast.showToast(msg: 'Enter the right password');
                  }
                },
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Already have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Login'))
              ])
            ],
          ),
        ));
  }
}
