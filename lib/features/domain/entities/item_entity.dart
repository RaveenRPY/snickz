class ItemEntity {
  final String? title;
  final String? category;
  final double? price;
  final String? description;
  final String? imgUrl;
  int qty;

  ItemEntity({
    this.title,
    this.category,
    this.price,
    this.description,
    this.imgUrl,
    required this.qty,
  });
}
