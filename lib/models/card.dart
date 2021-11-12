class DiagnosticCard {
  final int id;
  final String name;
  final int operationId;
  final int reportId;
  final String conclusion;
  final String description;
  final String area;
  final String damage;
  final String priority;
  final String recommend;
  final String time;
  final String effect;
  final int manHours;

  DiagnosticCard({
    required this.id,
    required this.name,
    required this.operationId,
    required this.reportId,
    required this.conclusion,
    required this.description,
    required this.area,
    required this.damage,
    required this.priority,
    required this.recommend,
    required this.time,
    required this.effect,
    required this.manHours
  });

  Map<String, dynamic> toMap() {
    return {
      'card_name' : name,
      'operation_id' : operationId,
      'conclusion' : conclusion,
      'description' : description,
      'area' : area,
      'damage' : damage,
      'priority' : priority,
      'recommend' : recommend,
      'time' : time,
      'effect' : effect,
      'man_hours' : manHours
    };
  }

  @override
  init() {
    return DiagnosticCard(
        id: 0,
        name: '',
        operationId: 0,
        reportId: 0,
        conclusion: 'УСПЕШНО',
        description: '',
        area: '',
        damage: '',
        priority: 'РЕКОМЕНДУЕТСЯ',
        recommend: '',
        time: '',
        effect: '',
        manHours: 0
    );
  }
}
