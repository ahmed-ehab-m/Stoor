class UserModel {
  final String name;
  final String email;
  final String? uid;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      uid: json['uid'] as String?,
    );
  }
}
