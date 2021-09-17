class User {
  final int userId;
  final String login;
  final String firstName;
  final String lastName;
  final String middleName;

  User({
    required this.userId,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.middleName,
  });

  Map<String, dynamic> toMap() {
    return {
      //'user_id': userId,
      'user_firstname': firstName,
      'user_lastname': lastName,
      'user_middlename': middleName,
      'user_login': login,
    };
  }

  String nameToString() {
    return '$firstName $lastName $middleName';
  }

  String loginToString() {
    return '$login';
  }

  String idToString() {
    return '$userId';
  }
}
