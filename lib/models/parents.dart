class Parent {
  String childName;
  String childAge;
  String? imageUrl;
  String code;

  Parent({
    required this.childName,
    required this.childAge,
    this.imageUrl,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'childName': childName,
      'childAge': childAge,
      'imageUrl': imageUrl,
      'code': code,
    };
  }

  static Parent fromJson(Map<String, dynamic> json) {
    return Parent(
      childName: json['childName'],
      childAge: json['childAge'],
      imageUrl: json['imageUrl'],
      code: json['code'],
    );
  }
}
