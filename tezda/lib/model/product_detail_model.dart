class ProductDetail {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final Map<String, dynamic> rating;

  ProductDetail(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.image,
      required this.rating});

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
      rating: json['rating'],
    );
  }
}
