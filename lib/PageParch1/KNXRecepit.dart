// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
//
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:html';
//
// import 'package:syncfusion_flutter_xlsio/xlsio.dart'
//     hide Column
//     hide Row
//     hide Border;
//
// import 'List/Power.dart';
// import 'List/IP.dart';
// import 'List/Module.dart';
// import 'List/Switch.dart';
//
// class TestWidget extends StatefulWidget {
//   const TestWidget({Key? key}) : super(key: key);
//
//   @override
//   State<TestWidget> createState() => _TestWidgetState();
// }
//
// class _TestWidgetState extends State<TestWidget> {
//   final List<String> items = List.generate(50, (index) => index.toString());
//
//   ///Power
//   String? Power_ModuleSelect;
//   String? Power_CountSelect;
//
//   ///DC24
//   String? DC24_ModuleSelect;
//   String? DC24_CountSelect;
//
//   ///IP
//   String? IP_ModuleSelect;
//   String? IP_CountSelect;
//
//   ///IPR
//   String? IPR_ModuleSelect;
//   String? IPR_CountSelect;
//
//   ///ModuleS1
//   String? ModuleS1_ModuleSelect;
//   String? ModuleS1_CountSelect;
//
//   ///ModuleS2
//   String? ModuleS2_ModuleSelect;
//   String? ModuleS2_CountSelect;
//
//   ///ModuleS3
//   String? ModuleS3_ModuleSelect;
//   String? ModuleS3_CountSelect;
//
//   ///ModuleS4
//   String? ModuleS4_ModuleSelect;
//   String? ModuleS4_CountSelect;
//
//   ///ModuleS5
//   String? ModuleS5_ModuleSelect;
//   String? ModuleS5_CountSelect;
//
//   ///ModuleS6
//   String? ModuleS6_ModuleSelect;
//   String? ModuleS6_CountSelect;
//
//   ///ModuleS7
//   String? ModuleS7_ModuleSelect;
//   String? ModuleS7_CountSelect;
//
//   ///ModuleS8
//   String? ModuleS8_ModuleSelect;
//   String? ModuleS8_CountSelect;
//
//   ///ModuleS9
//   String? ModuleS9_ModuleSelect;
//   String? ModuleS9_CountSelect;
//
//   ///ModuleS10
//   String? ModuleS10_ModuleSelect;
//   String? ModuleS10_CountSelect;
//
//   ///Switch1
//   String? Switch1_ModuleSelect;
//   String? Switch1_CountSelect;
//
//   ///Switch2
//   String? Switch2_ModuleSelect;
//   String? Switch2_CountSelect;
//
//   ///Switch3
//   String? Switch3_ModuleSelect;
//   String? Switch3_CountSelect;
//
//   ///Switch4
//   String? Switch4_ModuleSelect;
//   String? Switch4_CountSelect;
//
//   ///Switch5
//   String? Switch5_ModuleSelect;
//   String? Switch5_CountSelect;
//
//   ///Switch5
//   String? Switch6_ModuleSelect;
//   String? Switch6_CountSelect;
//
//   String Day = "2022/02/02";
//   String Name_Excel = "XXXXXXX";
//   double ID_Excel = 000000;
//
//   int modulesInt = 0;
//   List<bool> modules = [false, false, false, false, false, false, false, false];
//   int SwitchsInt = 0;
//   List<bool> Switchs = [false, false, false];
//
//   Future<void> _createExcel() async {
// // Create a new Excel Document.
//     final Workbook workbook = Workbook();
//
// // Accessing worksheet via index.
//     final Worksheet sheet = workbook.worksheets[0];
//     sheet.showGridlines = false;
//
//     int Power_ModuleLine = 0;
//
//     // Enable calculation for worksheet.
//     sheet.enableSheetCalculations();
//
//     ///Set data in the worksheet.
//     sheet.getRangeByName('A1').columnWidth = 4.82;
//     sheet.getRangeByName('B1:C1').columnWidth = 25.00;
//     sheet.getRangeByName('D1').columnWidth = 13.20;
//     sheet.getRangeByName('E1').columnWidth = 8.50;
//     sheet.getRangeByName('F1').columnWidth = 10.82;
//     sheet.getRangeByName('G1').columnWidth = 10.82;
//     sheet.getRangeByName('H1').columnWidth = 4.46;
//
//     ///Total
//     final Range range7 = sheet.getRangeByName('E15');
//     range7.setText('TOTAL');
//     range7.cellStyle.fontSize = 8;
//     sheet.getRangeByName('E15:G15').merge();
//     sheet.getRangeByName('E15:G15').cellStyle.hAlign = HAlignType.right;
//
//     final Range range8 = sheet.getRangeByName('E16');
//     range8.setFormula('=SUM(G10:G14)');
//     sheet.getRangeByName('E16:G17').merge();
//     range8.numberFormat = '\￥###,###,###';
//     range8.cellStyle.fontSize = 24;
//     range8.cellStyle.hAlign = HAlignType.right;
//     range8.cellStyle.bold = true;
//
//     ///color
//
//     sheet.getRangeByName('A1:H1').cellStyle.backColor = '#333F4F';
//     sheet.getRangeByName('A1:H1').merge();
//     sheet.getRangeByName('A8').rowHeight = 4;
//
//     ///color
//
//     final Range MainName = sheet.getRangeByIndex(4, 2, 6, 4);
//     final Range MainServe = sheet.getRangeByIndex(7, 2);
//     final Range MainDay = sheet.getRangeByName('F6:G6');
//     final Range MainID = sheet.getRangeByName('F7:G7');
//
//     //Name
//     MainName.setText(Name_Excel);
//     MainName.merge();
//     MainName.cellStyle.bold = true;
//     MainName.cellStyle.fontSize = 25;
//     MainName.cellStyle.hAlign = HAlignType.left;
//     MainName.cellStyle.vAlign = VAlignType.center;
//
//     //Serve
//     MainServe.setText('KNXシステム　積算表');
//     MainServe.cellStyle.fontSize = 9;
//     MainServe.cellStyle.bold = true;
//
//     //ID
//     MainID.setNumber(ID_Excel);
//     sheet.getRangeByName('F7:G7').merge();
//     MainID.cellStyle.fontSize = 9;
//     MainID.cellStyle.hAlign = HAlignType.right;
//
//     //Day
//     MainDay.setDateTime(DateTime(2020, 12, 12));
//     MainDay.setFormula('=TODAY()');
//     MainDay.merge();
//     // sheet.getRangeByName('F7').numberFormat =
//     // '[\$-x-sysdate]dddd, mmmm dd, yyyy';
//     MainDay.cellStyle.fontSize = 9;
//     MainDay.cellStyle.hAlign = HAlignType.right;
//
//     ///Color
//
//     sheet.getRangeByName('B8:G8').cellStyle.backColor = '#333F4F';
//     sheet.getRangeByName('B8:G8').merge();
//
//     ///Color
//
//     ///List
//     int MainList_Modules = 9;
//     sheet.getRangeByIndex(MainList_Modules, 2).setText('機器種別');
//     sheet.getRangeByIndex(MainList_Modules, 5).setText('モジュール数量');
//     sheet.getRangeByIndex(MainList_Modules, 6).setText('原価');
//     sheet.getRangeByIndex(MainList_Modules, 7).setText('営業原価(60%)');
//     sheet.getRangeByIndex(MainList_Modules, 3, MainList_Modules, 4).merge();
//     sheet
//         .getRangeByName('D$MainList_Modules:G$MainList_Modules')
//         .cellStyle
//         .hAlign = HAlignType.right;
//     sheet
//         .getRangeByName('B$MainList_Modules:G$MainList_Modules')
//         .cellStyle
//         .fontSize = 8;
//     sheet
//         .getRangeByName('B$MainList_Modules:G$MainList_Modules')
//         .cellStyle
//         .bold = true;
//
//     final Range Main1 = sheet.getRangeByIndex(10, 2);
//     final Range Main2 = sheet.getRangeByIndex(11, 2);
//     final Range Main3 = sheet.getRangeByIndex(12, 2);
//     final Range Main4 = sheet.getRangeByIndex(13, 2);
//     final Range Main5 = sheet.getRangeByIndex(14, 2);
//
//     final Range Main1_th = sheet.getRangeByIndex(10, 5);
//     final Range Main2_th = sheet.getRangeByIndex(11, 5);
//     final Range Main3_th = sheet.getRangeByIndex(12, 5);
//     final Range Main4_th = sheet.getRangeByIndex(13, 5);
//     final Range Main5_th = sheet.getRangeByIndex(14, 5);
//
//     final Range Main1_sum = sheet.getRangeByIndex(10, 6);
//     final Range Main2_sum = sheet.getRangeByIndex(11, 6);
//     final Range Main3_sum = sheet.getRangeByIndex(12, 6);
//     final Range Main4_sum = sheet.getRangeByIndex(13, 6);
//     final Range Main5_sum = sheet.getRangeByIndex(14, 6);
//
//     final Range Main1_sum60 = sheet.getRangeByIndex(10, 7);
//     final Range Main2_sum60 = sheet.getRangeByIndex(11, 7);
//     final Range Main3_sum60 = sheet.getRangeByIndex(12, 7);
//     final Range Main4_sum60 = sheet.getRangeByIndex(13, 7);
//     final Range Main5_sum60 = sheet.getRangeByIndex(14, 7);
//
//     //Main1
//     Main1.setText('KNX制御盤一式');
//     Main1.cellStyle.fontSize = 8;
//     Main1_th.setNumber(Power_ModuleLine as double?);
//     Main1_th.cellStyle.fontSize = 8;
//     Main1_sum.setFormula('=SUM(G20:G${Line1_Total - 1})');
//     Main1_sum.cellStyle.fontSize = 8;
//     Main1_sum.numberFormat = '\￥###,###,###';
//     Main1_sum60.setFormula('=F10*1.6');
//     Main1_sum60.cellStyle.fontSize = 8;
//     Main1_sum60.numberFormat = '\￥###,###,###';
//
//     //Main2
//     Main2.setText('KNX操作機器一式');
//     Main2.cellStyle.fontSize = 8;
//     Main2_th.setNumber(Power_ModuleLine as double?);
//     Main2_th.cellStyle.fontSize = 8;
//     Main2_sum.setFormula('=SUM(G${Line1_Total + 3}:G${Line2_Total + 2 + Line1_Total})');
//     Main2_sum.cellStyle.fontSize = 8;
//     Main2_sum.numberFormat = '\￥###,###,###';
//     Main2_sum60.setFormula('=F11*1.6');
//     Main2_sum60.cellStyle.fontSize = 8;
//     Main2_sum60.numberFormat = '\￥###,###,###';
//
//     //Main3
//     Main3.setText('制御盤内組込費');
//     Main3.cellStyle.fontSize = 8;
//     Main3_th.setNumber(Power_ModuleLine as double?);
//     Main3_th.cellStyle.fontSize = 8;
//     Main3_sum.setFormula('=SUM(G${Line2_Total + 6 + Line1_Total}:G${Line3_Total + 5 + Line1_Total + Line2_Total})');
//     Main3_sum.cellStyle.fontSize = 8;
//     Main3_sum.numberFormat = '\￥###,###,###';
//     Main3_sum60.setFormula('=F12*1.6');
//     Main3_sum60.cellStyle.fontSize = 8;
//     Main3_sum60.numberFormat = '\￥###,###,###';
//
//     //Main4
//     Main4.setText("システム設定調整費");
//     Main4.cellStyle.fontSize = 8;
//     Main4_th.setNumber(Power_ModuleLine as double?);
//     Main4_th.cellStyle.fontSize = 8;
//     Main4_sum.setFormula('=SUM(G${Line3_Total + 9 + Line1_Total + Line2_Total}:G${Line4_Total + 8 + Line1_Total + Line2_Total + Line3_Total})');
//     Main4_sum.cellStyle.fontSize = 8;
//     Main4_sum.numberFormat = '\￥###,###,###';
//     Main4_sum60.setFormula('=F13*1.6');
//     Main4_sum60.cellStyle.fontSize = 8;
//     Main4_sum60.numberFormat = '\￥###,###,###';
//
//     //Main5
//     Main5.setText("運送費");
//     Main5.cellStyle.fontSize = 8;
//     Main5_th.setNumber(Power_ModuleLine as double?);
//     Main5_th.cellStyle.fontSize = 8;
//     Main5_sum.setFormula('=SUM(G${Line4_Total + 12 + Line1_Total + Line2_Total + Line3_Total}:G${Line5_Total + 11 + Line1_Total + Line2_Total + Line3_Total + Line4_Total})');
//     Main5_sum.cellStyle.fontSize = 8;
//     Main5_sum.numberFormat = '\￥###,###,###';
//     Main5_sum60.setFormula('=F14*1.6');
//     Main5_sum60.cellStyle.fontSize = 8;
//     Main5_sum60.numberFormat = '\￥###,###,###';
//
//     ///Color
//
//     final Range SystemRoomLine = sheet.getRangeByIndex(18, 2, 18, 7);
//     SystemRoomLine.cellStyle.backColor = '#333F4F';
//     SystemRoomLine.merge();
//     SystemRoomLine.rowHeight = 4;
//
//     ///Color
//
//     // final Picture picture = sheet.pictures.addBase64(3, 4, _invoicejpeg);
//     // picture.lastRow = 7;
//     // picture.lastColumn = 8;
//
//     ///Modules
//     int FirestList_Modules = 19;
//     sheet.getRangeByIndex(FirestList_Modules, 2).setText('機器種別');
//     sheet.getRangeByIndex(FirestList_Modules, 3).setText('モジュール型番');
//     sheet.getRangeByIndex(FirestList_Modules, 5).setText('数量');
//     sheet.getRangeByIndex(FirestList_Modules, 6).setText('原価');
//     sheet.getRangeByIndex(FirestList_Modules, 7).setText('小計');
//     sheet.getRangeByIndex(FirestList_Modules, 3, FirestList_Modules, 4).merge();
//     sheet
//         .getRangeByName('D$FirestList_Modules:G$FirestList_Modules')
//         .cellStyle
//         .hAlign = HAlignType.right;
//     sheet
//         .getRangeByName('B$FirestList_Modules:G$FirestList_Modules')
//         .cellStyle
//         .fontSize = 9;
//     sheet
//         .getRangeByName('B$FirestList_Modules:G$FirestList_Modules')
//         .cellStyle
//         .bold = true;
//
//     ///power
//     if (Power_ModuleSelect != null && Power_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = PowerModules.indexOf(Power_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(PowerModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(PowerCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(Power_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(PowerCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///DC24
//     if (DC24_ModuleSelect != null && DC24_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = DC24Modules.indexOf(DC24_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(DC24Modules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(DC24Code[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(DC24_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(DC24Cash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///IP
//     if (IP_ModuleSelect != null && IP_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = IPModules.indexOf(IP_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(IPModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(IPCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(IP_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(IPCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///IPR
//     if (IPR_ModuleSelect != null && IPR_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = IPModules.indexOf(IPR_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(IPModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(IPCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(IPR_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(IPCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///ModuleS1
//     if (ModuleS1_ModuleSelect != null && ModuleS1_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = MainModules.indexOf(ModuleS1_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(MainModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(MainCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(ModuleS1_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(MainCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///ModuleS2
//     if (ModuleS2_ModuleSelect != null && ModuleS2_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = MainModules.indexOf(ModuleS2_ModuleSelect!);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 2)
//           .setText('$ModuleS2_ModuleSelect');
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(MainCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(ModuleS2_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(MainCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///ModuleS3
//     if (ModuleS3_ModuleSelect != null && ModuleS3_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = MainModules.indexOf(ModuleS3_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(MainModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(MainCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(ModuleS3_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(MainCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///ModuleS4
//     if (ModuleS4_ModuleSelect != null && ModuleS4_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = MainModules.indexOf(ModuleS4_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(MainModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(MainCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(ModuleS4_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(MainCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///ModuleS5
//     if (ModuleS5_ModuleSelect != null && ModuleS5_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = MainModules.indexOf(ModuleS5_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(MainModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(MainCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(ModuleS5_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(MainCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///ModuleS6
//     if (ModuleS6_ModuleSelect != null && ModuleS6_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = MainModules.indexOf(ModuleS6_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(MainModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(MainCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(ModuleS6_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(MainCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///ModuleS7
//     if (ModuleS7_ModuleSelect != null && ModuleS7_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = MainModules.indexOf(ModuleS7_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(MainModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(MainCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(ModuleS7_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(MainCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///ModuleS8
//     if (ModuleS8_ModuleSelect != null && ModuleS8_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = MainModules.indexOf(ModuleS8_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(MainModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(MainCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(ModuleS8_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(MainCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///ModuleS9
//     if (ModuleS9_ModuleSelect != null && ModuleS9_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = MainModules.indexOf(ModuleS9_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(MainModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(MainCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(ModuleS9_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(MainCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///ModuleS9
//     if (ModuleS10_ModuleSelect != null && ModuleS10_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = MainModules.indexOf(ModuleS10_ModuleSelect!);
//       sheet.getRangeByIndex(Power_ModuleLine19, 2).setText(MainModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(MainCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(ModuleS10_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(MainCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     int Line2List_Modules = Power_ModuleLine + 20;
//     sheet.getRangeByIndex(Line2List_Modules, 2, Line2List_Modules, 7).merge();
//     Line2List_Modules++;
//     Power_ModuleLine++;
//     sheet
//         .getRangeByIndex(Line2List_Modules, 2, Line2List_Modules, 7)
//         .cellStyle
//         .backColor = '#333F4F';
//     sheet.getRangeByIndex(Line2List_Modules, 2, Line2List_Modules, 7).merge();
//     sheet
//         .getRangeByIndex(Line2List_Modules, 2, Line2List_Modules, 7)
//         .rowHeight = 4;
//     Line2List_Modules++;
//     Power_ModuleLine++;
//     sheet.getRangeByIndex(Line2List_Modules, 2).setText('機器種別');
//     sheet.getRangeByIndex(Line2List_Modules, 3).setText('モジュール型番');
//     sheet.getRangeByIndex(Line2List_Modules, 5).setText('数量');
//     sheet.getRangeByIndex(Line2List_Modules, 6).setText('原価');
//     sheet.getRangeByIndex(Line2List_Modules, 7).setText('小計');
//     sheet.getRangeByIndex(Line2List_Modules, 3, Line2List_Modules, 4).merge();
//     sheet
//         .getRangeByName('D$Line2List_Modules:G$Line2List_Modules')
//         .cellStyle
//         .hAlign = HAlignType.right;
//     sheet
//         .getRangeByName('B$Line2List_Modules:G$Line2List_Modules')
//         .cellStyle
//         .fontSize = 9;
//     sheet
//         .getRangeByName('B$Line2List_Modules:G$Line2List_Modules')
//         .cellStyle
//         .bold = true;
//     Power_ModuleLine++;
//
//     ///Switch1
//     if (Switch1_ModuleSelect != null && Switch1_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = SwitchModules.indexOf(Switch1_ModuleSelect!);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 2)
//           .setText(SwitchModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(SwitchCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(Switch1_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(SwitchCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///Switch2
//     if (Switch2_ModuleSelect != null && Switch2_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = SwitchModules.indexOf(Switch2_ModuleSelect!);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 2)
//           .setText(SwitchModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(SwitchCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(Switch2_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(SwitchCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///Switch3
//     if (Switch3_ModuleSelect != null && Switch3_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = SwitchModules.indexOf(Switch3_ModuleSelect!);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 2)
//           .setText(SwitchModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(SwitchCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(Switch3_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(SwitchCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///Switch4
//     if (Switch4_ModuleSelect != null && Switch4_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = SwitchModules.indexOf(Switch4_ModuleSelect!);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 2)
//           .setText(SwitchModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(SwitchCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(Switch4_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(SwitchCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///Switch5
//     if (Switch5_ModuleSelect != null && Switch5_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = SwitchModules.indexOf(Switch5_ModuleSelect!);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 2)
//           .setText(SwitchModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(SwitchCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(Switch5_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(SwitchCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     ///Switch6
//     if (Switch6_ModuleSelect != null && Switch6_ModuleSelect != "なし") {
//       int Power_ModuleLine19 = Power_ModuleLine + 20;
//       int index = SwitchModules.indexOf(Switch6_ModuleSelect!);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 2)
//           .setText(SwitchModules[index]);
//       sheet.getRangeByIndex(Power_ModuleLine19, 3).setText(SwitchCode[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 5)
//           .setNumber(double.tryParse(Switch6_CountSelect!));
//       sheet.getRangeByIndex(Power_ModuleLine19, 6).setNumber(SwitchCash[index]);
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 7)
//           .setFormula('=E$Power_ModuleLine19*F$Power_ModuleLine19');
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 3, Power_ModuleLine19, 4)
//           .merge();
//       sheet
//           .getRangeByName('B$Power_ModuleLine19:G$Power_ModuleLine19')
//           .cellStyle
//           .fontSize = 9;
//       sheet
//           .getRangeByIndex(Power_ModuleLine19, 6, Power_ModuleLine19, 7)
//           .numberFormat = '\￥###,###,###';
//       Power_ModuleLine++;
//     }
//
//     int Line3List_Modules = Power_ModuleLine + 20;
//     sheet.getRangeByIndex(Line3List_Modules, 2, Line3List_Modules, 7).merge();
//     Line3List_Modules++;
//     Power_ModuleLine++;
//     sheet
//         .getRangeByIndex(Line3List_Modules, 2, Line3List_Modules, 7)
//         .cellStyle
//         .backColor = '#333F4F';
//     sheet.getRangeByIndex(Line3List_Modules, 2, Line3List_Modules, 7).merge();
//     sheet
//         .getRangeByIndex(Line3List_Modules, 2, Line3List_Modules, 7)
//         .rowHeight = 4;
//     Line3List_Modules++;
//     Power_ModuleLine++;
//     sheet.getRangeByIndex(Line3List_Modules, 2).setText('機器種別');
//     sheet.getRangeByIndex(Line3List_Modules, 3).setText('モジュール型番');
//     sheet.getRangeByIndex(Line3List_Modules, 5).setText('数量');
//     sheet.getRangeByIndex(Line3List_Modules, 6).setText('原価');
//     sheet.getRangeByIndex(Line3List_Modules, 7).setText('小計');
//     sheet.getRangeByIndex(Line3List_Modules, 3, Line3List_Modules, 4).merge();
//     sheet
//         .getRangeByName('D$Line3List_Modules:G$Line3List_Modules')
//         .cellStyle
//         .hAlign = HAlignType.right;
//     sheet
//         .getRangeByName('B$Line3List_Modules:G$Line3List_Modules')
//         .cellStyle
//         .fontSize = 9;
//     sheet
//         .getRangeByName('B$Line3List_Modules:G$Line3List_Modules')
//         .cellStyle
//         .bold = true;
//     Power_ModuleLine++;
//
//     int Line4List_Modules = Power_ModuleLine + 20;
//     sheet.getRangeByIndex(Line4List_Modules, 2, Line4List_Modules, 7).merge();
//     Line4List_Modules++;
//     Power_ModuleLine++;
//     sheet
//         .getRangeByIndex(Line4List_Modules, 2, Line4List_Modules, 7)
//         .cellStyle
//         .backColor = '#333F4F';
//     sheet.getRangeByIndex(Line4List_Modules, 2, Line4List_Modules, 7).merge();
//     sheet
//         .getRangeByIndex(Line4List_Modules, 2, Line4List_Modules, 7)
//         .rowHeight = 4;
//     Line4List_Modules++;
//     Power_ModuleLine++;
//     sheet.getRangeByIndex(Line4List_Modules, 2).setText('機器種別');
//     sheet.getRangeByIndex(Line4List_Modules, 3).setText('モジュール型番');
//     sheet.getRangeByIndex(Line4List_Modules, 5).setText('数量');
//     sheet.getRangeByIndex(Line4List_Modules, 6).setText('原価');
//     sheet.getRangeByIndex(Line4List_Modules, 7).setText('小計');
//     sheet.getRangeByIndex(Line4List_Modules, 3, Line4List_Modules, 4).merge();
//     sheet
//         .getRangeByName('D$Line4List_Modules:G$Line4List_Modules')
//         .cellStyle
//         .hAlign = HAlignType.right;
//     sheet
//         .getRangeByName('B$Line4List_Modules:G$Line4List_Modules')
//         .cellStyle
//         .fontSize = 9;
//     sheet
//         .getRangeByName('B$Line4List_Modules:G$Line4List_Modules')
//         .cellStyle
//         .bold = true;
//     Power_ModuleLine++;
//
//     int Line5List_Modules = Power_ModuleLine + 20;
//     sheet.getRangeByIndex(Line5List_Modules, 2, Line5List_Modules, 7).merge();
//     Line5List_Modules++;
//     Power_ModuleLine++;
//     sheet
//         .getRangeByIndex(Line5List_Modules, 2, Line5List_Modules, 7)
//         .cellStyle
//         .backColor = '#333F4F';
//     sheet.getRangeByIndex(Line5List_Modules, 2, Line5List_Modules, 7).merge();
//     sheet
//         .getRangeByIndex(Line5List_Modules, 2, Line5List_Modules, 7)
//         .rowHeight = 4;
//     Line5List_Modules++;
//     Power_ModuleLine++;
//     sheet.getRangeByIndex(Line5List_Modules, 2).setText('機器種別');
//     sheet.getRangeByIndex(Line5List_Modules, 3).setText('モジュール型番');
//     sheet.getRangeByIndex(Line5List_Modules, 5).setText('数量');
//     sheet.getRangeByIndex(Line5List_Modules, 6).setText('原価');
//     sheet.getRangeByIndex(Line5List_Modules, 7).setText('小計');
//     sheet.getRangeByIndex(Line5List_Modules, 3, Line5List_Modules, 4).merge();
//     sheet
//         .getRangeByName('D$Line5List_Modules:G$Line5List_Modules')
//         .cellStyle
//         .hAlign = HAlignType.right;
//     sheet
//         .getRangeByName('B$Line5List_Modules:G$Line5List_Modules')
//         .cellStyle
//         .fontSize = 9;
//     sheet
//         .getRangeByName('B$Line5List_Modules:G$Line5List_Modules')
//         .cellStyle
//         .bold = true;
//     Power_ModuleLine++;
//
//     sheet.getRangeByIndex(Power_ModuleLine + 23, 1).text =
//         'ModuleX エクスペリエンスシステム部　システムインテグレーションが課 | Baek1066@modulex.jp';
//     sheet.getRangeByIndex(Power_ModuleLine + 23, 1).cellStyle.fontSize = 8;
//     final Range range9 = sheet.getRangeByIndex(
//         Power_ModuleLine + 23, 1, Power_ModuleLine + 23, 8);
//     range9.cellStyle.backColor = '#ACB9CA';
//     range9.merge();
//     range9.cellStyle.hAlign = HAlignType.center;
//     range9.cellStyle.vAlign = VAlignType.center;
//
//     //Save and launch the excel.
//     final List<int> bytes = workbook.saveAsStream();
//     //Dispose the document.
//     workbook.dispose();
//
// //Download the output file in web.
//     AnchorElement(
//         href:
//             "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
//       ..setAttribute("download", "$Name_Excel.xlsx")
//       ..click();
//   }
//
//   @override
//   void dispose() {
//     ModuleName1.dispose();
//     super.dispose();
//   }
//
//   TextEditingController Name = TextEditingController();
//   TextEditingController ID = TextEditingController();
//   final TextEditingController ModuleName1 = TextEditingController();
//
//   int Line1_Total = 20;
//   int Line2_Total = 0;
//   int Line3_Total = 0;
//   int Line4_Total = 0;
//   int Line5_Total = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black12,
//       appBar: AppBar(
//         title: Container(height: 30, child: Image.asset('poto/logo3.png')),
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//       ),
//       body: Center(
//         child: Container(
//           width: 500,
//           child: ListView(
//             children: [
//               ///Name Line
//
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 20),
//                   Text("List Information"),
//
//                   ///Name & ID
//                   Container(
//                     width: 400,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.black54),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8),
//                       child: TextField(
//                         controller: Name,
//                         onChanged: (String value) {
//                           setState(() {
//                             Name_Excel = value;
//                           });
//                         },
//                         decoration: InputDecoration(
//                             hintText: "Name", border: InputBorder.none),
//                         style: TextStyle(fontSize: 12),
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(20),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 10),
//
//                   ///ID
//                   Container(
//                     width: 400,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: Colors.black54),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8),
//                       child: TextField(
//                         controller: ID,
//                         onChanged: (String value) {
//                           setState(() {
//                             ID_Excel = value as double;
//                           });
//                         },
//                         decoration: InputDecoration(
//                             hintText: "ID", border: InputBorder.none),
//                         style: TextStyle(fontSize: 12),
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               ///Power Line
//
//               SizedBox(height: 30),
//
//               Text("Power List"),
//               SizedBox(height: 5),
//               Row(children: [
//                 Container(
//                   width: 450,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton2<String>(
//                                 isExpanded: true,
//                                 hint: Text(
//                                   'Select Item',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       color: Theme.of(context).hintColor),
//                                 ),
//                                 items:
//                                     PowerModules.map((item) => DropdownMenuItem(
//                                         value: item,
//                                         child: Text(
//                                           item,
//                                           style: const TextStyle(fontSize: 14),
//                                         ))).toList(),
//                                 value: Power_ModuleSelect,
//                                 onChanged: (value) async {
//                                   // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                   String? ModuleSelect = Power_ModuleSelect;
//
//                                   setState(() {
//                                     Power_ModuleSelect = value!;
//                                   });
//
//                                   await Future.delayed(Duration.zero, () {
//                                     setState(() {
//                                       if (Power_ModuleSelect != null &&
//                                           Power_ModuleSelect != "なし") {
//                                         Power_CountSelect = "1";
//                                         // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                         if (ModuleSelect == null ||
//                                             ModuleSelect == "なし") {
//                                           Line1_Total += 1;
//                                         }
//                                       } else {
//                                         Power_CountSelect = "0";
//                                         // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                         if (ModuleSelect != null &&
//                                             ModuleSelect != "なし") {
//                                           Line1_Total -= 1;
//                                         }
//                                       }
//                                     });
//                                   });
//
//                                   print(
//                                       'Power_ModuleSelect: $Power_ModuleSelect');
//                                 },
//                                 buttonStyleData: ButtonStyleData(
//                                   padding: EdgeInsets.symmetric(horizontal: 16),
//                                   height: 40,
//                                   width: 280,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 dropdownStyleData: DropdownStyleData(
//                                   maxHeight: 340,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 menuItemStyleData: const MenuItemStyleData(
//                                   height: 40,
//                                 ),
//                                 dropdownSearchData: DropdownSearchData(
//                                   searchController: ModuleName1,
//                                   searchInnerWidgetHeight: 50,
//                                   searchInnerWidget: Container(
//                                     color: Colors.white,
//                                     height: 50,
//                                     padding: const EdgeInsets.only(
//                                         top: 8, bottom: 4, right: 8, left: 8),
//                                     child: TextFormField(
//                                       cursorColor: Colors.blue,
//                                       expands: true,
//                                       maxLines: null,
//                                       controller: ModuleName1,
//                                       decoration: InputDecoration(
//                                         isDense: true,
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: 10, vertical: 8),
//                                         hintText: 'Search for an item...',
//                                         hintStyle:
//                                             const TextStyle(fontSize: 12),
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8)),
//                                       ),
//                                     ),
//                                   ),
//                                   searchMatchFn: (item, searchValue) {
//                                     return item.value
//                                         .toString()
//                                         .contains(searchValue);
//                                   },
//                                 ),
//                                 onMenuStateChange: (isOpen) {
//                                   if (!isOpen) {
//                                     ModuleName1.clear();
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//
//                           SizedBox(width: 10),
//                           // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                           DropdownButtonHideUnderline(
//                             child: DropdownButton2<String>(
//                               isExpanded: true,
//                               hint: Text(
//                                 '0',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Theme.of(context).hintColor),
//                               ),
//                               items: items
//                                   .map(
//                                       (String item) => DropdownMenuItem<String>(
//                                           value: item,
//                                           child: Text(
//                                             item,
//                                             style:
//                                                 const TextStyle(fontSize: 14),
//                                           )))
//                                   .toList(),
//                               value: Power_CountSelect,
//                               onChanged: (value) {
//                                 setState(() {
//                                   Power_CountSelect = value!;
//                                 });
//                               },
//                               buttonStyleData: const ButtonStyleData(
//                                 padding: EdgeInsets.symmetric(horizontal: 16),
//                                 height: 40,
//                                 width: 80,
//                               ),
//                               menuItemStyleData: const MenuItemStyleData(
//                                 height: 40,
//                               ),
//                               dropdownStyleData: DropdownStyleData(
//                                 maxHeight: 340,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(4),
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton2<String>(
//                                 isExpanded: true,
//                                 hint: Text(
//                                   'Select Item',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       color: Theme.of(context).hintColor),
//                                 ),
//                                 items:
//                                     DC24Modules.map((item) => DropdownMenuItem(
//                                         value: item,
//                                         child: Text(
//                                           item,
//                                           style: const TextStyle(fontSize: 14),
//                                         ))).toList(),
//                                 value: DC24_ModuleSelect,
//                                 onChanged: (value) async {
//                                   // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                   String? ModuleSelect = DC24_ModuleSelect;
//
//                                   setState(() {
//                                     DC24_ModuleSelect = value!;
//                                   });
//
//                                   await Future.delayed(Duration.zero, () {
//                                     setState(() {
//                                       if (DC24_ModuleSelect != null &&
//                                           DC24_ModuleSelect != "なし") {
//                                         DC24_CountSelect = "1";
//                                         // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                         if (ModuleSelect == null ||
//                                             ModuleSelect == "なし") {
//                                           Line1_Total += 1;
//                                         }
//                                       } else {
//                                         DC24_CountSelect = "0";
//                                         // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                         if (ModuleSelect != null &&
//                                             ModuleSelect != "なし") {
//                                           Line1_Total -= 1;
//                                         }
//                                       }
//                                     });
//                                   });
//
//                                   print('Power_ModuleSelect: $ModuleSelect');
//                                 },
//                                 buttonStyleData: ButtonStyleData(
//                                   padding: EdgeInsets.symmetric(horizontal: 16),
//                                   height: 40,
//                                   width: 280,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 dropdownStyleData: DropdownStyleData(
//                                   maxHeight: 340,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 menuItemStyleData: const MenuItemStyleData(
//                                   height: 40,
//                                 ),
//                                 dropdownSearchData: DropdownSearchData(
//                                   searchController: ModuleName1,
//                                   searchInnerWidgetHeight: 50,
//                                   searchInnerWidget: Container(
//                                     color: Colors.white,
//                                     height: 50,
//                                     padding: const EdgeInsets.only(
//                                         top: 8, bottom: 4, right: 8, left: 8),
//                                     child: TextFormField(
//                                       cursorColor: Colors.blue,
//                                       expands: true,
//                                       maxLines: null,
//                                       controller: ModuleName1,
//                                       decoration: InputDecoration(
//                                         isDense: true,
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: 10, vertical: 8),
//                                         hintText: 'Search for an item...',
//                                         hintStyle:
//                                             const TextStyle(fontSize: 12),
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8)),
//                                       ),
//                                     ),
//                                   ),
//                                   searchMatchFn: (item, searchValue) {
//                                     return item.value
//                                         .toString()
//                                         .contains(searchValue);
//                                   },
//                                 ),
//                                 onMenuStateChange: (isOpen) {
//                                   if (!isOpen) {
//                                     ModuleName1.clear();
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//
//                           SizedBox(width: 10),
//                           // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                           DropdownButtonHideUnderline(
//                             child: DropdownButton2<String>(
//                               isExpanded: true,
//                               hint: Text(
//                                 '0',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Theme.of(context).hintColor),
//                               ),
//                               items: items
//                                   .map(
//                                       (String item) => DropdownMenuItem<String>(
//                                           value: item,
//                                           child: Text(
//                                             item,
//                                             style:
//                                                 const TextStyle(fontSize: 14),
//                                           )))
//                                   .toList(),
//                               value: DC24_CountSelect,
//                               onChanged: (value) {
//                                 setState(() {
//                                   DC24_CountSelect = value!;
//                                 });
//                               },
//                               buttonStyleData: const ButtonStyleData(
//                                 padding: EdgeInsets.symmetric(horizontal: 16),
//                                 height: 40,
//                                 width: 80,
//                               ),
//                               menuItemStyleData: const MenuItemStyleData(
//                                 height: 40,
//                               ),
//                               dropdownStyleData: DropdownStyleData(
//                                 maxHeight: 340,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(4),
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//
//               ///DC24 Line
//
//               SizedBox(height: 30),
//
//               Text("IP List"),
//               SizedBox(height: 5),
//               Row(children: [
//                 Container(
//                   width: 450,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton2<String>(
//                                 isExpanded: true,
//                                 hint: Text(
//                                   'Select Item',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       color: Theme.of(context).hintColor),
//                                 ),
//                                 items: IPModules.map((item) => DropdownMenuItem(
//                                     value: item,
//                                     child: Text(
//                                       item,
//                                       style: const TextStyle(fontSize: 14),
//                                     ))).toList(),
//                                 value: IP_ModuleSelect,
//                                 onChanged: (value) async {
//                                   // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                   String? ModuleSelect = IP_ModuleSelect;
//
//                                   setState(() {
//                                     IP_ModuleSelect = value!;
//                                   });
//
//                                   await Future.delayed(Duration.zero, () {
//                                     setState(() {
//                                       if (IP_ModuleSelect != null &&
//                                           IP_ModuleSelect != "なし") {
//                                         IP_CountSelect = "1";
//                                         // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                         if (ModuleSelect == null ||
//                                             ModuleSelect == "なし") {
//                                           Line1_Total += 1;
//                                         }
//                                       } else {
//                                         IP_CountSelect = "0";
//                                         // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                         if (ModuleSelect != null &&
//                                             ModuleSelect != "なし") {
//                                           Line1_Total -= 1;
//                                         }
//                                       }
//                                     });
//                                   });
//
//                                   print('Power_ModuleSelect: $ModuleSelect');
//                                 },
//                                 buttonStyleData: ButtonStyleData(
//                                   padding: EdgeInsets.symmetric(horizontal: 16),
//                                   height: 40,
//                                   width: 280,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 dropdownStyleData: DropdownStyleData(
//                                   maxHeight: 340,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 menuItemStyleData: const MenuItemStyleData(
//                                   height: 40,
//                                 ),
//                                 dropdownSearchData: DropdownSearchData(
//                                   searchController: ModuleName1,
//                                   searchInnerWidgetHeight: 50,
//                                   searchInnerWidget: Container(
//                                     color: Colors.white,
//                                     height: 50,
//                                     padding: const EdgeInsets.only(
//                                         top: 8, bottom: 4, right: 8, left: 8),
//                                     child: TextFormField(
//                                       cursorColor: Colors.blue,
//                                       expands: true,
//                                       maxLines: null,
//                                       controller: ModuleName1,
//                                       decoration: InputDecoration(
//                                         isDense: true,
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: 10, vertical: 8),
//                                         hintText: 'Search for an item...',
//                                         hintStyle:
//                                             const TextStyle(fontSize: 12),
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8)),
//                                       ),
//                                     ),
//                                   ),
//                                   searchMatchFn: (item, searchValue) {
//                                     return item.value
//                                         .toString()
//                                         .contains(searchValue);
//                                   },
//                                 ),
//                                 onMenuStateChange: (isOpen) {
//                                   if (!isOpen) {
//                                     ModuleName1.clear();
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//
//                           SizedBox(width: 10),
//                           // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                           DropdownButtonHideUnderline(
//                             child: DropdownButton2<String>(
//                               isExpanded: true,
//                               hint: Text(
//                                 '0',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Theme.of(context).hintColor),
//                               ),
//                               items: items
//                                   .map(
//                                       (String item) => DropdownMenuItem<String>(
//                                           value: item,
//                                           child: Text(
//                                             item,
//                                             style:
//                                                 const TextStyle(fontSize: 14),
//                                           )))
//                                   .toList(),
//                               value: IP_CountSelect,
//                               onChanged: (value) {
//                                 setState(() {
//                                   IP_CountSelect = value!;
//                                 });
//                               },
//                               buttonStyleData: const ButtonStyleData(
//                                 padding: EdgeInsets.symmetric(horizontal: 16),
//                                 height: 40,
//                                 width: 80,
//                               ),
//                               menuItemStyleData: const MenuItemStyleData(
//                                 height: 40,
//                               ),
//                               dropdownStyleData: DropdownStyleData(
//                                 maxHeight: 340,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(4),
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton2<String>(
//                                 isExpanded: true,
//                                 hint: Text(
//                                   'Select Item',
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       color: Theme.of(context).hintColor),
//                                 ),
//                                 items: IPModules.map((item) => DropdownMenuItem(
//                                     value: item,
//                                     child: Text(
//                                       item,
//                                       style: const TextStyle(fontSize: 14),
//                                     ))).toList(),
//                                 value: IPR_ModuleSelect,
//                                 onChanged: (value) async {
//                                   // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                   String? ModuleSelect = IPR_ModuleSelect;
//
//                                   setState(() {
//                                     IPR_ModuleSelect = value!;
//                                   });
//
//                                   await Future.delayed(Duration.zero, () {
//                                     setState(() {
//                                       if (IPR_ModuleSelect != null &&
//                                           IPR_ModuleSelect != "なし") {
//                                         IPR_CountSelect = "1";
//                                         // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                         if (ModuleSelect == null ||
//                                             ModuleSelect == "なし") {
//                                           Line1_Total += 1;
//                                         }
//                                       } else {
//                                         IPR_CountSelect = "0";
//                                         // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                         if (ModuleSelect != null &&
//                                             ModuleSelect != "なし") {
//                                           Line1_Total -= 1;
//                                         }
//                                       }
//                                     });
//                                   });
//
//                                   print('Power_ModuleSelect: $ModuleSelect');
//                                 },
//                                 buttonStyleData: ButtonStyleData(
//                                   padding: EdgeInsets.symmetric(horizontal: 16),
//                                   height: 40,
//                                   width: 280,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 dropdownStyleData: DropdownStyleData(
//                                   maxHeight: 340,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 menuItemStyleData: const MenuItemStyleData(
//                                   height: 40,
//                                 ),
//                                 dropdownSearchData: DropdownSearchData(
//                                   searchController: ModuleName1,
//                                   searchInnerWidgetHeight: 50,
//                                   searchInnerWidget: Container(
//                                     color: Colors.white,
//                                     height: 50,
//                                     padding: const EdgeInsets.only(
//                                         top: 8, bottom: 4, right: 8, left: 8),
//                                     child: TextFormField(
//                                       cursorColor: Colors.blue,
//                                       expands: true,
//                                       maxLines: null,
//                                       controller: ModuleName1,
//                                       decoration: InputDecoration(
//                                         isDense: true,
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: 10, vertical: 8),
//                                         hintText: 'Search for an item...',
//                                         hintStyle:
//                                             const TextStyle(fontSize: 12),
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8)),
//                                       ),
//                                     ),
//                                   ),
//                                   searchMatchFn: (item, searchValue) {
//                                     return item.value
//                                         .toString()
//                                         .contains(searchValue);
//                                   },
//                                 ),
//                                 onMenuStateChange: (isOpen) {
//                                   if (!isOpen) {
//                                     ModuleName1.clear();
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//
//                           SizedBox(width: 10),
//                           // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                           DropdownButtonHideUnderline(
//                             child: DropdownButton2<String>(
//                               isExpanded: true,
//                               hint: Text(
//                                 '0',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Theme.of(context).hintColor),
//                               ),
//                               items: items
//                                   .map(
//                                       (String item) => DropdownMenuItem<String>(
//                                           value: item,
//                                           child: Text(
//                                             item,
//                                             style:
//                                                 const TextStyle(fontSize: 14),
//                                           )))
//                                   .toList(),
//                               value: IPR_CountSelect,
//                               onChanged: (value) {
//                                 setState(() {
//                                   IPR_CountSelect = value!;
//                                 });
//                               },
//                               buttonStyleData: const ButtonStyleData(
//                                 padding: EdgeInsets.symmetric(horizontal: 16),
//                                 height: 40,
//                                 width: 80,
//                               ),
//                               menuItemStyleData: const MenuItemStyleData(
//                                 height: 40,
//                               ),
//                               dropdownStyleData: DropdownStyleData(
//                                 maxHeight: 340,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(4),
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//
//               ///모듈 Line
//
//               SizedBox(height: 30),
//
//               Text("Modules List"),
//               SizedBox(height: 5),
//               Row(children: [
//                 Container(
//                   width: 450,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       ///Module1
//                       Visibility(
//                           visible: true,
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: MainModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: ModuleS1_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect =
//                                               ModuleS1_ModuleSelect;
//
//                                           setState(() {
//                                             ModuleS1_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (ModuleS1_ModuleSelect !=
//                                                       null &&
//                                                   ModuleS1_ModuleSelect !=
//                                                       "なし") {
//                                                 ModuleS1_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line1_Total += 1;
//                                                 }
//                                               } else {
//                                                 ModuleS1_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line1_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           });
//
//                                           print(
//                                               'Power_ModuleSelect: $ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: ModuleS1_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           ModuleS1_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ))),
//
//                       ///Module2
//                       Visibility(
//                           visible: true,
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: MainModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: ModuleS2_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect =
//                                               ModuleS2_ModuleSelect;
//
//                                           setState(() {
//                                             ModuleS2_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (ModuleS2_ModuleSelect !=
//                                                       null &&
//                                                   ModuleS2_ModuleSelect !=
//                                                       "なし") {
//                                                 ModuleS2_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line1_Total += 1;
//                                                 }
//                                               } else {
//                                                 ModuleS2_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line1_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           });
//
//                                           print(
//                                               'Power_ModuleSelect: $ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: ModuleS2_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           ModuleS2_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ))),
//
//                       ///Module3
//                       Visibility(
//                           visible: modules[0],
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: MainModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: ModuleS3_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect =
//                                               ModuleS3_ModuleSelect;
//
//                                           setState(() {
//                                             ModuleS3_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (ModuleS3_ModuleSelect !=
//                                                       null &&
//                                                   ModuleS3_ModuleSelect !=
//                                                       "なし") {
//                                                 ModuleS3_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line1_Total += 1;
//                                                 }
//                                               } else {
//                                                 ModuleS3_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line1_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           });
//
//                                           print(
//                                               'Power_ModuleSelect: $ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: ModuleS3_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           ModuleS3_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ))),
//
//                       ///Module4
//                       Visibility(
//                           visible: modules[1],
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: MainModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: ModuleS4_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect =
//                                               ModuleS4_ModuleSelect;
//
//                                           setState(() {
//                                             ModuleS4_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (ModuleS4_ModuleSelect !=
//                                                       null &&
//                                                   ModuleS4_ModuleSelect !=
//                                                       "なし") {
//                                                 ModuleS4_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line1_Total += 1;
//                                                 }
//                                               } else {
//                                                 ModuleS4_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line1_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           });
//
//                                           print(
//                                               'Power_ModuleSelect: $ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: ModuleS4_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           ModuleS4_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ))),
//
//                       ///Module5
//                       Visibility(
//                           visible: modules[2],
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: MainModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: ModuleS5_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect =
//                                               ModuleS5_ModuleSelect;
//
//                                           setState(() {
//                                             ModuleS5_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (ModuleS5_ModuleSelect !=
//                                                       null &&
//                                                   ModuleS5_ModuleSelect !=
//                                                       "なし") {
//                                                 ModuleS5_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line1_Total += 1;
//                                                 }
//                                               } else {
//                                                 ModuleS5_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line1_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           });
//
//                                           print(
//                                               'Power_ModuleSelect: $ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: ModuleS5_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           ModuleS5_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ))),
//
//                       ///Module6
//                       Visibility(
//                           visible: modules[3],
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: MainModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: ModuleS6_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect =
//                                               ModuleS6_ModuleSelect;
//
//                                           setState(() {
//                                             ModuleS6_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (ModuleS6_ModuleSelect !=
//                                                       null &&
//                                                   ModuleS6_ModuleSelect !=
//                                                       "なし") {
//                                                 ModuleS6_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line1_Total += 1;
//                                                 }
//                                               } else {
//                                                 ModuleS6_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line1_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           });
//
//                                           print(
//                                               'Power_ModuleSelect: $ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: ModuleS6_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           ModuleS6_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ))),
//
//                       ///Module7
//                       Visibility(
//                           visible: modules[4],
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: MainModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: ModuleS7_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect =
//                                               ModuleS7_ModuleSelect;
//
//                                           setState(() {
//                                             ModuleS7_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (ModuleS7_ModuleSelect !=
//                                                       null &&
//                                                   ModuleS7_ModuleSelect !=
//                                                       "なし") {
//                                                 ModuleS7_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line1_Total += 1;
//                                                 }
//                                               } else {
//                                                 ModuleS7_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line1_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           });
//
//                                           print(
//                                               'Power_ModuleSelect: $ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: ModuleS7_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           ModuleS7_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ))),
//
//                       ///Module8
//                       Visibility(
//                           visible: modules[5],
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: MainModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: ModuleS8_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect =
//                                               ModuleS8_ModuleSelect;
//
//                                           setState(() {
//                                             ModuleS8_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (ModuleS8_ModuleSelect !=
//                                                       null &&
//                                                   ModuleS8_ModuleSelect !=
//                                                       "なし") {
//                                                 ModuleS8_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line1_Total += 1;
//                                                 }
//                                               } else {
//                                                 ModuleS8_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line1_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           });
//
//                                           print(
//                                               'Power_ModuleSelect: $ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: ModuleS8_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           ModuleS8_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ))),
//
//                       ///Module9
//                       Visibility(
//                           visible: modules[6],
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: MainModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: ModuleS9_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect =
//                                               ModuleS9_ModuleSelect;
//
//                                           setState(() {
//                                             ModuleS9_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (ModuleS9_ModuleSelect !=
//                                                       null &&
//                                                   ModuleS9_ModuleSelect !=
//                                                       "なし") {
//                                                 ModuleS9_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line1_Total += 1;
//                                                 }
//                                               } else {
//                                                 ModuleS9_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line1_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           });
//
//                                           print(
//                                               'Power_ModuleSelect: $ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: ModuleS9_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           ModuleS9_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ))),
//
//                       ///Module10
//                       Visibility(
//                           visible: modules[7],
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: MainModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: ModuleS10_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect =
//                                               ModuleS10_ModuleSelect;
//
//                                           setState(() {
//                                             ModuleS10_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (ModuleS10_ModuleSelect !=
//                                                       null &&
//                                                   ModuleS10_ModuleSelect !=
//                                                       "なし") {
//                                                 ModuleS10_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line1_Total += 1;
//                                                 }
//                                               } else {
//                                                 ModuleS10_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line1_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           });
//
//                                           print(
//                                               'Power_ModuleSelect: $ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: ModuleS10_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           ModuleS10_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),),),
//                       Visibility(
//                         visible: !modules[7],
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: ElevatedButton(
//                             child: const Text(
//                               '+',
//                               style: TextStyle(fontSize: 20),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               padding: EdgeInsets.symmetric(horizontal: 170.0),
//                               foregroundColor: Colors.white,
//                               backgroundColor: Colors.blueAccent,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 if (modulesInt < 8) {
//                                   modules[modulesInt] = true;
//                                   modulesInt++;
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//
//               ///스위치 Line
//
//               SizedBox(height: 30),
//
//               Text("Switch List"),
//               SizedBox(height: 5),
//               Row(
//                 children: [
//                   Container(
//                     width: 450,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         ///Switch1
//                         Visibility(
//                           visible: true,
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: SwitchModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: Switch1_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect = Switch1_ModuleSelect;
//
//                                           setState(() {
//                                             Switch1_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (Switch1_ModuleSelect != null && Switch1_ModuleSelect != "なし") {
//                                                 Switch1_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line2_Total += 1;
//                                                 }
//                                               } else {
//                                                 Switch1_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line2_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           },
//                                           );
//
//                                           print(
//                                               'Power_ModuleSelect: $Switch1_ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: Switch1_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           Switch1_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )),
//                         ),
//                         Text("$Line2_Total"),
//                         ///Switch2
//                         Visibility(
//                           visible: true,
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton2<String>(
//                                         isExpanded: true,
//                                         hint: Text(
//                                           'Select Item',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color:
//                                                   Theme.of(context).hintColor),
//                                         ),
//                                         items: SwitchModules.map(
//                                             (item) => DropdownMenuItem(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 ))).toList(),
//                                         value: Switch2_ModuleSelect,
//                                         onChanged: (value) async {
//                                           // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                           String? ModuleSelect =
//                                               Switch2_ModuleSelect;
//
//                                           setState(() {
//                                             Switch2_ModuleSelect = value!;
//                                           });
//
//                                           await Future.delayed(Duration.zero,
//                                               () {
//                                             setState(() {
//                                               if (Switch2_ModuleSelect !=
//                                                       null &&
//                                                   Switch2_ModuleSelect !=
//                                                       "なし") {
//                                                 Switch2_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line2_Total += 1;
//                                                 }
//                                               } else {
//                                                 Switch2_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line2_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           });
//
//                                           print(
//                                               'Power_ModuleSelect: $Switch2_ModuleSelect');
//                                         },
//                                         buttonStyleData: ButtonStyleData(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           height: 40,
//                                           width: 280,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         dropdownStyleData: DropdownStyleData(
//                                           maxHeight: 340,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         menuItemStyleData:
//                                             const MenuItemStyleData(
//                                           height: 40,
//                                         ),
//                                         dropdownSearchData: DropdownSearchData(
//                                           searchController: ModuleName1,
//                                           searchInnerWidgetHeight: 50,
//                                           searchInnerWidget: Container(
//                                             color: Colors.white,
//                                             height: 50,
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 bottom: 4,
//                                                 right: 8,
//                                                 left: 8),
//                                             child: TextFormField(
//                                               cursorColor: Colors.blue,
//                                               expands: true,
//                                               maxLines: null,
//                                               controller: ModuleName1,
//                                               decoration: InputDecoration(
//                                                 isDense: true,
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 8),
//                                                 hintText:
//                                                     'Search for an item...',
//                                                 hintStyle: const TextStyle(
//                                                     fontSize: 12),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8)),
//                                               ),
//                                             ),
//                                           ),
//                                           searchMatchFn: (item, searchValue) {
//                                             return item.value
//                                                 .toString()
//                                                 .contains(searchValue);
//                                           },
//                                         ),
//                                         onMenuStateChange: (isOpen) {
//                                           if (!isOpen) {
//                                             ModuleName1.clear();
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 10),
//                                   // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                   DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         '0',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: items
//                                           .map((String item) =>
//                                               DropdownMenuItem<String>(
//                                                   value: item,
//                                                   child: Text(
//                                                     item,
//                                                     style: const TextStyle(
//                                                         fontSize: 14),
//                                                   )))
//                                           .toList(),
//                                       value: Switch2_CountSelect,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           Switch2_CountSelect = value!;
//                                         });
//                                       },
//                                       buttonStyleData: const ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 80,
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )),
//                         ),
//
//                         ///Switch3
//                         Visibility(
//                           visible: Switchs[0],
//                           child: Padding(
//                             padding: EdgeInsets.only(top: 10.0),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         'Select Item',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: SwitchModules.map(
//                                           (item) => DropdownMenuItem(
//                                               value: item,
//                                               child: Text(
//                                                 item,
//                                                 style: const TextStyle(
//                                                     fontSize: 14),
//                                               ))).toList(),
//                                       value: Switch3_ModuleSelect,
//                                       onChanged: (value) async {
//                                         // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                         String? ModuleSelect =
//                                             Switch3_ModuleSelect;
//
//                                         setState(() {
//                                           Switch3_ModuleSelect = value!;
//                                         });
//
//                                         await Future.delayed(Duration.zero, () {
//                                           setState(() {
//                                             if (Switch3_ModuleSelect != null &&
//                                                 Switch3_ModuleSelect != "なし") {
//                                               Switch3_CountSelect = "1";
//                                               // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                               if (ModuleSelect == null ||
//                                                   ModuleSelect == "なし") {
//                                                 Line2_Total += 1;
//                                               }
//                                             } else {
//                                               Switch3_CountSelect = "0";
//                                               // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                               if (ModuleSelect != null &&
//                                                   ModuleSelect != "なし") {
//                                                 Line2_Total -= 1;
//                                               }
//                                             }
//                                           });
//                                         });
//
//                                         print(
//                                             'Power_ModuleSelect: $Switch3_ModuleSelect');
//                                       },
//                                       buttonStyleData: ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 280,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownSearchData: DropdownSearchData(
//                                         searchController: ModuleName1,
//                                         searchInnerWidgetHeight: 50,
//                                         searchInnerWidget: Container(
//                                           color: Colors.white,
//                                           height: 50,
//                                           padding: const EdgeInsets.only(
//                                               top: 8,
//                                               bottom: 4,
//                                               right: 8,
//                                               left: 8),
//                                           child: TextFormField(
//                                             cursorColor: Colors.blue,
//                                             expands: true,
//                                             maxLines: null,
//                                             controller: ModuleName1,
//                                             decoration: InputDecoration(
//                                               isDense: true,
//                                               contentPadding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 10,
//                                                       vertical: 8),
//                                               hintText: 'Search for an item...',
//                                               hintStyle:
//                                                   const TextStyle(fontSize: 12),
//                                               border: OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8)),
//                                             ),
//                                           ),
//                                         ),
//                                         searchMatchFn: (item, searchValue) {
//                                           return item.value
//                                               .toString()
//                                               .contains(searchValue);
//                                         },
//                                       ),
//                                       onMenuStateChange: (isOpen) {
//                                         if (!isOpen) {
//                                           ModuleName1.clear();
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//
//                                 SizedBox(width: 10),
//                                 // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                 DropdownButtonHideUnderline(
//                                   child: DropdownButton2<String>(
//                                     isExpanded: true,
//                                     hint: Text(
//                                       '0',
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color: Theme.of(context).hintColor),
//                                     ),
//                                     items: items
//                                         .map((String item) =>
//                                             DropdownMenuItem<String>(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 )))
//                                         .toList(),
//                                     value: Switch3_CountSelect,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         Switch3_CountSelect = value!;
//                                       });
//                                     },
//                                     buttonStyleData: const ButtonStyleData(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 16),
//                                       height: 40,
//                                       width: 80,
//                                     ),
//                                     menuItemStyleData: const MenuItemStyleData(
//                                       height: 40,
//                                     ),
//                                     dropdownStyleData: DropdownStyleData(
//                                       maxHeight: 340,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(4),
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//
//                         ///Switch4
//                         Visibility(
//                           visible: Switchs[1],
//                           child: Padding(
//                             padding: EdgeInsets.only(top: 10.0),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         'Select Item',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: SwitchModules.map(
//                                         (item) => DropdownMenuItem(
//                                           value: item,
//                                           child: Text(
//                                             item,
//                                             style:
//                                                 const TextStyle(fontSize: 14),
//                                           ),
//                                         ),
//                                       ).toList(),
//                                       value: Switch4_ModuleSelect,
//                                       onChanged: (value) async {
//                                         // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                         String? ModuleSelect =
//                                             Switch4_ModuleSelect;
//
//                                         setState(
//                                           () {
//                                             Switch4_ModuleSelect = value!;
//                                           },
//                                         );
//
//                                         await Future.delayed(
//                                           Duration.zero,
//                                           () {
//                                             setState(() {
//                                               if (Switch4_ModuleSelect !=
//                                                       null &&
//                                                   Switch4_ModuleSelect !=
//                                                       "なし") {
//                                                 Switch4_CountSelect = "1";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                 if (ModuleSelect == null ||
//                                                     ModuleSelect == "なし") {
//                                                   Line2_Total += 1;
//                                                 }
//                                               } else {
//                                                 Switch4_CountSelect = "0";
//                                                 // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                 if (ModuleSelect != null &&
//                                                     ModuleSelect != "なし") {
//                                                   Line2_Total -= 1;
//                                                 }
//                                               }
//                                             });
//                                           },
//                                         );
//
//                                         print(
//                                             'Power_ModuleSelect: $Switch4_ModuleSelect');
//                                       },
//                                       buttonStyleData: ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 280,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownSearchData: DropdownSearchData(
//                                         searchController: ModuleName1,
//                                         searchInnerWidgetHeight: 50,
//                                         searchInnerWidget: Container(
//                                           color: Colors.white,
//                                           height: 50,
//                                           padding: const EdgeInsets.only(
//                                               top: 8,
//                                               bottom: 4,
//                                               right: 8,
//                                               left: 8),
//                                           child: TextFormField(
//                                             cursorColor: Colors.blue,
//                                             expands: true,
//                                             maxLines: null,
//                                             controller: ModuleName1,
//                                             decoration: InputDecoration(
//                                               isDense: true,
//                                               contentPadding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 10,
//                                                       vertical: 8),
//                                               hintText: 'Search for an item...',
//                                               hintStyle:
//                                                   const TextStyle(fontSize: 12),
//                                               border: OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8)),
//                                             ),
//                                           ),
//                                         ),
//                                         searchMatchFn: (item, searchValue) {
//                                           return item.value
//                                               .toString()
//                                               .contains(searchValue);
//                                         },
//                                       ),
//                                       onMenuStateChange: (isOpen) {
//                                         if (!isOpen) {
//                                           ModuleName1.clear();
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//
//                                 SizedBox(width: 10),
//                                 // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                 DropdownButtonHideUnderline(
//                                   child: DropdownButton2<String>(
//                                     isExpanded: true,
//                                     hint: Text(
//                                       '0',
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color: Theme.of(context).hintColor),
//                                     ),
//                                     items: items
//                                         .map((String item) =>
//                                             DropdownMenuItem<String>(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 )))
//                                         .toList(),
//                                     value: Switch4_CountSelect,
//                                     onChanged: (value) {
//                                       setState(
//                                         () {
//                                           Switch4_CountSelect = value!;
//                                         },
//                                       );
//                                     },
//                                     buttonStyleData: const ButtonStyleData(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 16),
//                                       height: 40,
//                                       width: 80,
//                                     ),
//                                     menuItemStyleData: const MenuItemStyleData(
//                                       height: 40,
//                                     ),
//                                     dropdownStyleData: DropdownStyleData(
//                                       maxHeight: 340,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(4),
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//
//                         ///Switch5
//                         Visibility(
//                           visible: Switchs[2],
//                           child: Padding(
//                             padding: EdgeInsets.only(top: 10.0),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton2<String>(
//                                       isExpanded: true,
//                                       hint: Text(
//                                         'Select Item',
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: Theme.of(context).hintColor),
//                                       ),
//                                       items: SwitchModules.map(
//                                         (item) => DropdownMenuItem(
//                                           value: item,
//                                           child: Text(
//                                             item,
//                                             style:
//                                                 const TextStyle(fontSize: 14),
//                                           ),
//                                         ),
//                                       ).toList(),
//                                       value: Switch5_ModuleSelect,
//                                       onChanged: (value) async {
//                                         // 변경 이전의 Power_ModuleSelect 상태를 저장합니다.
//                                         String? ModuleSelect =
//                                             Switch5_ModuleSelect;
//
//                                         setState(
//                                           () {
//                                             Switch5_ModuleSelect = value!;
//                                           },
//                                         );
//
//                                         await Future.delayed(
//                                           Duration.zero,
//                                           () {
//                                             setState(
//                                               () {
//                                                 if (Switch5_ModuleSelect !=
//                                                         null &&
//                                                     Switch5_ModuleSelect !=
//                                                         "なし") {
//                                                   Switch5_CountSelect = "1";
//                                                   // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 증가시킵니다.
//                                                   if (ModuleSelect == null ||
//                                                       ModuleSelect == "なし") {
//                                                     Line2_Total += 1;
//                                                   }
//                                                 } else {
//                                                   Switch5_CountSelect = "0";
//                                                   // 이전 상태와 현재 상태가 다를 때만 Line1_Total을 감소시킵니다.
//                                                   if (ModuleSelect != null &&
//                                                       ModuleSelect != "なし") {
//                                                     Line2_Total -= 1;
//                                                   }
//                                                 }
//                                               },
//                                             );
//                                           },
//                                         );
//
//                                         print(
//                                             'Power_ModuleSelect: $Switch5_ModuleSelect');
//                                       },
//                                       buttonStyleData: ButtonStyleData(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         height: 40,
//                                         width: 280,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       dropdownStyleData: DropdownStyleData(
//                                         maxHeight: 340,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       menuItemStyleData:
//                                           const MenuItemStyleData(
//                                         height: 40,
//                                       ),
//                                       dropdownSearchData: DropdownSearchData(
//                                         searchController: ModuleName1,
//                                         searchInnerWidgetHeight: 50,
//                                         searchInnerWidget: Container(
//                                           color: Colors.white,
//                                           height: 50,
//                                           padding: const EdgeInsets.only(
//                                               top: 8,
//                                               bottom: 4,
//                                               right: 8,
//                                               left: 8),
//                                           child: TextFormField(
//                                             cursorColor: Colors.blue,
//                                             expands: true,
//                                             maxLines: null,
//                                             controller: ModuleName1,
//                                             decoration: InputDecoration(
//                                               isDense: true,
//                                               contentPadding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 10,
//                                                       vertical: 8),
//                                               hintText: 'Search for an item...',
//                                               hintStyle:
//                                                   const TextStyle(fontSize: 12),
//                                               border: OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8)),
//                                             ),
//                                           ),
//                                         ),
//                                         searchMatchFn: (item, searchValue) {
//                                           return item.value
//                                               .toString()
//                                               .contains(searchValue);
//                                         },
//                                       ),
//                                       onMenuStateChange: (isOpen) {
//                                         if (!isOpen) {
//                                           ModuleName1.clear();
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//
//                                 SizedBox(width: 10),
//                                 // 추가된 Dropdown 위젯 옆에 수량 Dropdown 추가
//                                 DropdownButtonHideUnderline(
//                                   child: DropdownButton2<String>(
//                                     isExpanded: true,
//                                     hint: Text(
//                                       '0',
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color: Theme.of(context).hintColor),
//                                     ),
//                                     items: items
//                                         .map((String item) =>
//                                             DropdownMenuItem<String>(
//                                                 value: item,
//                                                 child: Text(
//                                                   item,
//                                                   style: const TextStyle(
//                                                       fontSize: 14),
//                                                 )))
//                                         .toList(),
//                                     value: Switch5_CountSelect,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         Switch5_CountSelect = value!;
//                                       });
//                                     },
//                                     buttonStyleData: const ButtonStyleData(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 16),
//                                       height: 40,
//                                       width: 80,
//                                     ),
//                                     menuItemStyleData: const MenuItemStyleData(
//                                       height: 40,
//                                     ),
//                                     dropdownStyleData: DropdownStyleData(
//                                       maxHeight: 340,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(4),
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: !Switchs[2],
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: ElevatedButton(
//                               child: const Text('+',
//                                   style: TextStyle(fontSize: 20)),
//                               style: ElevatedButton.styleFrom(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 170.0),
//                                 foregroundColor: Colors.white,
//                                 backgroundColor: Colors.blueAccent,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   if (SwitchsInt < 8) {
//                                     Switchs[SwitchsInt] = true;
//                                     SwitchsInt++;
//                                   }
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: 10),
//               ElevatedButton(
//                   onPressed: _createExcel, child: const Text('Export')),
//
//               SizedBox(height: 200)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
