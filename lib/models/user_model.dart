class UserModel {
  String? uid;
  String? email;
  String? password;

  UserModel({
    this.uid,
    this.email,
    this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
    };
  }
}

class UserPlace {
  final String formattedAddress;

  UserPlace({required this.formattedAddress});

  factory UserPlace.fromJson(Map<String, dynamic> json) {
    return UserPlace(
      formattedAddress: json['formattedAddress']
    );
  }
}
