class User {
  final String id;
  final String email;
  final String firstName;
  final String? lastName;
  final String? avatarUrl;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    this.lastName,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      avatarUrl: json['avatarUrl'],
    );
  }

  // Getter untuk menampilkan nama lengkap
  String get fullName => '$firstName ${lastName ?? ''}'.trim();
}