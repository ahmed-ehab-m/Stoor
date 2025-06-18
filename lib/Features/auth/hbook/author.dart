class Author {
  int? id;
  String? name;

  Author({this.id, this.name});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
