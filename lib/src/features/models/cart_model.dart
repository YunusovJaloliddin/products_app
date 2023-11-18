import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  int id;
  int userId;
  DateTime date;
  List<Map<String, int>> products;
  int v;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  factory CartModel.fromJson(Map<String, Object?> json) => _$CartModelFromJson(json);

  Map<String, Object?> toJson() => _$CartModelToJson(this);

  @override
  String toString() {
    return 'CartModel{id: $id, userId: $userId, date: $date, products: $products, v: $v}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          date == other.date &&
          products == other.products &&
          v == other.v;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      date.hashCode ^
      products.hashCode ^
      v.hashCode;
}
