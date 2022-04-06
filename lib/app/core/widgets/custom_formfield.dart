import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/todo_list_icon.dart';

class CustomFormField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final IconData? suffixIcon;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focus;

  CustomFormField({
    Key? key,
    required this.hint,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.focus,
  })  : obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: ((context, value, child) => TextFormField(
            controller: controller,
            validator: validator,
            focusNode: focus,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hint,
              isDense: true,
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      icon: (obscureTextVN.value == true)
                          ? Icon(
                              suffixIcon,
                              size: 15,
                            )
                          : const Icon(
                              TodoListIcon.eyeSlash,
                              size: 15,
                            ),
                      onPressed: () {
                        obscureTextVN.value = !obscureTextVN.value;
                      },
                    )
                  : null,
            ),
            obscureText: value,
          )),
    );
  }
}
