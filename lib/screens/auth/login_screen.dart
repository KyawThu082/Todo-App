import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todos/controllers/login_controller.dart';
import 'package:todos/widgets/custom_button.dart';
import 'package:todos/widgets/custom_textfield.dart';

import '../../routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetBuilder<LoginController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 120,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'My TODO',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 54,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 50,),

                  CustomTextField(
                    hint: 'Email',
                    controller: controller.emailController,
                  ),

                  SizedBox(height: 10,),

                  CustomTextField(
                    hint: 'Password',
                    controller: controller.passwordController,
                    obscureText: true,
                  ),

                  SizedBox(height: 20,),

                  CustomButton(
                    label: 'Login',
                    onPressed: (){
                      controller.checkLogin();
                    },
                  ),

                  SizedBox(height: 20,),

                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Color(0xff949494),
                      ),
                      children: [
                        TextSpan(
                          text: 'Don\'t have an account? ',
                        ),
                        TextSpan(
                          text: 'Sign up',
                          recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            Get.toNamed(GetRoutes.signup);
                          },
                          style: TextStyle(
                            color: Color(0xff6b7afc),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
