class CartItem {
  final int itemId;
  final String sku;
  final int qty;
  final String name;
  final double price;
  final String quoteId;

  CartItem({
    required this.itemId,
    required this.sku,
    required this.qty,
    required this.name,
    required this.price,
    required this.quoteId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemId: json['item_id'],
      sku: json['sku'],
      qty: json['qty'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      quoteId: json['quote_id'],
    );
  }
}
