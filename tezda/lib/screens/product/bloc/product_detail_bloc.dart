// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tezda/model/product_detail_model.dart';
import 'package:tezda/screens/product/bloc/product_detail_event.dart';
import 'package:tezda/screens/product/bloc/product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<FetchProductDetail>((event, emit) async {
      emit(ProductDetailLoading());
      try {
        final products = await fetchProductDetail(event);
        emit(ProductDetailLoadSuccess(products));
      } catch (_) {
        emit(ProductDetailLoadFailure());
      }
    });
  }
  Future<ProductDetail> fetchProductDetail(FetchProductDetail event) async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/${event.productId}'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      return ProductDetail.fromJson(data);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
