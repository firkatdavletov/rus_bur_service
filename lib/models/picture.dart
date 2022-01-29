class AppPicture {
  final int id;
  final int reportId;
  final String cardId;
  final String name;
  //final List<int> picture;
  final String description;

  AppPicture({
    required this.id,
    required this. reportId,
    required this.cardId,
    required this.name,
    //required this.picture,
    required this.description
  });

  Map<String, dynamic> toMap() {
    return {
      'picture_id' : id,
      'report_id' : reportId,
      'card_id' : cardId,
      'picture_name' : name,
      //'picture' : picture,
      'picture_description' : description,
    };
  }
}