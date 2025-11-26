import 'package:antoine_online_app/src/data/models/cart/cart_item.dart';

class Cart {
  final int id;
  final List<CartItem> items;
  final double grandTotal;

  Cart({
    required this.id,
    required this.items,
    required this.grandTotal,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var items = <CartItem>[];
    if (json['items'] != null) {
      items = (json['items'] as List)
          .map((i) => CartItem.fromJson(i))
          .toList();
    }

    return Cart(
      id: json['id'],
      items: items,
      grandTotal: (json['grand_total'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
