

class Report {
  final int id;
  final int userId;
  final int customerId;
  final int machineId;
  final int engineId;
  final String name;
  final String date;
  final String place;
  final String note;

  Report({
    required this.id,
    required this.userId,
    required this.customerId,
    required this.machineId,
    required this.engineId,
    required this.name,
    required this.date,
    required this.place,
    required this.note
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'customer_id': customerId,
      'machine_id': machineId,
      'engine_id': engineId,
      'name': name,
      'date': date,
      'place': place,
      'note': note
    };
  }
  @override
  String toString() {
    return 'Report ID: $id\n'
    'Report name: $name\n'
    'User: $userId\n'
    'Customer: $customerId\n'
    'Date: $date\n'
    'Place: $place\n'
    'Machine: $machineId\n'
    'Engine: $engineId\n'
    'Note: $note\n'
    '\n';
  }
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

class Customer {
  final int id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String phone;
  final String email;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'customer_id': id,
      'customer_first_name': firstName,
      'customer_last_name': lastName,
      'customer_middle_name': middleName,
      'customer_phone': phone,
      'customer_email': email,
    };
  }

  @override
  String toString() {
    return 'Customer:\n'
        'id: $id\n'
        'name: $lastName $firstName $middleName\n'
        'phone: $phone\n'
        'email: $email';
  }
}

class Machine {
  final int id;
  final String model;
  final String serNumb;
  final String year;

  Machine({
    required this.id,
    required this.model,
    required this.serNumb,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'machine_id': id,
      'machine_model': model,
      'machine_sn': serNumb,
      'machine_year': year,
    };
  }

  @override
  String toString() {
    return 'Machine:\n'
        'id: $id\n'
        'model: $model\n'
        'sn: $serNumb\n'
        'year: $year';
  }
}

class Engine {
  final int id;
  final String model;
  final String serNumb;
  final String operatingTime;

  Engine({
    required this.id,
    required this.model,
    required this.serNumb,
    required this.operatingTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'engine_id': id,
      'engine_model': model,
      'engine_sn': serNumb,
      'engine_optime': operatingTime,
    };
  }

  @override
  String toString() {
    return 'Machine:\n'
        'id: $id\n'
        'model: $model\n'
        'sn: $serNumb\n'
        'operating time: $operatingTime';
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String login;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.login,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': id,
      'user_first_name': firstName,
      'user_last_name': lastName,
      'user_middle_name': middleName,
      'user_login': login,
    };
  }

  @override
  String toString() {
    return 'User:\n'
        'id: $id\n'
        'name: $lastName $firstName $middleName\n'
        'login: $login';
  }
}