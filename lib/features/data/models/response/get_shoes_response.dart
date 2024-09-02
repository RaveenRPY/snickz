
import 'dart:convert';

List<GetShoesResponse> getShoesResponseFromJson(String str) => List<GetShoesResponse>.from(json.decode(str).map((x) => GetShoesResponse.fromJson(x)));

String getShoesResponseToJson(List<GetShoesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetShoesResponse {
  final String? name;
  final String? price;
  final String? image;
  final String? description;
  final String? category;
  final String? id;

  GetShoesResponse({
    this.name,
    this.price,
    this.image,
    this.description,
    this.category,
    this.id,
  });

  factory GetShoesResponse.fromJson(Map<String, dynamic> json) => GetShoesResponse(
    name: json["name"],
    price: json["price"],
    image: json["image"],
    description: json["description"],
    category: json["category"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "image": image,
    "description": description,
    "category": category,
    "id": id,
  };
}
