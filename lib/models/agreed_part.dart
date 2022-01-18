class AgreedPart {
  final int reportId;
  final int partId;

  AgreedPart({
    required this.reportId,
    required this.partId
  });

  Map<String, dynamic> toMap() {
    return {
      'report_id' : reportId,
      'part_id' : partId,
    };
  }
}