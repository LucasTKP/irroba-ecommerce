class CartModel {
  final String id;
  final String userId;
  final String date;
  final List<ProductCart> products;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: json['products'],
    );
  }

  @override
  String toString() {
    return 'CartModel(id: $id, userId: $userId, date: $date, products: $products)';
  }
}

class ProductCart {
  final String id;
  final int quantity;

  ProductCart({
    required this.id,
    required this.quantity,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) {
    return ProductCart(
      id: json['id'].toString(),
      quantity: json['quantity'],
    );
  }

  @override
  String toString() {
    return 'ProductCart(id: $id, quantity: $quantity)';
  }
}
