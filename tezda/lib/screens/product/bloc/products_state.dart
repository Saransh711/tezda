import 'package:equatable/equatable.dart';
import 'package:tezda/model/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoadSuccess extends ProductState {
  final List<ProductModel> products;

  const ProductLoadSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class ProductLoadFailure extends ProductState {}
