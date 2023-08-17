import 'package:flutter/material.dart';

import 'easy_text_field.dart';
import 'easy_text_field_style.dart';

class EditTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final String? placeholder;
  final String? value;
  final double? height;

  const EditTextField({
    Key? key,
    this.value,
    this.placeholder,
    this.textInputAction,
    this.textEditingController,
    this.onChanged,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyTextField(
      key: key,
      value: value,
      placeholder: placeholder,
      controller: textEditingController,
      textInputAction: textInputAction,
      onChanged: onChanged,
      style: edit,
      suffix: const Icon(Icons.edit, color: Colors.black26, size: 16),
      isDense: true,
      clear: true,
    );
  }
}
