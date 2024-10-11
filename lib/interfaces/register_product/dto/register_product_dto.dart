import 'package:irroba/core/models/category.dart';

class RegisterProductDto {
  final String title;
  final double price;
  final String description;
  final String image;
  final CategoryModel category;

  RegisterProductDto({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category.name,
    };
  }

  @override
  String toString() {
    return 'RegisterProductDto{title: $title, price: $price, description: $description, image: $image, category: $category}';
  }
}
