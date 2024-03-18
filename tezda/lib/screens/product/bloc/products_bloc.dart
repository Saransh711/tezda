// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tezda/model/product_model.dart';

import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductEvent, ProductState> {
  ProductsBloc() : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      try {
        final products = await fetchProducts();
        emit(ProductLoadSuccess(products));
      } catch (_) {
        emit(ProductLoadFailure());
      }
    });
  }
  Future<List<ProductModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ProductModel> products = [];
      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
