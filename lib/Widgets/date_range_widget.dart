import 'package:flutter/material.dart';

class DateRangePickerWidget extends StatefulWidget {
  const DateRangePickerWidget({Key? key}) : super(key: key);

  @override
  State<DateRangePickerWidget> createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime dateTime = DateTime(2022, 12, 24, 5, 30);
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(2022, 12, 24, 5, 30), end: DateTime(2022, 12, 24, 5, 30));

  // void _showDatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2050),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    return Scaffold(
      body: Center(
        child: Row(
          children: [
            TextButton(
              onPressed: pickTimeRange,
              // child: const Icon(Icons.calendar_month),
              child: Text(
                  '${dateRange.start.year}/${dateRange.start.month}/${dateRange.start.day} ${dateRange.start.hour}:${dateRange.start.minute} - ${dateRange.end.year}/${dateRange.end.month}/${dateRange.end.day} ${dateRange.end.hour}:${dateRange.end.minute}'),
            ),
          ],
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newTimeRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  Future pickTimeRange() async {
    TimeOfDay? time1 = await pickTime();
    if (time1 == null) return;

    TimeOfDay? time2 = await pickTime();
    if (time2 == null) return;

    final dateRange1 = DateTime(
      dateRange.start.year,
      dateRange.start.month,
      dateRange.start.day,
      time1.hour,
      time1.minute,
    );

    final dateRange2 = DateTime(
      dateRange.start.year,
      dateRange.start.month,
      dateRange.start.day,
      time2.hour,
      time2.minute,
    );

    setState(
        () => dateRange = DateTimeRange(start: dateRange1, end: dateRange2));
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
