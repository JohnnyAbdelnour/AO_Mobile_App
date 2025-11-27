import 'package:antoine_online_app/src/data/models/cart/cart_item.dart';

class Order {
  final int entityId;
  final String incrementId;
  final String status;
  final String createdAt;
  final double grandTotal;
  final List<CartItem> items;

  Order({
    required this.entityId,
    required this.incrementId,
    required this.status,
    required this.createdAt,
    required this.grandTotal,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var items = <CartItem>[];
    if (json['items'] != null) {
      items = (json['items'] as List)
          .map((i) => CartItem.fromJson(i))
          .toList();
    }

    return Order(
      entityId: json['entity_id'],
      incrementId: json['increment_id'],
      status: json['status'],
      createdAt: json['created_at'],
      grandTotal: (json['grand_total'] as num).toDouble(),
      items: items,
    );
  }
}
