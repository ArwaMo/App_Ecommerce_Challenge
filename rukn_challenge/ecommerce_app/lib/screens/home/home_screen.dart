// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, use_super_parameters

import 'package:ecommerce_app/models/person_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/components/product_item_widget.dart';

import 'package:ecommerce_app/screens/home/components/category_item_widget.dart';
import 'package:ecommerce_app/screens/products_screen.dart';
import 'package:ecommerce_app/servicesApi/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.user}) : super(key: key);
  final PersonModel? user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  List<String> images = [
    'assets/images/black-headphones.jpg',
    'assets/images/jewelery.png',
    'assets/images/men_Clothing.jpg',
    'assets/images/women_Clothing.jpeg'
  ];
  List<ProductModel> allProducts = [];
  List<String> listCate = [];
  bool isCategory = false;
  @override
  void initState() {
    getAllCategory();
    getAllProducts();

    setState(() {});
    super.initState();
  }

  void getAllProducts() async {
    List<ProductModel> products = await Services().getAllProduct();
    setState(() {
      allProducts = products;
    });
  }

  getAllCategory() async {
    List<dynamic> cate = await Services().getCategory();
    if (cate.isNotEmpty) {
      for (var element in cate) {
        listCate.add(element);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.9,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Color(0xff652ca5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(color: Color(0xffe1bdf0)),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${widget.user!.name}',
                          style: const TextStyle(
                            color: Color(0xfff1d2f9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 0.8,
                          child: Image.asset(
                            'assets/images/headphones.jpg',
                          ),
                        ),
                        Positioned(
                          top: 90.sp,
                          left: 20.sp,
                          child: Row(
                            children: [
                              const Text(
                                'Discount 20% For \nHeadphones!',
                                style: TextStyle(
                                  color: Color(0xfff0fefe),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Color(0xffac2fd6)),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Buy Now',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 254, 222, 254),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  const Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < listCate.length; i++)
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4.3,
                            child: CategoryItemWidget(
                              imagePath: images[i],
                              label: listCate[i],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductsScreen(
                                        isCategory: true,
                                        category: listCate[i],
                                      ),
                                    ));
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular product',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductsScreen(
                                      isCategory: false,
                                      category: '',
                                    )),
                          );
                        },
                        child: const Text(
                          'See all',
                          style: TextStyle(color: Color(0xffac2fd6)),
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<List<ProductModel>>(
                    future: Future.value(allProducts),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        List<ProductModel> products =
                            snapshot.data!.take(3).toList();

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: products
                                .map((product) => ProductItemWidget(
                                      product: product,
                                    ))
                                .toList(),
                          ),
                        );
                      }
                      return Center(
                          child: const Text(
                              'An error occurred when fetching data'));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
