class Spare {
  final int id;
  final String number;
  final int quantity;
  final String name;
  final String measure;
  final String issue;
  final String cardId;
  final int priority;

  Spare({
    required this.id,
    required this.number,
    required this.quantity,
    required this.name,
    required this.measure,
    required this.issue,
    required this.cardId,
    required this.priority
  });

  Map<String, dynamic> toMap() {
    return {
      //'spare_id' : id,
      'spare_number' : number,
      'spares_quantity' : quantity,
      'spare_name' : name,
      'spare_measure' : measure,
      'spare_issue' : issue,
      'card_id' : cardId,
      'spare_priority' : priority
    };
  }
}