import 'adress_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  AddressModel adress;
  int id;
  String email;
  String username;
  String password;
  Name name;
  String phone;
  int v;

  UserModel({
    required this.adress,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, Object?> json) => _$UserModelFromJson(json);

  Map<String, Object?> toJson() => _$UserModelToJson(this);
}

class Name {
  String firstname;
  String lastname;

  Name({required this.firstname, required this.lastname});

  factory Name.fromJson(Map<String, Object?> json) => Name(
        firstname: json["firstname"] as String,
        lastname: json["lastname"] as String,
      );

  Map<String, Object?> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
      };
}
