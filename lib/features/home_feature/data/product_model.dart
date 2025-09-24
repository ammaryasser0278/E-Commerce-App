import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String image;
  final String name;
  final double price;
  final double rating;
  final String desc;

  const Product({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
    required this.desc,
  });

  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      image: (map['image'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : (map['price'] ?? 0.0) as double,
      rating: (map['rating'] is int)
          ? (map['rating'] as int).toDouble()
          : (map['rating'] ?? 0.0) as double,
      desc: (map['desc'] ?? '') as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'price': price,
      'rating': rating,
      'desc': desc,
    };
  }

  @override
  List<Object?> get props => [id, image, name, price, rating, desc];
}
