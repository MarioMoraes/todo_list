import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';

class HomeWeek extends StatelessWidget {
  const HomeWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'Week',
          style: context.textStyle.copyWith(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 95,
          child: DatePicker(
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            daysCount: 7,
            monthTextStyle: const TextStyle(fontSize: 8),
            dateTextStyle: const TextStyle(fontSize: 13),
            dayTextStyle: const TextStyle(fontSize: 13),
          ),
        )
      ],
    );
  }
}