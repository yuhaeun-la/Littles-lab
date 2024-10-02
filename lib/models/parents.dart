class Parent {
  String childName;
  String childAge;
  String? imageUrl;
  String code;
  String? pairedChildId;       // 페어링된 아이의 ID
  String? webrtcId;            // WebRTC 연결 시 사용될 ID

  Parent({
    required this.childName,
    required this.childAge,
    this.imageUrl,
    required this.code,
    this.pairedChildId,
    this.webrtcId,
  });

  Map<String, dynamic> toJson() {
    return {
      'childName': childName,
      'childAge': childAge,
      'imageUrl': imageUrl,
      'code': code,
      'pairedChildId': pairedChildId,
      'webrtcId': webrtcId,
    };
  }

  static Parent fromJson(Map<String, dynamic> json) {
    return Parent(
      childName: json['childName'],
      childAge: json['childAge'],
      imageUrl: json['imageUrl'],
      code: json['code'],
      pairedChildId: json['pairedChildId'],
      webrtcId: json['webrtcId'],
    );
  }
}
