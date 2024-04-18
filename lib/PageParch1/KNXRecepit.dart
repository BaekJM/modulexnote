import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Widget'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            exportExcel();
          },
          child: const Text(
            'Export Excel',
          ),
        ),
      ),
    );
  }

  Future exportExcel() async {
    final workbook = Workbook();
    final workSheet = workbook.worksheets[0];

    workSheet.name = '서울 평균 기온';

    workSheet.getRangeByName('A1:D1').merge();
    workSheet.getRangeByName('A1').columnWidth = 16.0;
    workSheet.getRangeByName('B1').columnWidth = 16.0;
    workSheet.getRangeByName('A1').setText('서울 평균 기온');
    workSheet.getRangeByName('A1').cellStyle.vAlign = VAlignType.center;
    workSheet.getRangeByName('A2').setText('년');
    workSheet.getRangeByName('B2').setText('평균 기온');

    for (var i = 2002; i < 2023; i++) {
      workSheet.getRangeByName('A${i - 1999}').setNumber(i.toDouble());
    }

    workSheet.getRangeByName('B3').setNumber(12.9);
    workSheet.getRangeByName('B4').setNumber(12.8);
    workSheet.getRangeByName('B5').setNumber(13.3);
    workSheet.getRangeByName('B6').setNumber(12.1);
    workSheet.getRangeByName('B7').setNumber(13);
    workSheet.getRangeByName('B8').setNumber(13.3);
    workSheet.getRangeByName('B9').setNumber(12.9);
    workSheet.getRangeByName('B10').setNumber(12.9);
    workSheet.getRangeByName('B11').setNumber(12.1);
    workSheet.getRangeByName('B12').setNumber(12);
    workSheet.getRangeByName('B13').setNumber(12.2);
    workSheet.getRangeByName('B14').setNumber(12.5);
    workSheet.getRangeByName('B15').setNumber(13.4);
    workSheet.getRangeByName('B16').setNumber(13.6);
    workSheet.getRangeByName('B17').setNumber(13);
    workSheet.getRangeByName('B18').setNumber(12.9);
    workSheet.getRangeByName('B19').setNumber(13.5);
    workSheet.getRangeByName('B20').setNumber(13.2);
    workSheet.getRangeByName('B21').setNumber(13.7);
    workSheet.getRangeByName('B22').setNumber(13.2);
    workSheet.getRangeByName('B23').setNumber(13.4);

    final excelData = workbook.saveAsStream();
    workbook.dispose();

    Directory? appDirectory = await getApplicationDocumentsDirectory();
    String? fileName = '${appDirectory.path}/test.xlsx';

    final file = await File(fileName).create(recursive: true);
    await file.writeAsBytes(excelData, flush: true);
    final xfile = XFile(file.path,
        name: fileName,
        mimeType:
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final subject = 'test';

    await Share.shareXFiles([xfile], subject: subject);
  }
}