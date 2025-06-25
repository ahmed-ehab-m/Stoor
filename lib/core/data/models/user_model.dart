import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String? uid;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
  });

  /// Convert a [Map<String, dynamic>] into a [UserModel].
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      uid: json['uid'] as String?,
    );
  }

  /// Convert a [UserModel] into a [Map<String, dynamic>].
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
    };
  }

  String toJson() => jsonEncode(toMap());
  factory UserModel.fromjsonString(String source) =>
      UserModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
