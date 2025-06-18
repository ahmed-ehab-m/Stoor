import 'author.dart';
import 'category.dart';

class Hbook {
  int? id;
  String? title;
  String? description;
  String? price;
  String? rating;
  String? image;
  Author? author;
  Category? category;

  Hbook({
    this.id,
    this.title,
    this.description,
    this.price,
    this.rating,
    this.image,
    this.author,
    this.category,
  });

  factory Hbook.fromJson(Map<String, dynamic> json) => Hbook(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        price: json['price'] as String?,
        rating: json['rating'] as String?,
        image: json['image'] as String?,
        author: json['author'] == null
            ? null
            : Author.fromJson(json['author'] as Map<String, dynamic>),
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'rating': rating,
        'image': image,
        'author': author?.toJson(),
        'category': category?.toJson(),
      };
}
