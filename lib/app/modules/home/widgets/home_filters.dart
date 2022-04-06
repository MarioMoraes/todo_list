import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/modules/home/widgets/todo_card.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          'Filters',
          style: context.textStyle.copyWith(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  TodoCard(),
                  TodoCard(),
                  TodoCard(),
                  TodoCard(),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
