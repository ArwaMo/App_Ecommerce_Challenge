// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_app/models/person_model.dart';
import 'package:ecommerce_app/screens/auth/signin_screen.dart';
import 'package:ecommerce_app/servicesApi/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

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
              'Sign Up',
              style: TextStyle(
                  color: Color(0xffac2fd6),
                  fontWeight: FontWeight.w500,
                  fontSize: 28),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 38,
            ),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  hintText: 'Name',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  hintText: 'Phone',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
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
                text: 'Already have you account? ',
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SigninScreen(),
                              ));
                        },
                      text: 'Sign In',
                      style: const TextStyle(
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
                      PersonModel? emailExist =
                          await Services().getUserByEmail(emailController.text);
                      if (emailExist == null) {
                        //register
                        if (nameController.text.isNotEmpty &
                            phoneController.text.isNotEmpty &
                            emailController.text.isNotEmpty) {
                          if (Services().isEmail(emailController.text)) {
                            Map<String, dynamic> user = {
                              'name': nameController.text,
                              'phone': phoneController.text,
                              'email': emailController.text
                            };
                            PersonModel userModel = PersonModel.fromJson(user);
                            persons.add(
                              userModel,
                            );
                            Services().storeSharedPreferences(persons);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SigninScreen(),
                                ),
                                (Route<dynamic> route) => false);
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
                            content: Text('Please fill out all fields'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Email is already registered'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: const Text('Sign Up')))
          ],
        ),
      ),
    );
  }
}
