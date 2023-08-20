import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easy/flutter_easy.dart';

class SliverUnderLinedTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final EasyTextFieldStyle? style;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;

  final double? height;

  final Widget? suffix;
  final Widget? prefix;
  final String? placeholder;
  final String? value;
  final Widget? title;
  final String? helper;
  final TextStyle? helperStyle;

  final bool obscureText;
  final bool autoFocus;
  final bool enabled;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final GlobalKey? globalKey;

  final List<TextInputFormatter>? inputFormatters;

  final int? maxLines;

  final bool showWordLimit;
  final int? maxLength;
  final WidgetLimitBuilder? limitBuilder;

  const SliverUnderLinedTextField({
    Key? key,
    this.textEditingController,
    this.style,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.height,
    this.suffix,
    this.prefix,
    this.placeholder,
    this.value,
    this.title,
    this.helper,
    this.helperStyle,
    this.obscureText = false,
    this.autoFocus = false,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.globalKey,
    this.inputFormatters,
    this.maxLines = 1,
    this.showWordLimit = false,
    this.limitBuilder,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: UnderlinedTextField(
        textEditingController: textEditingController,
        style: style,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        height: height,
        suffix: suffix,
        prefix: prefix,
        placeholder: placeholder,
        value: value,
        title: title,
        helper: helper,
        helperStyle: helperStyle,
        obscureText: obscureText,
        autoFocus: autoFocus,
        enabled: enabled,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        globalKey: globalKey,
        inputFormatters: inputFormatters,
        showWordLimit: showWordLimit,
        limitBuilder: limitBuilder,
        maxLength: maxLength,
      ),
    );
  }
}

class UnderlinedTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final EasyTextFieldStyle? style;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;

  final double? height;

  final Widget? suffix;
  final Widget? prefix;
  final String? placeholder;
  final String? value;
  final Widget? title;
  final String? helper;
  final TextStyle? helperStyle;
  final double? minPrefixWidth;
  final TextStyle? textStyle;

  final bool obscureText;
  final bool autoFocus;
  final bool enabled;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final GlobalKey? globalKey;
  final List<TextInputFormatter>? inputFormatters;

  final int? maxLines;
  final TextStyle? placeholderTextStyle;
  final EdgeInsets? prefixPadding;

  final bool showWordLimit;
  final int? maxLength;
  final WidgetLimitBuilder? limitBuilder;

  const UnderlinedTextField({
    Key? key,
    this.textEditingController,
    this.style,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.height = 48,
    this.suffix,
    this.prefix,
    this.placeholder,
    this.value,
    this.title,
    this.helper,
    this.textStyle,
    this.helperStyle,
    this.obscureText = false,
    this.autoFocus = false,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.globalKey,
    this.maxLength,
    this.inputFormatters,
    this.minPrefixWidth,
    this.maxLines = 1,
    this.placeholderTextStyle,
    this.prefixPadding,
    this.showWordLimit = false,
    this.limitBuilder,
  }) : super(key: key);

  @override
  _UnderlinedTextFieldState createState() => _UnderlinedTextFieldState();
}

class _UnderlinedTextFieldState extends State<UnderlinedTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.title != null,
          child: widget.title ?? const SizedBox(),
        ),
        EasyTextField(
          maxLength: widget.maxLength,
          value: widget.value,
          placeholder: widget.placeholder,
          controller: widget.textEditingController,
          style: EasyTextFieldStyle.defaultUnderlinedTextFieldStyle
              .merge(widget.style),
          clear: true,
          obscureText: widget.obscureText,
          showPassword: widget.obscureText,
          enabled: widget.enabled,
          height: widget.height,
          suffix: widget.suffix ?? const SizedBox(),
          prefix: widget.prefix != null
              ? Padding(
                  padding:
                      widget.prefixPadding ?? const EdgeInsets.only(right: 10),
                  child: widget.prefix,
                )
              : null,
          minPrefixWidth: widget.minPrefixWidth,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          textStyle: const TextStyle().black87,
          placeholderTextStyle:
              widget.placeholderTextStyle ?? const TextStyle().black26,
          autoFocus: widget.autoFocus,
          focusNode: widget.focusNode,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLines,
          showWordLimit: widget.showWordLimit,
          limitBuilder: widget.limitBuilder,
        ),
        const SizedBox(height: 5),
        Visibility(
          visible: widget.helper != null,
          child: Text(
            widget.helper ?? '',
            style: widget.helperStyle ?? const TextStyle().s12.black54,
          ),
        ),
      ],
    );
  }
}
