// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously

import 'package:ecommerce_app/models/person_model.dart';

import 'package:ecommerce_app/screens/navigation_bar.dart';
import 'package:ecommerce_app/screens/auth/signup_screen.dart';
import 'package:ecommerce_app/servicesApi/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({
    super.key,
  });

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    Services().getStoredUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sign In',
              style: TextStyle(
                  color: Color(0xffac2fd6),
                  fontWeight: FontWeight.w500,
                  fontSize: 28),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 38,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: 'Email',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
            ),
            RichText(
              text: TextSpan(
                text: 'Don' 't have an account? ',
                style: TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ));
                        },
                      text: 'Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff652ca5))),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 70,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isNotEmpty) {
                        if (Services().isEmail(emailController.text)) {
                          PersonModel? emailExist = await Services()
                              .getUserByEmail(emailController.text);
                          if (emailExist != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationBarCurve(
                                    user: emailExist,
                                  ),
                                ),
                                (Route<dynamic> route) => false);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Email is not registered'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Please enter a valid email'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Please fill out your email'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: const Text('Sign in')))
          ],
        ),
      ),
    );
  }
}
