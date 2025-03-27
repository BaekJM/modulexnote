import 'package:flutter/material.dart';

class TimePickerWithSlider extends StatefulWidget {
  @override
  _TimePickerWithSliderState createState() => _TimePickerWithSliderState();
}

class _TimePickerWithSliderState extends State<TimePickerWithSlider> {
  DateTime? selectedDate;
  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 0);

  void _showTimePicker(BuildContext context) {
    double hourValue = selectedTime.hour.toDouble();
    double minuteValue = selectedTime.minute.toDouble();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(16),
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "時間を選択してください",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  /// 시간 선택 슬라이더
                  Text("時間: ${hourValue.toInt()} 時"),
                  Slider(
                    value: hourValue,
                    min: 0,
                    max: 23,
                    divisions: 23, // 0~23 시간
                    label: "${hourValue.toInt()}",
                    onChanged: (value) {
                      setModalState(() => hourValue = value);
                    },
                  ),

                  /// 분 선택 슬라이더
                  Text("分: ${minuteValue.toInt()} 分"),
                  Slider(
                    value: minuteValue,
                    min: 0,
                    max: 59,
                    divisions: 59, // 0~59 분
                    label: "${minuteValue.toInt()}",
                    onChanged: (value) {
                      setModalState(() => minuteValue = value);
                    },
                  ),

                  /// 선택 버튼
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedTime =
                            TimeOfDay(hour: hourValue.toInt(), minute: minuteValue.toInt());
                      });
                      Navigator.pop(context);
                    },
                    child: Text("選択"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 날짜 선택 버튼
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300),
          child: OutlinedButton(
            child: Container(
              height: 50,
              child: Center(
                child: Row(
                  children: [
                    Icon(Icons.calendar_month),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? "日付を選択してください。"
                            : "${selectedDate!.toLocal()}".split(' ')[0],
                        style: TextStyle(fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(),
            ),
            onPressed: () {
              // 날짜 선택 기능 추가 가능
            },
          ),
        ),

        SizedBox(height: 8),

        /// 시간 선택 버튼 (Progress Bar 적용)
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300),
          child: OutlinedButton(
            child: Container(
              height: 50,
              child: Center(
                child: Row(
                  children: [
                    Icon(Icons.access_time_outlined),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(),
            ),
            onPressed: () => _showTimePicker(context),
          ),
        ),
      ],
    );
  }
}
