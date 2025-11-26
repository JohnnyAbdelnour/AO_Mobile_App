class Product {
  final int id;
  final String sku;
  final String name;
  final double price;
  final String typeId;
  final String? imageUrl;
  // Assuming 'custom_attributes' contain additional product data
  final String? author;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.price,
    required this.typeId,
    this.imageUrl,
    this.author,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String? imageUrl;
    String? author;

    if (json['media_gallery_entries'] != null && (json['media_gallery_entries'] as List).isNotEmpty) {
      imageUrl = json['media_gallery_entries'][0]['file'];
    }

    if (json['custom_attributes'] != null) {
      for (var attribute in json['custom_attributes']) {
        if (attribute['attribute_code'] == 'author') {
          author = attribute['value'];
        }
      }
    }

    return Product(
      id: json['id'],
      sku: json['sku'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      typeId: json['type_id'],
      imageUrl: imageUrl,
      author: author,
    );
  }
}
