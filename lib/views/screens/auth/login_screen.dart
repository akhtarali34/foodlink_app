import 'package:flutter/material.dart';
import 'package:foodlink/resources/components/app_colors.dart';
import 'package:foodlink/resources/components/rounded_button.dart';
import 'package:get/get.dart';
import 'package:foodlink/vendor/views/auth/vendor_auth.dart';
import 'package:foodlink/views/screens/auth/register_screen.dart';
import 'package:foodlink/views/screens/map_screen.dart';

import '../../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController.instance;

  bool _isLoading = false;

  late String email;

  late String password;

  loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authController.loginUser(email, password);
    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      Get.offAll(MapScreen());
      Get.snackbar(
        'Success',
        'Logged In',
        colorText: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        margin: EdgeInsets.all(15),
        icon: Icon(
          Icons.message,
          color: AppColors.blackColor,
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } else {
      Get.snackbar(
        'Error Ocurred',
        res.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(15),
        icon: Icon(
          Icons.message,
          color: Colors.white,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: height*0.30,
                        child: const Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Login Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: AppColors.blackColor),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "for using your HomeChef App",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Email Address Must Not Be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      prefixIcon: Icon(Icons.alternate_email_outlined),
                      label: Text("Email"),
                      labelStyle: TextStyle(
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Password Must Not Be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_open_rounded),
                      label: Text("Password"),
                      labelStyle: TextStyle(
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                    title: 'LOGIN',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        loginUser();
                      } else {
                        Get.snackbar('Error validating Fields', 'Feilds Must Not Be Empty');
                      }
                    },
                    loading: _isLoading,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, RoutesName.forgetPassword);
                        },
                        child: const Text(
                          "Forget Password?",
                          style: TextStyle(
                              fontSize: 14, color: AppColors.blackColor),
                        )),
                  ),
                  SizedBox(
                    height: height*0.01,
                  ),

                  // Container(
                  //   width: MediaQuery.of(context).size.width - 200,
                  //   child: OutlinedButton(
                  //     onPressed: () {
                  //       if (_formKey.currentState!.validate()) {
                  //         loginUser();
                  //       } else {
                  //         Get.snackbar('Error validating Fields',
                  //             'Feilds Must Not Be Empty');
                  //       }
                  //     },
                  //     child: _isLoading
                  //         ? CircularProgressIndicator(
                  //             color: AppColors.mainColor,
                  //           )
                  //         : Text(
                  //             'LOGIN',
                  //           ),
                  //   ),
                  // ),

                  InkWell(
                    onTap: () {
                      Get.to(MapScreen());
                    },
                    child: Container(
                      height: height*0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child: const Center(
                        child: Text(
                          "Continue as Guest",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height*0.01,
                  ),

                  InkWell(
                    onTap: () {
                      Get.to(RegisterScreen());
                    },
                    child: Container(
                      height: height*0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child: const Center(
                        child: Text(
                          "Need a Customer Account",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height*0.01,
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return  VendorAuthScreen();
                          }));
                    },
                    child: Container(
                      height: height*0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child: const Center(
                        child: Text(
                          "Need a Vendor Account",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),


                  // TextButton(
                  //   onPressed: () {
                  //     Get.to(MapScreen());
                  //   },
                  //   child: Text(
                  //     'Continue As Guest',
                  //     style: TextStyle(
                  //       color: AppColors.blackColor,
                  //       fontSize: 18,
                  //       letterSpacing: 5,
                  //       decoration: TextDecoration.underline,
                  //     ),
                  //   ),
                  // ),
                  // TextButton(
                  //
                  //   onPressed: () {
                  //     Get.to(RegisterScreen());
                  //   },
                  //   child: Text(
                  //     'Need a customer Account',
                  //
                  //     style: TextStyle(
                  //       color: AppColors.blackColor,
                  //       fontSize: 18,
                  //       letterSpacing: 4,
                  //       decoration: TextDecoration.underline,
                  //     ),
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return  VendorAuthScreen();
                  //     }));
                  //   },
                  //   child: Text(
                  //     'Need a Vendor Account',
                  //     style: TextStyle(
                  //       color: AppColors.blackColor,
                  //       fontSize: 18,
                  //       letterSpacing: 1,
                  //       decoration: TextDecoration.underline,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
