class UserProfileModel {
  String? uid;
  String? fullName;
  String? username;
  String? password;
  String? age;
  String? gender;
  String? height;
  String? email;
  String? fatsPercentage;
  String? waterPercentage;
  String? musclesPercentage;

  UserProfileModel({
    this.uid,
    this.fullName,
    this.gender,
    this.height,
    this.email,
    this.age,
    this.fatsPercentage,
    this.musclesPercentage,
    this.waterPercentage,
    this.username,
    this.password,
  });

  factory UserProfileModel.fromFirestore(Map<String, dynamic> data) {
    return UserProfileModel(
      uid: data["uid"] ?? "",
      fullName: data["Full name"] ?? "",
      email: data["Email"] ?? "",
      age: data["Age"] ?? "",
      gender: data["Gender"] ?? "",
      height: data["Height"] ?? "",
      musclesPercentage: data["Muscles Percentage"] ?? "",
      waterPercentage: data["Water Percentage"] ?? "",
      username: data["username"] ?? "",
      fatsPercentage: data["Fats Percentage"] ?? "",
    );
  }
}
