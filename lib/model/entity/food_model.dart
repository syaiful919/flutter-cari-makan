import 'package:carimakan/utils/shared_value.dart';

class FoodModel {
  FoodModel({
    this.id,
    this.picturePath,
    this.name,
    this.description,
    this.ingredients,
    this.price,
    this.rate,
    this.types,
  });

  int id;
  String picturePath;
  String name;
  String description;
  String ingredients;
  int price;
  double rate;
  String types;

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json["id"] == null ? null : json["id"],
        picturePath: json["picturePath"] == null ? null : json["picturePath"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        ingredients: json["ingredients"] == null ? null : json["ingredients"],
        price: json["price"] == null
            ? null
            : json["price"] is String
                ? int.tryParse(json["price"])
                : json["price"],
        rate: json["rate"] == null ? null : (json["rate"] as num).toDouble(),
        types: json["types"] == null ? null : json["types"],
      );

  List<FoodType> getTypes() {
    return types.split(',').map((e) {
      switch (e) {
        case 'recommended':
          return FoodType.recommended;
          break;
        case 'popular':
          return FoodType.popular;
          break;
        default:
          return FoodType.new_food;
      }
    }).toList();
  }
}
