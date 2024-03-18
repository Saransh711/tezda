import 'package:equatable/equatable.dart';
import 'package:tezda/model/product_detail_model.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoadSuccess extends ProductDetailState {
  final ProductDetail products;

  const ProductDetailLoadSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class ProductDetailLoadFailure extends ProductDetailState {}
