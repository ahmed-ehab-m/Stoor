import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final int? id;
  final String? name;

  const Author({this.id, this.name});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  List<Object?> get props => [id, name];
}
