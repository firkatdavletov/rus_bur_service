class Part {
  final int id;
  final String name;
  bool isChecked = false;
  bool enable = true;

  Part({
    required this.id,
    required this.name
  });

  Map<String, dynamic> toMap() {
    return {
      'part_name' : name
    };
  }
}