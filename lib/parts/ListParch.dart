import 'package:flutter/material.dart';

String selectedCategory = "個人住宅";
final List<Map<String, dynamic>> categories = [
  {"label": "個人住宅", "value": "個人住宅", "icon": Icons.home},
  {"label": "集合住宅", "value": "集合住宅", "icon": Icons.apartment},
  {"label": "オフィス", "value": "オフィス", "icon": Icons.business},
  {"label": "病院", "value": "病院", "icon": Icons.local_hospital},
  {"label": "図書館", "value": "図書館", "icon": Icons.menu_book},
  {"label": "学校", "value": "学校", "icon": Icons.school},
  {"label": "バー", "value": "バー", "icon": Icons.local_bar},
  {"label": "クラブ", "value": "クラブ", "icon": Icons.nightlife},
  {"label": "カフェ", "value": "カフェ", "icon": Icons.local_cafe},
  {"label": "レストラン", "value": "レストラン", "icon": Icons.restaurant},
  {"label": "ホテル", "value": "ホテル", "icon": Icons.hotel},
  {"label": "倉庫", "value": "倉庫", "icon": Icons.warehouse},
  {"label": "その他", "value": "その他", "icon": Icons.category},
];
