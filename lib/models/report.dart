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
  final int opTime_1;
  final int opTime_2;
  final int opTime_3;
  final int opTime_4;
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
    required this.opTime_1,
    required this.opTime_2,
    required this.opTime_3,
    required this.opTime_4,
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
      'engine_optime_1' : opTime_1,
      'engine_optime_2' : opTime_2,
      'engine_optime_3' : opTime_3
    };
  }

  toString() {
    return '$id';
  }
}
