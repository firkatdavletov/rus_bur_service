class AppPicture {
  final int id;
  final int reportId;
  final String cardId;
  final String name;
  final int pictureFileName;
  final String description;

  AppPicture({
    required this.id,
    required this. reportId,
    required this.cardId,
    required this.name,
    required this.pictureFileName,
    required this.description
  });

  Map<String, dynamic> toMap() {
    return {
      //'picture_id' : id,
      'report_id' : reportId,
      'card_id' : cardId,
      'picture_name' : name,
      'picture_file_name' : pictureFileName,
      'picture_description' : description,
    };
  }
}