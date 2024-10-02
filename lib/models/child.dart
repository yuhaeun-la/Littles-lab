class Child {
  String name;
  String age;
  String? imageUrl;
  String? code;
  String? parentId;           // 페어링된 부모의 ID 추가

  Child({
    required this.name,
    required this.age,
    this.imageUrl,
    this.code,
    this.parentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'imageUrl': imageUrl,
      'code': code,
      'parentId': parentId,
    };
  }

  static Child fromJson(Map<String, dynamic> json) {
    return Child(
      name: json['name'],
      age: json['age'],
      imageUrl: json['imageUrl'],
      code: json['code'],
      parentId: json['parentId'],
    );
  }
}
