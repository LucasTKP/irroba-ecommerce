import 'package:intl/intl.dart';
import 'package:irroba/core/models/product.dart';

class CartModel {
  final String id;
  final String userId;
  final String date;
  final List<ProductModel> products;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json, List<ProductModel> products) {
    DateTime parsedDate = DateTime.parse(json['date']);
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    return CartModel(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      date: formattedDate,
      products: products,
    );
  }

  Map<String, dynamic> toJson() {
    final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    final DateFormat outputFormat = DateFormat('yyyy/MM/dd');
    final String formattedDate = outputFormat.format(inputFormat.parse(date));
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'userId': userId,
      'date': formattedDate,
      'products': products.map((element) => {"productId": element.id, "quantity": element.quantity}).toList()
    };

    return data;
  }

  @override
  String toString() {
    return 'CartModel(id: $id, userId: $userId, date: $date, products: $products)';
  }

  factory CartModel.fromCartModel(CartModel cartModel, List<ProductModel> products) {
    return CartModel(
      id: cartModel.id,
      userId: cartModel.userId,
      date: cartModel.date,
      products: products,
    );
  }
}
