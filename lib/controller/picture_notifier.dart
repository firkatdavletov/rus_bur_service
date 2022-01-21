import 'package:flutter/material.dart';

enum PhotoName {
  generalView,
  stateRegNumb,
  generalSerialNumb,
  engineSerialNumb,
  additional
}

class PictureNotifier with ChangeNotifier {
  PhotoName _photoName = PhotoName.generalView;
  String _addPhotoName = '';
  String _pictureDescription = '';

  PhotoName get photoName => _photoName;
  String get addPhotoName => _addPhotoName;
  String get pictureDescription => _pictureDescription;

  changePhotoName (PhotoName controller) {
    _photoName = controller;
    notifyListeners();
  }

  changeAddPhotoName (String controller) {
    _addPhotoName = controller;
    notifyListeners();
  }

  changePictureDescription (String textController) {
    _pictureDescription = textController;
    notifyListeners();
  }
}