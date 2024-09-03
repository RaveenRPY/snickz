class ItemEntity {
  final String? title;
  final String? category;
  final double? price;
  final String? description;
  String? imgUrl;
  int qty;

  ItemEntity({
    this.title,
    this.category,
    this.price,
    this.description,
    this.imgUrl,
    required this.qty,
  });

  factory ItemEntity.fromJson(Map<String, dynamic> json) {
    return ItemEntity(
      title: json['title'],
      price: json['price'],
      imgUrl: json['imgUrl'],
      description: json['description'],
      category: json['category'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'imgUrl': imgUrl,
      'description': description,
      'category': category,
      'qty': qty,
    };
  }
}
