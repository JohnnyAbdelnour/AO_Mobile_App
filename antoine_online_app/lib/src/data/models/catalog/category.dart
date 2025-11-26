class Category {
  final int id;
  final String name;
  final int parentId;
  final bool isActive;
  final int position;
  final int level;
  final int productCount;
  final List<Category> childrenData;

  Category({
    required this.id,
    required this.name,
    required this.parentId,
    required this.isActive,
    required this.position,
    required this.level,
    required this.productCount,
    required this.childrenData,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    // Assuming 'children_data' is the key for nested categories
    var children = <Category>[];
    if (json['children_data'] != null) {
      children = (json['children_data'] as List)
          .map((i) => Category.fromJson(i))
          .toList();
    }

    return Category(
      id: json['id'],
      name: json['name'],
      parentId: json['parent_id'],
      isActive: json['is_active'],
      position: json['position'],
      level: json['level'],
      productCount: json['product_count'],
      childrenData: children,
    );
  }
}
