import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Image.network(
                      widget.product.image,
                      height: 230,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Text(
                    widget.product.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  )),
                  Text(
                    '\$${widget.product.price}',
                    style: const TextStyle(
                        color: Color(0xff652ca5),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.star_border_rounded,
                      color: Color(0xffac2fd6)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 70,
                  ),
                  Text(
                    '${widget.product.rating.rate}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 80,
                  ),
                  const Text(
                    'Rating',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Divider(
                height: MediaQuery.of(context).size.height / 20,
                color: Colors.amber,
                thickness: 3,
                endIndent: 0,
                indent: 0,
              ),
              Text(widget.product.description),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FloatingActionButton(
                  backgroundColor: const Color(0xff652ca5),
                  onPressed: () {},
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xfff1d2f9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
