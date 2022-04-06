import 'package:flutter/material.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.today,
            size: 18,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Select Date',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
