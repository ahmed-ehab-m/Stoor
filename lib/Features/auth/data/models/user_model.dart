class UserModel {
  final String name;
  final String email;
  final String? uid;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
  });
}
