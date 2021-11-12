import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';

class User {
  final int userId;
  final String login;
  final String firstName;
  final String lastName;
  final String middleName;
  final bool isAdmin;

  User({
    required this.userId,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.isAdmin
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id' : userId,
      'user_firstname': firstName,
      'user_lastname': lastName,
      'user_middlename': middleName,
      'user_login': login,
      'user_is_admin' : isAdmin? 1 : 0
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
