import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easy/flutter_easy.dart';

class NumCharTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FocusNode? textFocusNode;
  final FocusNode keyBoardFocusNode;
  final ValueChanged<RawKeyEvent>? onKey;

  const NumCharTextField({
    Key? key,
    this.textInputAction,
    this.textEditingController,
    this.onChanged,
    this.textFocusNode,
    this.onKey,
    required this.keyBoardFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawKeyboardListener(
        focusNode: keyBoardFocusNode,
        onKey: onKey,
        child: TextField(
          key: key,
          maxLength: 2,
          controller: textEditingController,
          focusNode: textFocusNode,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
                RegularExpression.partMacAddress.regExp),
          ],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE1E1E1)),
            ),
            fillColor: Color(0xFFFAFAFA),
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 5),
            counterText: '',
          ),
          textInputAction: textInputAction,
          textAlign: TextAlign.center,
          style: const TextStyle().black87.w700,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
