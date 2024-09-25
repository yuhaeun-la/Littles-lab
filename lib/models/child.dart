// models/child.dart
class Child {
  String name;
  String age;
  String? imageUrl;
  String? code;
  String? pairingToken;       // 페어링 토큰 추가
  DateTime? pairingTimestamp; // 페어링 타임스탬프 추가
  String? parentId;           // 페어링된 부모의 ID 추가

  Child({
    required this.name,
    required this.age,
    this.imageUrl,
    this.code,
    this.pairingToken,
    this.pairingTimestamp,
    this.parentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'imageUrl': imageUrl,
      'code': code,
      'pairingToken': pairingToken,
      'pairingTimestamp': pairingTimestamp?.toIso8601String(),
      'parentId': parentId,
    };
  }

  static Child fromJson(Map<String, dynamic> json) {
    return Child(
      name: json['name'],
      age: json['age'],
      imageUrl: json['imageUrl'],
      code: json['code'],
      pairingToken: json['pairingToken'],
      pairingTimestamp: json['pairingTimestamp'] != null
          ? DateTime.parse(json['pairingTimestamp'])
          : null,
      parentId: json['parentId'],
    );
  }
}
