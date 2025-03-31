import 'package:flutter/material.dart';

import '../../parts/SideManu.dart';

class StockStatusPage extends StatefulWidget {
  const StockStatusPage({super.key});

  @override
  State<StockStatusPage> createState() => _StockStatusPageState();
}

class _StockStatusPageState extends State<StockStatusPage> {
  final List<Map<String, dynamic>> stockData = [
    {"item": "CCU-952D", "quantity": 12, "カテゴリ": "ダウンライト", "ブランド": "ModuleX", "制御方式": "DALI2", "屋内/屋外": "屋内", "光源": "4.5~10W", "レンズ交換可否": "可能", "その他": "防水機能", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/CCU-952D/image.jpg", "description": "ModuleX100 シリーズの CCU-952D。COB 光源、2400K〜4000K、Medium/Narrow/Wide の配光オプション付き。" },
    {"item": "CCU-952H3", "quantity": 12, "カテゴリ": "スポットライト", "ブランド": "ModuleX", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "10~15W", "レンズ交換可否": "不可能", "その他": "高効率", "location": "品証", "imageUrl": "https://www.modulex.jp/products/CCU-952H3/image.jpg", "description": "ModuleX100 シリーズの CCU-952H3。PWM/位相制御対応、多彩な配光選択肢付き。" },
    {"item": "CCU-MODP9351D", "quantity": 10, "カテゴリ": "ダウンライト", "ブランド": "ModuleX", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "10~15W", "レンズ交換可否": "可能", "その他": "グレアコントロール", "location": "工場", "imageUrl": "https://www.modulex.jp/products/CCU-MODP9351D/image.jpg", "description": "ModuleX100CCU-MODP9351D COB 位相制御対応/PWM制御対応 配光：Medium.Wide グレアコントロール：white/matt black/chrome" },
    {"item": "MMP-060A/10A", "quantity": 8, "カテゴリ": "ダウンライト", "ブランド": "ModuleX60", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "4.5~10W", "レンズ交換可否": "可能", "その他": "フレームレス", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MMP-060A-10A/image.jpg", "description": "MMP-060A/10A COB DALI制御対応 配光：Medium.Narrow グレアコントロール：white/matt black/chrome" },
    {"item": "MMP-060D/1H", "quantity": 9, "カテゴリ": "ダウンライト", "ブランド": "ModuleX60", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "10~15W", "レンズ交換可否": "可能", "その他": "調光対応", "location": "品証", "imageUrl": "https://www.modulex.jp/products/MMP-060D-1H/image.jpg", "description": "MMP-060D/1H COB 位相制御対応/PWM制御対応/DALI制御 2400K~4000K 配光：Medium.Narrow" },
    {"item": "MMP-060S/1H", "quantity": 7, "カテゴリ": "ダウンライト", "ブランド": "ModuleX60", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "4.5~10W", "レンズ交換可否": "不可能", "その他": "コンパクト設計", "location": "工場", "imageUrl": "https://www.modulex.jp/products/MMP-060S-1H/image.jpg", "description": "MMP-060S/1H COB 位相制御対応 配光：Medium.Narrow カラー：white/silver/matt black" },
    {"item": "MMP-060F/10A", "quantity": 5, "カテゴリ": "ダウンライト", "ブランド": "ModuleX60", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "15~20W", "レンズ交換可否": "可能", "その他": "フレームレス", "location": "工場", "imageUrl": "https://www.modulex.jp/products/MMP-060F-10A/image.jpg", "description": "MMP-060F/10A COB 配光：Flood.Medium.Wide グレアコントロール：white/matt black/chrome" },
    {"item": "MMP-060S/1H/FC", "quantity": 4, "カテゴリ": "ダウンライト", "ブランド": "ModuleX60", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "4.5~10W", "レンズ交換可否": "可能", "その他": "調光対応", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MMP-060S-1H/image.jpg", "description": "MMP-060S/1H/FC COB 配光：Medium.Narrow カラー：white/silver/matt black" },
    {"item": "MMP-060D/3H", "quantity": 6, "カテゴリ": "ダウンライト", "ブランド": "ModuleX60", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "15~20W", "レンズ交換可否": "不可能", "その他": "調光対応", "location": "品証", "imageUrl": "https://www.modulex.jp/products/MMP-060D-3H/image.jpg", "description": "MMP-060D/3H COB 配光：Medium.Narrow カラー：white/silver/matt black" },
    {"item": "MMP-060D/F", "quantity": 3, "カテゴリ": "ダウンライト", "ブランド": "ModuleX60", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "21~30W", "レンズ交換可否": "可能", "その他": "フレームレス", "location": "工場", "imageUrl": "https://www.modulex.jp/products/MMP-060D-F/image.jpg", "description": "MMP-060D/F COB 配光：Flood.Medium.Wide グレアコントロール：white/matt black/chrome" },
    {"item": "MMP-060KH", "quantity": 2, "カテゴリ": "ダウンライト", "ブランド": "ModuleX60", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "15~20W", "レンズ交換可否": "可能", "その他": "防水仕様", "location": "品証", "imageUrl": "https://www.modulex.jp/products/MMP-060KH/image.jpg", "description": "MMP-060KH COB 配光：Medium.Wide カラー：white/matt black" },
    {"item": "MOD-080F", "quantity": 10, "カテゴリ": "モジュール", "ブランド": "MOD's", "制御方式": "なし", "屋内/屋外": "屋外", "光源": "LED Lamp", "レンズ交換可否": "不明", "その他": "重耐塩仕様/標準仕様", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MOD-080F/image.jpg", "description": "MOD-080F LED Lamp 重耐塩仕様/ 標準仕様 カラー：matt black" },
    {"item": "MOD-080S", "quantity": 10, "カテゴリ": "モジュール", "ブランド": "MOD's", "制御方式": "なし", "屋内/屋外": "屋外", "光源": "LED Lamp", "レンズ交換可否": "不明", "その他": "重耐塩仕様/標準仕様", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MOD-080S/image.jpg", "description": "MOD-080S LED Lamp 重耐塩仕様/ 標準仕様 カラー：matt black" },
    {"item": "MOD-300BF", "quantity": 8, "カテゴリ": "ダウンライト", "ブランド": "MOD's", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "2700K~4000K 配光：M.N", "location": "工場", "imageUrl": "https://www.modulex.jp/products/MOD-300BF/image.jpg", "description": "MOD-300BF COB PWM制御対応 2700K~4000K 配光：M.N カラー：white/silver/matt black" },
    {"item": "MOD-300BS", "quantity": 8, "カテゴリ": "ダウンライト", "ブランド": "MOD's", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "2700K~4000K 配光：M.N", "location": "工場", "imageUrl": "https://www.modulex.jp/products/MOD-300BS/image.jpg", "description": "MOD-300BS COB PWM制御対応 2700K~4000K 配光：M.N カラー：white/silver/matt black" },
    {"item": "MOD-P050DR/EZ", "quantity": 6, "カテゴリ": "スポットライト", "ブランド": "MOD's", "制御方式": "位相制御", "屋内/屋外": "屋内", "光源": "Halogen", "レンズ交換可否": "可能", "その他": "3200K 配光：N.M.W", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MOD-P050DR-EZ/image.jpg", "description": "MOD-P050DR/EZ Halogen 位相制御対応 3200K 配光：N.M.W グレアコントロール：white/natural/black baffle" },
    {"item": "MOD-P1315DR", "quantity": 6, "カテゴリ": "スポットライト", "ブランド": "MOD's", "制御方式": "位相制御", "屋内/屋外": "屋内", "光源": "Halogen", "レンズ交換可否": "可能", "その他": "3200K 配光：N.M.W", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MOD-P1315DR/image.jpg", "description": "MOD-P1315DR Halogen 位相制御対応 3200K 配光：N.M.W グレアコントロール：white/natural/black baffle" },
    {"item": "MOD-P1350D/E11", "quantity": 6, "カテゴリ": "スポットライト", "ブランド": "MOD's", "制御方式": "位相制御", "屋内/屋外": "屋内", "光源": "Mavros®-Eoo", "レンズ交換可否": "可能", "その他": "2700K/4000K 配光：M.N.W", "location": "品証", "imageUrl": "https://www.modulex.jp/products/MOD-P1350D-E11/image.jpg", "description": "MOD-P1350D/E11 Mavros-Eoo 位相制御対応 配光：Medium/Narrow/Wide" },
    {"item": "MOD-P1352DR", "quantity": 5, "カテゴリ": "スポットライト", "ブランド": "MOD's", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "調光対応 2400K~4000K 配光：M.N.SP.W", "location": "品証", "imageUrl": "https://www.modulex.jp/products/MOD-P1352DR/image.jpg", "description": "MOD-P1352DR COB 位相制御対応/PWM/DALI対応 配光：M.N.SP.W" },
    {"item": "MOP-080A/10A/S1", "quantity": 4, "カテゴリ": "ダウンライト", "ブランド": "MOD's", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "2700K~5000K 配光：M.N", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MOP-080A-10A-S1/image.jpg", "description": "MOP-080A/10A/S1 COB DALI制御対応 配光：M.N グレアコントロール：white/matt black" },
    {"item": "MGP-F06F/FLE", "quantity": 5, "カテゴリ": "グリッド", "ブランド": "GRID Fine liner", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "3500K 配光：F.S グレア：white/black baffle", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MGP-F06F-FLE/image.jpg", "description": "MGP-F06F/FLE COB PWM制御対応 3500K 配光：F.S グレアコントロール：white/black baffle カラー：フレームレス" },
    {"item": "MGP-F06F/FLS", "quantity": 5, "カテゴリ": "グリッド", "ブランド": "GRID Fine liner", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "3500K 配光：F.S グレア：white/black baffle", "location": "工場", "imageUrl": "https://www.modulex.jp/products/MGP-F06F-FLS/image.jpg", "description": "MGP-F06F/FLS COB PWM制御対応 3500K 配光：F.S グレアコントロール：white/black baffle カラー：フレームレス" },
    {"item": "MGP-F06F/P", "quantity": 4, "カテゴリ": "グリッド", "ブランド": "GRID Fine liner", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "3500K 配光：F グレア：white/black baffle", "location": "品証", "imageUrl": "https://www.modulex.jp/products/MGP-F06F-P/image.jpg", "description": "MGP-F06F/P COB PWM制御対応 3500K 配光：F グレアコントロール：white/black baffle カラー：white/matt black" },
    {"item": "MGP-F06W/FJ", "quantity": 4, "カテゴリ": "グリッド", "ブランド": "GRID Fine liner", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "3500K 配光：WALL グレア：black baffle", "location": "工場", "imageUrl": "https://www.modulex.jp/products/MGP-F06W-FJ/image.jpg", "description": "MGP-F06W/FJ COB PWM制御対応 3500K 配光：WALL グレアコントロール：black baffle カラー：フレームレス" },
    {"item": "MGP-F12F/FL", "quantity": 3, "カテゴリ": "グリッド", "ブランド": "GRID Fine liner", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "3500K 配光：F.S グレア：white/black baffle", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MGP-F12F-FL/image.jpg", "description": "MGP-F12F/FL COB PWM制御対応 3500K 配光：F.S グレアコントロール：white/black baffle カラー：フレームレス" },
    {"item": "MGP-F12W/FLS", "quantity": 3, "カテゴリ": "グリッド", "ブランド": "GRID Fine liner", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "3500K 配光：WALL グレア：black baffle", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MGP-F12W-FLS/image.jpg", "description": "MGP-F12W/FLS COB PWM制御対応 3500K 配光：WALL グレアコントロール：black baffle カラー：フレームレス" },
    {"item": "MGP-Q6MF/SC", "quantity": 2, "カテゴリ": "グリッド", "ブランド": "GRID Quadrates", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "不明", "その他": "3500K/3000K/2700K 配光：W グレア：white/natural/black baffle", "location": "品証", "imageUrl": "https://www.modulex.jp/products/MGP-Q6MF-SC/image.jpg", "description": "MGP-Q6MF/SC 廃番 COB PWM制御対応 配光：W カラー：システム天井用" },
    {"item": "MGP-Q6SF/BC", "quantity": 2, "カテゴリ": "グリッド", "ブランド": "GRID Quadrates", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "不明", "その他": "3500K/3000K/2700K 配光：F グレア：white/matt black/chrome", "location": "工場", "imageUrl": "https://www.modulex.jp/products/MGP-Q6SF-BC/image.jpg", "description": "MGP-Q6SF/BC 廃番 COB PWM制御対応 配光：F カラー：ボード天井用" },
    {"item": "MMP-060A/1/SP", "quantity": 5, "カテゴリ": "グリッド", "ブランド": "GRID", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "2400K〜4000K 配光：Medium.Narrow", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MMP-060A-1-SP/image.jpg", "description": "MMP-060A/1/SP COB 位相制御/PWM 2400K〜4000K 配光：Medium.Narrow カラー：white/matt black" },
    {"item": "MMP-060A/1/SP/POA", "quantity": 4, "カテゴリ": "グリッド", "ブランド": "GRID", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "2700K〜4000K 配光：Medium.Narrow", "location": "工場", "imageUrl": "https://www.modulex.jp/products/MMP-060A-1-SP-POA/image.jpg", "description": "MMP-060A/1/SP/POA COB DALI制御対応 配光：Medium.Narrow" },
    {"item": "MMP-060A/2/SP", "quantity": 6, "カテゴリ": "グリッド", "ブランド": "GRID", "制御方式": "PWM", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "2400K〜4000K 配光：Medium.Narrow", "location": "品証", "imageUrl": "https://www.modulex.jp/products/MMP-060A-2-SP/image.jpg", "description": "MMP-060A/2/SP COB 位相制御/PWM 2400K〜4000K 配光：Medium.Narrow カラー：white/matt black" },
    {"item": "MMP-060S/1H/M/ML", "quantity": 3, "カテゴリ": "ダウンライト", "ブランド": "ModuleX LINEAR", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "2700K〜4000K 配光：Medium.Narrow", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MMP-060S-1H-M-ML/image.jpg", "description": "MMP-060S/1H/M/ML COB DALI制御対応 配光：Medium.Narrow カラー：matt black" },
    {"item": "MMP-060S/3H/M/ML", "quantity": 3, "カテゴリ": "ダウンライト", "ブランド": "ModuleX LINEAR", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "2700K〜4000K 配光：Medium.Narrow", "location": "工場", "imageUrl": "https://www.modulex.jp/products/MMP-060S-3H-M-ML/image.jpg", "description": "MMP-060S/3H/M/ML COB DALI制御対応 配光：Medium.Narrow カラー：matt black" },
    {"item": "MMP-060S/F/ML", "quantity": 2, "カテゴリ": "ダウンライト", "ブランド": "ModuleX LINEAR", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "2700K〜4000K 配光：Flood.Medium.Wide", "location": "品証", "imageUrl": "https://www.modulex.jp/products/MMP-060S-F-ML/image.jpg", "description": "MMP-060S/F/ML COB DALI制御対応 配光：Flood.Medium.Wide カラー：matt black" },
    {"item": "MMP-080S/1H/M/LD", "quantity": 2, "カテゴリ": "ダウンライト", "ブランド": "GRID TRIMLESS", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "2700K〜4000K 配光：Medium.Narrow", "location": "恵比寿本社", "imageUrl": "https://www.modulex.jp/products/MMP-080S-1H-M-LD/image.jpg", "description": "MMP-080S/1H/M/LD COB DALI制御対応 配光：Medium.Narrow" },
    {"item": "MMP-080S/3H/M/ML", "quantity": 1, "カテゴリ": "ダウンライト", "ブランド": "ModuleX LINEAR", "制御方式": "DALI", "屋内/屋外": "屋内", "光源": "COB", "レンズ交換可否": "可能", "その他": "2700K〜4000K 配光：Medium.Narrow", "location": "工場", "imageUrl": "https://www.modulex.jp/products/MMP-080S-3H-M-ML/image.jpg", "description": "MMP-080S/3H/M/ML COB DALI制御対応 配光：Medium.Narrow カラー：matt black" },
    {"item": "MCL-BCI/01", "quantity": 0, "カテゴリ": "バンブー", "ブランド": "BAMBOO", "制御方式": "-", "屋内/屋外": "屋内", "光源": "-", "レンズ交換可否": "-", "その他": "廃番", "location": "恵比寿本社", "imageUrl": "", "description": "MCL-BCI/01 廃番"},
    {"item": "MCL-BQI/01", "quantity": 0, "カテゴリ": "バンブー", "ブランド": "BAMBOO", "制御方式": "-", "屋内/屋外": "屋内", "光源": "-", "レンズ交換可否": "-", "その他": "廃番", "location": "恵比寿本社", "imageUrl": "", "description": "MCL-BQI/01 廃番"},
    {"item": "MCL-SCI/01", "quantity": 1, "カテゴリ": "スチール", "ブランド": "STEEL", "制御方式": "-", "屋内/屋外": "屋内", "光源": "-", "レンズ交換可否": "-", "その他": "", "location": "工場", "imageUrl": "", "description": "MCL-SCI/01 スチール製"},
    {"item": "MCL-SQI/01", "quantity": 1, "カテゴリ": "スチール", "ブランド": "STEEL", "制御方式": "-", "屋内/屋外": "屋内", "光源": "-", "レンズ交換可否": "-", "その他": "", "location": "工場", "imageUrl": "", "description": "MCL-SQI/01 スチール製"},
    {"item": "MCL-STI", "quantity": 1, "カテゴリ": "スタンド", "ブランド": "STAND", "制御方式": "-", "屋内/屋外": "屋内", "光源": "-", "レンズ交換可否": "-", "その他": "", "location": "品証", "imageUrl": "", "description": "MCL-STI スタンド型"},

  ];

  Map<String, String> selectedFilters = {
    'location': 'すべて',
    'カテゴリ': 'すべて',
    'ブランド': 'すべて',
    '制御方式': 'すべて',
    '屋内/屋外': 'すべて',
    '光源': 'すべて',
    'レンズ交換可否': 'すべて',
    'その他': 'すべて',
  };

  Map<String, List<String>> filterOptions = {
    '現在在庫': ['すべて', '恵比寿本社', '工場', '品証'],
    'カテゴリ': ['すべて', 'ダウンライト', 'スポットライト', 'アウトドア', 'グリッド', 'マウンティング', 'パーマネントコレクション', 'コントロールギア', 'ライティングツール'],
    'ブランド': ['すべて', 'ModuleX', 'ModuleX MOUNTINGS', 'ModuleX CONTROLS', 'ModuleX MOTIF'],
    '制御方式': ['すべて', 'PWM', '位相制御', 'DALI', 'DALI2'],
    '屋内/屋外': ['すべて', '屋内', '屋外'],
    '光源': ['すべて', '4.5~10W', '10~15W', '15~20W', '21~30W', '31~40W', '41~50W', '61~70W', 'ハロゲン'],
    '光色': ['すべて', '2000K', '2500K', '3000K', '3500K', '4000K', '4500K', '5000K', '5500K', '6000K'],
    'レンズ交換可否': ['すべて', '可能', '不可能'],
    'その他': ['すべて', '防水機能', '高効率', 'コンパクト設計']
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData = stockData.where((item) {
      for (var key in selectedFilters.keys) {
        if (selectedFilters[key] != 'すべて') {
          if ((item[key] ?? '') != selectedFilters[key]) {
            return false;
          }
        }
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          AppBarMenu(parentContext: context),
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.asset(
              "poto/StockStatusPage/StockStatusImage.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: const Color(0xff013B5E), // 🔹 배경 추가
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            width: double.infinity,
            height: 60,
            child: Row(
              children: [
                const Text("詳細検索", style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(width: 10),
                Container(width: 1,height: double.infinity,color: Colors.white,),
                const SizedBox(width: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "検索結果 ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      TextSpan(
                        text: "${filteredData.length}",
                        style: TextStyle(color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: "個",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 40),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    if (selectedFilters.values.any((v) => v != 'すべて'))
                      ActionChip(
                        label: const Text(
                          'クリア',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold, // 텍스트 굵게
                            fontSize: 13
                          ),
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1), // 외곽선 굵기 3
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedFilters.updateAll((key, value) => 'すべて');
                          });
                        },
                      ),
                    ...selectedFilters.entries.where((e) => e.value != 'すべて').map((entry) {
                      return Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilters[entry.key] = 'すべて';
                            });
                          },
                          child: Text(
                            // '${entry.key}:'
                            ' ${entry.value}   X',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline, // 탭 가능한 느낌
                            ),
                          ),
                        ),
                      );
                    }).toList(),

                  ],
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 220,
                color: Colors.grey[100],
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: filterOptions.keys.map((key) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text("$key", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ...filterOptions[key]!.map((value) => ListTile(
                          leading: selectedFilters[key] == value
                              ? const Icon(Icons.radio_button_checked, color: Colors.blue)
                              : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
                          title: Text(
                            value,
                            style: TextStyle(
                              fontWeight: selectedFilters[key] == value ? FontWeight.bold : FontWeight.normal,
                              color: selectedFilters[key] == value ? Colors.blue[900] : Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          onTap: () {
                            setState(() {
                              selectedFilters[key] = value;
                            });
                          },
                        ))
                      ],
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      final item = filteredData[index];
                      return Card(
                        color: const Color(0xcbfafafa),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item['imageUrl'],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) => Center(child: Image.asset("poto/logo3.png")),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(item['item'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text("数量: ${item['quantity']}", style: const TextStyle(fontSize: 12)),
                              Text("場所: ${item['location'] ?? '-'}", style: const TextStyle(fontSize: 12)),
                              const SizedBox(height: 4),
                              Text(item['description'], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}