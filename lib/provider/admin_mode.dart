import 'package:flutter/material.dart';
import "package:provider/provider.dart";
class AdminMode extends ChangeNotifier{
  bool isAdmin=false;
  bool changingAdmin(bool value){
    isAdmin=value;
    print (isAdmin);
    notifyListeners();
  }
}