import 'package:flutter/material.dart';
import 'package:flutter_easy/flutter_easy.dart';

import 'easy_text_field.dart';
import 'easy_text_field_style.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final String? placeholder;
  final String? value;
  final bool enabled;
  final bool autoFocus;

  const SearchTextField({
    Key? key,
    this.value,
    this.textEditingController,
    this.placeholder,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction = TextInputAction.search,
    this.enabled = true,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyTextField(
      value: value,
      height: 36,
      controller: textEditingController,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      placeholder: placeholder,
      placeholderTextStyle: const TextStyle().s15.black26,
      style: search,
      prefix: const Icon(Icons.search),
      clear: true,
      enabled: enabled,
      autoFocus: autoFocus,
    );
  }
}
