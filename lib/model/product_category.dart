import 'package:project/model/product.dart';
import 'package:flutter/material.dart' show IconData;

class ProductCategory {
  ProductType type;
  bool isSelected;
  IconData icon;

  ProductCategory(this.type, this.isSelected, this.icon);
}
