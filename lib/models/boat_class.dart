import 'package:flutter/material.dart';

class BoatModel {
  bool trigger = true;
  double visibility = 1.0;
  int seats = 1;
  String name;
  Color containerColor;
  String image;
  Color background;
  Color textTitleColor = Colors.white;
  Color textPriceColor = Colors.white;

  BoatModel(
    this.name,
    this.image,
    this.containerColor,
    this.background,
    this.textTitleColor,
    this.textPriceColor,
      this.seats
  );
}
