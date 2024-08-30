class UserModel {
  String? name;
  String? email;
  String? uId;
  String? bio;
  String? image;
  String? lastMessage;
  String? senderId;
  bool? isTyping;
  String? pushToken;

  DateTime? timestamp;

  UserModel({
    this.name,
    this.email,
    this.uId,
    this.bio,
    this.image,
    this.lastMessage,
    this.senderId,
    this.timestamp,
    this.isTyping,
    this.pushToken,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    bio = json['bio'];
    image = json['image'];
    lastMessage = json['lastMessage'];
    senderId = json['senderId'];
    isTyping = json['isTyping'];
    timestamp = json['timestamp']?.toDate();
    pushToken = json['pushToken'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'bio': bio,
      'image': image,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
      'senderId': senderId,
      'isTyping': isTyping,
      'pushToken': pushToken,
    };
  }
}
