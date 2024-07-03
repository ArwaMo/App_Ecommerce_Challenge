import 'package:ecommerce_app/models/person_model.dart';
import 'package:ecommerce_app/screens/home/home_screen.dart';
import 'package:ecommerce_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class NavigationBarCurve extends StatefulWidget {
  const NavigationBarCurve({
    super.key,
    required this.user,
  });
  final PersonModel user;

  @override
  State<NavigationBarCurve> createState() => _NavigationBarCurveState();
}

class _NavigationBarCurveState extends State<NavigationBarCurve> {
  int _page = 0;

  late List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      HomeScreen(user: widget.user),
      ProfileScreen(
        user: widget.user,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, size: 30),
            label: 'Profile',
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 133, 113, 157),
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 85, 43, 99),
        onTap: (int index) {
          setState(() {
            _page = index;
          });
        },
        currentIndex: _page,
      ),
      body: screens.elementAt(_page),
    );
  }
}
