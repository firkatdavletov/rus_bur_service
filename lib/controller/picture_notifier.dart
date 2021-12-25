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

  PhotoName get photoName => _photoName;
  String get addPhotoName => _addPhotoName;

  changePhotoName (PhotoName controller) {
    _photoName = controller;
    notifyListeners();
  }

  changeAddPhotoName (String controller) {
    _addPhotoName = controller;
    notifyListeners();
  }
}