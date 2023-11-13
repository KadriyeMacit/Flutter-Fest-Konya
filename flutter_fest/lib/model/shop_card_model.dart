import 'package:flutter/material.dart';

class ShopCardModel {
  final IconData icon;
  final String title;
  bool isActive = false;
  final String object;
  final bool isLocal;

  ShopCardModel(
      this.icon, this.title, this.isActive, this.object, this.isLocal);
}
