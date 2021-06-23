import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelHud extends ChangeNotifier{
  bool isLoading=false;
  bool isChanging(bool value){
    isLoading=value;
    notifyListeners();
  }
}