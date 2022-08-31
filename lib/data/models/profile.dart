import 'dart:convert';

class Profile {
  String type;
  String name;
  String phoneNumber;
  String? emailAddress;
  String? idNumber;

  Profile({
    required this.type,
    required this.name,
    required this.phoneNumber,
    this.emailAddress,
    this.idNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,
      'idNumber': idNumber,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      emailAddress: map['emailAddress'],
      idNumber: map['idNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source));
}
