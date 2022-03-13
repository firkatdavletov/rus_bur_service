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
  double _maxWidth = 0.0;
  double _maxHeight = 0.0;
  int _quality = 0;
  bool _fromCamera = false;

  PhotoName get photoName => _photoName;
  String get addPhotoName => _addPhotoName;
  String get pictureDescription => _pictureDescription;
  double get maxWidth => _maxWidth;
  double get maxHeight => _maxHeight;
  int get quality => _quality;
  bool get fromCamera => _fromCamera;

  changeSource (bool fromCamera) {
    _fromCamera = fromCamera;
    notifyListeners();
  }

  changeMaxWidth (double ctrl) {
    _maxWidth = ctrl;
    notifyListeners();
  }

  changeMaxHeight (double ctrl) {
    _maxHeight = ctrl;
    notifyListeners();
  }

  changeQuality (int ctrl) {
    _quality = ctrl;
    notifyListeners();
  }

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