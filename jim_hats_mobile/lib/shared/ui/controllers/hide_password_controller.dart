// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HidePasswordController extends ChangeNotifier {
  bool isHidden;
  HidePasswordController({
    this.isHidden = true,
  });

  void toggle() {
    isHidden = !isHidden;
    notifyListeners();
  }
}
