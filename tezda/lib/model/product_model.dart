class ProductModel {
  final String name;
  final int id;
  final double price;
  final String image;

  ProductModel({
    required this.name,
    required this.price,
    required this.id,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
      id: json['id'],
    );
  }
}
