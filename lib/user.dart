class User {
  final int id;
  final String name;
  final String login;
  final String password;
  final bool isAdmin;

  User({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    required this.isAdmin
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name' : name,
      'login' : login,
      'password' : password,
      'isAdmin' : isAdmin,
    };
  }
}