class Parent {
  String childName;
  String childAge;
  String? imageUrl;
  String code;
  String? pairingToken;        // 페어링 토큰
  DateTime? pairingTimestamp;  // 페어링 타임스탬프
  String? pairedChildId;       // 페어링된 아이의 ID
  String? webrtcId;            // WebRTC 연결 시 사용될 ID

  Parent({
    required this.childName,
    required this.childAge,
    this.imageUrl,
    required this.code,
    this.pairingToken,
    this.pairingTimestamp,
    this.pairedChildId,
    this.webrtcId,
  });

  // Firestore에 데이터를 저장하기 위한 toJson 메서드
  Map<String, dynamic> toJson() {
    return {
      'childName': childName,
      'childAge': childAge,
      'imageUrl': imageUrl,
      'code': code,
      'pairingToken': pairingToken,
      'pairingTimestamp': pairingTimestamp?.toIso8601String(),
      'pairedChildId': pairedChildId,
      'webrtcId': webrtcId,
    };
  }

  // Firestore에서 데이터를 가져올 때 사용하는 fromJson 메서드
  static Parent fromJson(Map<String, dynamic> json) {
    return Parent(
      childName: json['childName'],
      childAge: json['childAge'],
      imageUrl: json['imageUrl'],
      code: json['code'],
      pairingToken: json['pairingToken'],
      pairingTimestamp: json['pairingTimestamp'] != null
          ? DateTime.parse(json['pairingTimestamp'])
          : null,
      pairedChildId: json['pairedChildId'],
      webrtcId: json['webrtcId'],
    );
  }
}
