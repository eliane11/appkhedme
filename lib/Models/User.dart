class User {
  String? name;
  String email;
  String phone;
  String password;

  // Optional fields for login (only email and password needed)
  User({this.name, required this.email, this.phone = '', required this.password});

  // toJson method for both registration and login
  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      'email': email,
      if (phone.isNotEmpty) 'phone': phone,
      'password': password,
    };
  }
}
