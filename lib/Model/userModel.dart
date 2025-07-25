class User {
  final String id;
  final String token;
  final String email;

  User({
    required this.id,
    required this.token,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['localId'],
      token: json['idToken'],
      email: json['email'],
    );
  }
}
