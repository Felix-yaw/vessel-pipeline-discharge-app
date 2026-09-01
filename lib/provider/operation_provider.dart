import 'package:flutter/material.dart';

class OperationProvider extends ChangeNotifier {
  int  _selectedOperationIndex  = 0;


  int get selectedOperationIndex => _selectedOperationIndex;

  void setSelectedOperationIndex(int index){
    _selectedOperationIndex = index;
    notifyListeners();
  }



}
