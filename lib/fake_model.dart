class UserModel{
  String name;
  String imageUrl;

  UserModel({
    required this.name,
    required this.imageUrl,
  });
  factory UserModel.fake() {
    return UserModel(name: "isim", imageUrl: "foto");
  }

}
