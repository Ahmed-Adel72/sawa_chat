class UserModel {
  String? name;
  String? email;
  String? uId;
  String? bio;
  String? image;

  UserModel({
    this.name,
    this.email,
    this.uId,
    this.bio,
    this.image,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    bio = json['bio'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'bio': bio,
      'image': image,
    };
  }
}
