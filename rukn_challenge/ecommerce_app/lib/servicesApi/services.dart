// ignore_for_file: unnecessary_new

import 'dart:async';
import 'dart:convert';

import 'package:ecommerce_app/models/person_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List<PersonModel> persons = List.empty(growable: true);

class Services {
  Future<List<ProductModel>> getAllProduct() async {
    try {
      Uri url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> products = jsonDecode(response.body);

        List<ProductModel> listProducts = [];

        for (var product in products) {
          ProductModel result = ProductModel.fromJson(product);
          listProducts.add(result);
        }

        return listProducts;
      } else {
        throw Exception('Failed to load product');
      }
    } catch (er) {
      throw Exception('Error occurred');
    }
  }

  Future<List<ProductModel>> getProductCategory(String category) async {
    Uri url = Uri.parse('https://fakestoreapi.com/products/category/$category');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> prducts = jsonDecode(response.body);
      List<ProductModel> listProductCategory = [];
      for (var product in prducts) {
        ProductModel result = ProductModel.fromJson(product);
        listProductCategory.add(result);
      }
      return listProductCategory;
    } else {
      throw Exception('Failed to load $category product');
    }
  }

  Future<List<dynamic>> getCategory() async {
    Uri url = Uri.parse('https://fakestoreapi.com/products/categories');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> category = jsonDecode(response.body);

      return category;
    } else {
      throw Exception('Failed to load category type');
    }
  }

  bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  void storeSharedPreferences(List<PersonModel> persons) async {
    List<String> resultUserData =
        persons.map((person) => jsonEncode(person.toJson())).toList();

    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setStringList('userData', resultUserData);
  }

  Future<List<PersonModel>> getStoredUsers() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? resultDataUser = sp.getStringList('userData');

    if (resultDataUser == null) {
      return [];
    }

    return resultDataUser
        .map((jsonString) => PersonModel.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  Future<PersonModel?> getUserByEmail(String email) async {
    List<PersonModel> users = await getStoredUsers();

    for (var user in users) {
      if (user.email == email) {
        return user;
      }
    }

    return null;
  }
}
