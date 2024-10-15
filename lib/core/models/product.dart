class ProductModel {
  final String id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;
  final int quantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: RatingModel.fromJson(json['rating']),
      quantity: 1,
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, price: $price, description: $description, category: $category, image: $image, rating: $rating)';
  }

  ProductModel copyWith({
    String? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    RatingModel? rating,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
    );
  }
}

class RatingModel {
  final double rate;
  final int count;

  RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }

  @override
  String toString() => 'Rating(rate: $rate, count: $count)';
}
