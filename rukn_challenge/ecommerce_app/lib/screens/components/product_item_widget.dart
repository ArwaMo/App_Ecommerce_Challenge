// ignore_for_file: must_be_immutable

import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  State<ProductItemWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(product: widget.product),
                  ));
            },
            child: Container(
              padding: EdgeInsets.all(3.sp),
              width: 200.w,
              height: 280.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Image.network(
                        widget.product.image,
                        fit: BoxFit.contain,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Divider(
                      height: MediaQuery.of(context).size.height / 200,
                      color: Colors.amber,
                      thickness: 3,
                      endIndent: 0,
                      indent: 0,
                    ),
                    Text(
                      widget.product.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${widget.product.price}',
                          style: const TextStyle(
                              color: Color(0xffac2fd6),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 50.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xfff5f5f5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${widget.product.rating.rate}'),
                              const Icon(Icons.star_border_rounded,
                                  color: Color(0xffac2fd6)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
