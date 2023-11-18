import 'package:json_annotation/json_annotation.dart';

part 'adress_model.g.dart';

@JsonSerializable()
class AddressModel {
  Geolocation geolocation;
  String city;
  String street;
  int number;
  String zipcode;

  AddressModel({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory AddressModel.fromJson(Map<String, Object?> json) => _$AddressModelFromJson(json);

  Map<String, Object?> toJson() => _$AddressModelToJson(this);
}

class Geolocation {
  String lat;
  String long;

  Geolocation({required this.lat, required this.long});

  factory Geolocation.fromJson(Map<String, Object?> json) => Geolocation(
        lat: json["lat"] as String,
        long: json["long"] as String,
      );

  Map<String, Object?> toJson() => {
        'lat': lat,
        'long': long,
      };
}
