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
      'userId': userId,
      'customerId': customerId,
      'machineId': machineId,
      'engineId': engineId,
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
    'Note: $note\n';
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