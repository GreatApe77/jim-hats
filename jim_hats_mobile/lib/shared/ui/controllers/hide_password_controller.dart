// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HidePasswordController extends ChangeNotifier {
  bool hideBalance;
  HidePasswordController({
    this.hideBalance = false,
  });

  void toggle() {
    hideBalance = !hideBalance;
    notifyListeners();
  }
}
