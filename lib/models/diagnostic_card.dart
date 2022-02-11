class DiagnosticCard {
  final String id;
  final String name;
  final int operationId;
  final int reportId;
  final int conclusion;
  final String description;
  final String part;
  final String area;
  final String damage;
  final int priority;
  final String recommend;
  final int termWeek;
  final int term_mh;
  final int term_bh;
  final int term_m;
  final String effect;
  final int manHours;
  final int status;

  DiagnosticCard({
    required this.id,
    required this.name,
    required this.operationId,
    required this.reportId,
    required this.conclusion,
    required this.description,
    required this.part,
    required this.area,
    required this.damage,
    required this.priority,
    required this.recommend,
    required this.termWeek,
    required this.term_mh,
    required this.term_bh,
    required this.term_m,
    required this.effect,
    required this.manHours,
    required this.status
  });

  Map<String, dynamic> toMap() {
    return {
      'card_id' : id,
      'card_name' : name,
      'operation_id' : operationId,
      'report_id' : reportId,
      'conclusion' : conclusion,
      'description' : description,
      //'part' : part,
      'area' : area,
      'damage' : damage,
      'priority' : priority,
      'recommend' : recommend,
      'term_week' : termWeek,
      'term_mh' : term_mh,
      'term_bh' : term_bh,
      'term_m' : term_m,
      'effect' : effect,
      'man_hours' : manHours,
      'status' : status
    };
  }

  Map<String, dynamic> toLittleMap() {
    return <String, Object>{
      'conclusion': conclusion,
      'description' : description,
      'damage' : damage,
      'priority' : priority,
      'recommend' : recommend,
      'term_week' : termWeek,
      'term_mh' : term_mh,
      'term_bh' : term_bh,
      'term_m' : term_m,
      'effect' : effect,
      'man_hours' : manHours,
      'area' : area,
      'status' : status
    };
  }

  init() {
    return DiagnosticCard(
        id: '',
        name: '',
        operationId: 0,
        reportId: 0,
        conclusion: 1,
        description: '',
        area: '',
        damage: '',
        priority: 1,
        recommend: '',
        termWeek: 0,
        effect: '',
        manHours: 0,
        part: '',
        term_mh: 0,
        term_m: 0,
        term_bh: 0,
        status: 0
    );
  }
}
