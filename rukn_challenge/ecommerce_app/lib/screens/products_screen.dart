// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/components/product_item_widget.dart';
import 'package:ecommerce_app/servicesApi/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    super.key,
    required this.isCategory,
    required this.category,
  });

  final bool isCategory;
  final String category;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder<List<ProductModel>>(
            future: widget.isCategory
                ? Services().getProductCategory(widget.category)
                : Services().getAllProduct(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                List<ProductModel> products = snapshot.data!;
                return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.4.h,
                      crossAxisCount: 2,
                      mainAxisSpacing: 9.h),
                  itemBuilder: (context, index) {
                    return ProductItemWidget(
                      product: products[index],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('An error occurred. Please try again later.'),
                );
              } else {
                return const Center(
                  child: Text('No data available'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
