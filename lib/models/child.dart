class Child {
  String name;
  String age;
  String? imageUrl;
  String? code;

  Child({
    required this.name,
    required this.age,
    this.imageUrl,
    this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'imageUrl': imageUrl,
      'code': code,
    };
  }

  static Child fromJson(Map<String, dynamic> json) {
    return Child(
      name: json['name'],
      age: json['age'],
      imageUrl: json['imageUrl'],
      code: json['code'],
    );
  }
}
