class Operation {
  final int id;
  final String name;
  final int partId;
  final bool isRequired;

  Operation({
    required this.id,
    required this.name,
    required this.partId,
    required this.isRequired
  });

  Map<String, dynamic> toMap() {
    return {
      'operation_name' : name,
      'part_id' : partId,
      'is_required' : isRequired? 1 : 0
    };
  }
}