abstract class ProductDetailEvent {}

class FetchProductDetail extends ProductDetailEvent {
  final int productId;
  FetchProductDetail(this.productId);
}
