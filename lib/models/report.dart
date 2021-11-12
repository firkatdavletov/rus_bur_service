class Report {
  final int id;
  final int userId;
  final String name;
  final String date;
  final String company;
  final String place;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String machineModel;
  final String machineNumb;
  final String machineYear;
  final String engineModel;
  final String engineNumb;
  final String opTime;
  final String note;

  Report({
    required this.id,
    required this.userId,
    required this.name,
    required this.date,
    required this.company,
    required this.place,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.machineModel,
    required this.machineNumb,
    required this.machineYear,
    required this.engineModel,
    required this.engineNumb,
    required this.opTime,
    required this.note
  });

  Map<String, dynamic> toMap() {
    return {
      'report_id' : id,
      'user_id' : userId,
      'report_name' : name,
      'report_date' : date,
      'customer_company' : company,
      'customer_name' : customerName,
      'customer_phone' : customerPhone,
      'customer_email' : customerEmail,
      'machine_model' : machineModel,
      'machine_sn' : machineNumb,
      'machine_year' : machineYear,
      'report_place' : place,
      'report_note' : note,
      'engine_model' : engineModel,
      'engine_sn' : engineNumb,
      'engine_optime' : opTime
    };
  }

  toString() {
    return '$id';
  }
}
