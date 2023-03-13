import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todos/controllers/signup_controller.dart';

import '../../routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetBuilder<SignupController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
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

                  SizedBox(height: 30,),

                  CustomTextField(
                    hint: 'Name',
                    controller: controller.nameController,
                  ),

                  SizedBox(height: 10,),

                  CustomTextField(
                    hint: 'Address',
                    controller: controller.addressController,
                  ),

                  SizedBox(height: 10,),

                  CustomTextField(
                    hint: 'Contact',
                    controller: controller.contactController,
                  ),

                  SizedBox(height: 10,),

                  CustomTextField(
                    hint: 'Email',
                    controller: controller.emailController,
                  ),

                  SizedBox(height: 10,),

                  CustomTextField(
                    hint: 'Password',
                    obscureText: true,
                    controller: controller.passwordController,
                  ),

                  SizedBox(height: 20,),

                  CustomTextField(
                    hint: 'Comfirm Password',
                    obscureText: true,
                    controller: controller.confirmPasswordController,
                  ),

                  SizedBox(height: 20,),

                  CustomButton(
                    label: 'Sign Up',
                    onPressed: (){
                      controller.checkSignup();
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
                          text: 'Already have an account? ',
                        ),
                        TextSpan(
                          text: 'Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = (){
                              Get.toNamed(GetRoutes.login);
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