import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/card.dart';
import 'package:rus_bur_service/models/operation.dart';
import 'package:rus_bur_service/models/part.dart';

class DiagnosticCardsNotifier with ChangeNotifier {
  List<Part> _listOfParts = [];
  List<List<DiagnosticCard>> _listsOfCards = [];
  List<List<Operation>> _listsOfOperations = [];


  List<Part> get listOfParts => _listOfParts;
  List<List<DiagnosticCard>> get listOfCards => _listsOfCards;
  List<List<Operation>> get listsOfOperations => _listsOfOperations;


  changePartsList(List<Part> newPartList) {
    _listOfParts = newPartList;
    notifyListeners();
  }

  changeOperationsList(List<List<Operation>> newOperationsList) {
    _listsOfOperations = newOperationsList;
    notifyListeners();
  }
  changeCardsLists(List<List<DiagnosticCard>> newCardsList) {
    _listsOfCards = newCardsList;
    notifyListeners();
  }

  changeCard(int partIndex, int cardIndex, DiagnosticCard newCard) {
    _listsOfCards[partIndex][cardIndex] = newCard;
    notifyListeners();
  }

  addCardList() {
    _listsOfCards.add(<DiagnosticCard>[]);
    notifyListeners();
  }

  deleteCardList(int partIndex) {
    _listsOfCards.removeAt(partIndex);
    notifyListeners();
  }

  addCard(DiagnosticCard card) {
    _listsOfCards.last.add(card);
    notifyListeners();
  }

  deleteCard(int partIndex, int cardIndex) {
    _listsOfCards[partIndex].removeAt(cardIndex);
    notifyListeners();
  }
}