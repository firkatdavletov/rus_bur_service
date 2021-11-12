import 'package:flutter/material.dart';
import 'package:rus_bur_service/widgets/list_views/picture_grid_item.dart';

class PicturesGridList extends StatefulWidget {
  const PicturesGridList({Key? key}) : super(key: key);

  @override
  _PicturesGridListState createState() => _PicturesGridListState();
}

class _PicturesGridListState extends State<PicturesGridList> {

  List<Widget> _listOfPictures = [
    PictureGridItem(title: 'Общий вид оборудования'),
    PictureGridItem(title: 'Государственный регистрационный номер'),
    PictureGridItem(title: 'Серийный номер оборудования'),
    PictureGridItem(title: 'Государственный регистрационный номер'),
    PictureGridItem(title: 'Серийный номер ДВС'),
    PictureGridItem(title: 'Государственный регистрационный номер'),
    PictureGridItem(title: 'Дополнительное фото')
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: _listOfPictures,
    );
  }
}
