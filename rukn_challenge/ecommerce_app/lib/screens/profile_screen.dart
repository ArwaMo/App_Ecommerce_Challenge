// ignore_for_file: pronstructors, must_be_immutable, collection_methods_unrelated_type, non_constant_identifier_names

import 'package:ecommerce_app/models/person_model.dart';
import 'package:ecommerce_app/servicesApi/services.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.user,
  });
  final PersonModel user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    String initialValueOfName = widget.user.name;
    nameController.text = initialValueOfName;

    String initialValueOfPhone = widget.user.phone;
    phoneController.text = initialValueOfPhone;
    String initialValueOfEmail = widget.user.email!;
    emailController.text = initialValueOfEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: const Color(0xff652ca5),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/user-avatar.png',
                              width: 80,
                              height: 80,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 22,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Profile',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 28),
                                ),
                                Text(
                                  widget.user.email!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account Information',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        hintText: 'Name',
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70,
                  ),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: 'Phone',
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70,
                  ),
                  TextField(
                    readOnly: true,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            persons.removeWhere(
                                (Item) => Item.email == widget.user.email);

                            widget.user.name = nameController.text;
                            widget.user.phone = phoneController.text;

                            Map<String, dynamic> user = {
                              'name': widget.user.name,
                              'phone': widget.user.phone,
                              'email': widget.user.email
                            };
                            PersonModel userModel = PersonModel.fromJson(user);
                            persons.add(
                              userModel,
                            );

                            for (var element in persons) {
                              print(element.name);
                            }
                            Services().storeSharedPreferences(persons);

                            setState(() {});

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text('Data has been changed successfully'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ));
                          },
                          child: const Text('Change')))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
