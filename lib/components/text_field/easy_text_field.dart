import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'easy_text_field_style.dart';

typedef WidgetLimitBuilder = Widget Function(
    BuildContext context, int length, int maxLength);

class EasyTextField extends StatefulWidget {
  final String? value;
  final String? placeholder;
  final EasyTextFieldStyle? style;
  final TextEditingController? controller;
  final bool clear;
  final bool obscureText;
  final bool showPassword;
  final double? height;
  final Widget? suffix;
  final Widget? prefix;
  final double? minPrefixWidth;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool autoFocus;
  final bool? isDense;

  /// show Word Count
  final bool showWordLimit;
  final int? maxLength;
  final TextStyle? textStyle;
  final TextStyle? placeholderTextStyle;

  final WidgetLimitBuilder? limitBuilder;

  final FocusNode? focusNode;

  final String? errorText;

  const EasyTextField({
    Key? key,
    this.value,
    this.placeholder,
    this.style,
    this.controller,
    this.clear = false,
    this.obscureText = false,
    this.showPassword = false,
    this.height = 48,
    this.suffix,
    this.prefix,
    this.maxLines = 1,
    this.minLines,
    this.minPrefixWidth,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.onChanged,
    this.onSubmitted,
    this.showWordLimit = false,
    this.maxLength,
    this.inputFormatters,
    this.enabled,
    this.textStyle,
    this.placeholderTextStyle,
    this.limitBuilder,
    this.autoFocus = false,
    this.onEditingComplete,
    this.focusNode,
    this.isDense,
    this.errorText,
  }) : super(key: key);

  @override
  _EasyTextFieldState createState() => _EasyTextFieldState();
}

class _EasyTextFieldState extends State<EasyTextField> {
  late TextEditingController _controller;
  late String _value;
  late bool _showPassword;
  int _wordLength = 0;
  double _textHeight = 0;
  late FocusNode _focusNode;

  @override
  initState() {
    _value = widget.value ?? '';
    _controller = widget.controller ?? TextEditingController()
      ..text = _value
      ..selection =
          TextSelection.fromPosition(TextPosition(offset: _value.length));
    _wordLength = _value.length;
    _showPassword = false;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_focusNodeListener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  void _focusNodeListener() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(covariant EasyTextField oldWidget) {
    if (oldWidget.value != widget.value) {
      _value = widget.value ?? '';
    }
    if (oldWidget.controller != widget.controller) {
      _controller = widget.controller ?? TextEditingController();
    }
    if (_controller.text != _value) _value = _controller.text;
    final selection = _controller.selection;
    _controller
      ..text = _value
      ..selection = selection;
    _wordLength = _value.length;
    super.didUpdateWidget(oldWidget);
  }

  void _getTextHeight(TextStyle textStyle) {
    var textPainter = TextPainter(
      text: TextSpan(
        text: '',
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
    )..layout();
    _textHeight = textPainter.height;
  }

  void _onClickClearIcon() {
    if (!mounted) {
      return;
    }
    setState(() {
      _value = '';
      _controller.text = _value;
    });
    widget.onChanged?.call(_value);
  }

  void _onClickPasswordIcon() {
    if (!mounted) {
      return;
    }
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _onValueChange(String value) {
    if (!mounted) {
      return;
    }
    setState(() {
      _value = value;
    });
    if (widget.showWordLimit) {
      _computeWordCount();
    }
    widget.onChanged?.call(value);
  }

  /// compute Word Count, not including the text being edited
  void _computeWordCount() {
    var valueLength = _controller.value.text.length;
    var composingLength =
        _controller.value.composing.end - _controller.value.composing.start;
    if (!mounted) {
      return;
    }
    setState(() {
      _wordLength = valueLength - composingLength;
    });
  }

  @override
  Widget build(BuildContext context) {
    var style = (widget.style?.isOutlined ?? true)
        ? EasyTextFieldStyle.defaultOutlinedTextFieldStyle.merge(widget.style)
        : EasyTextFieldStyle.defaultUnderlinedTextFieldStyle
            .merge(widget.style);

    List<TextInputFormatter> inputFormatters = [];
    inputFormatters.addAll(widget.inputFormatters ?? []);
    if (widget.maxLength != null) {
      inputFormatters.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }

    var textStyle = widget.textStyle ?? TextStyle(color: style.fontColor);
    var placeholderTextStyle =
        widget.placeholderTextStyle ?? TextStyle(color: style.placeholderColor);
    const errorStyle = TextStyle(height: 0.01, color: Colors.transparent);
    _getTextHeight(textStyle);
    EdgeInsetsGeometry? contentPadding;
    if (widget.height != null) {
      if (widget.maxLines == null || widget.maxLines == 1) {
        contentPadding = widget.height! > _textHeight
            ? EdgeInsets.symmetric(
                horizontal: 12, vertical: (widget.height! - _textHeight) / 2)
            : const EdgeInsets.symmetric(horizontal: 12, vertical: 0);
      }
    }
    var textField = TextField(
      controller: _controller,
      obscureText: widget.obscureText && !_showPassword,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      onChanged: _onValueChange,
      onSubmitted: widget.onSubmitted,
      onEditingComplete: widget.onEditingComplete,
      inputFormatters: inputFormatters,
      enabled: widget.enabled,
      style: textStyle,
      autofocus: widget.autoFocus,
      focusNode: _focusNode,
      decoration: InputDecoration(
        fillColor: style.backgroundColor,
        filled: true,
        hintText: widget.placeholder,
        hintStyle: placeholderTextStyle,
        suffixIcon: _buildSuffix(style),
        prefixIcon: widget.prefix,
        prefixIconConstraints: BoxConstraints(
            minWidth: widget.minPrefixWidth ?? 30, maxHeight: 20),
        contentPadding: contentPadding,
        enabledBorder: _buildEnabledBorder(style),
        focusedBorder: _buildFocusBorder(style),
        focusedErrorBorder: _buildFocusErrorBorder(style),
        disabledBorder: _buildEnabledBorder(style),
        isDense: widget.isDense,
        errorText: widget.errorText,
        errorStyle: errorStyle,
      ),
    );
    if (widget.height != null) {
      return SizedBox(
        height: widget.height,
        child: textField,
      );
    }
    return textField;
  }

  Widget? _buildSuffix(EasyTextFieldStyle? style) {
    Widget? clearWidget =
        (widget.clear && _value.isNotEmpty && _focusNode.hasFocus)
            ? IconButton(
                onPressed: _onClickClearIcon,
                icon: Icon(
                  Icons.cancel,
                  color: style?.clearColor,
                  size: 16,
                ),
              )
            : null;

    Widget? showPasswordWidget = (widget.obscureText && widget.showPassword)
        ? IconButton(
            onPressed: _onClickPasswordIcon,
            icon: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: style?.clearColor,
              size: 20,
            ),
          )
        : null;

    if (clearWidget == null &&
        clearWidget == showPasswordWidget &&
        widget.suffix == null &&
        !widget.showWordLimit) {
      return null;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: (widget.maxLines == null || widget.maxLines == 1)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        clearWidget ?? Container(),
        showPasswordWidget ?? Container(),
        Container(
          alignment: Alignment.centerRight,
          padding: widget.suffix == null
              ? EdgeInsets.zero
              : const EdgeInsets.only(right: 12),
          child: widget.suffix,
        ),
        widget.showWordLimit ? _buildWordLimit(style) : const SizedBox(),
      ],
    );
  }

  Widget _buildWordLimit(EasyTextFieldStyle? style) {
    var text = widget.limitBuilder
            ?.call(context, _wordLength, widget.maxLength ?? 0) ??
        Text(
          '$_wordLength/${widget.maxLength}',
          style: TextStyle(color: style?.placeholderColor),
        );
    if (widget.maxLines == null || widget.maxLines == 1) {
      return text;
    }
    return Padding(
      padding: const EdgeInsets.only(right: 12, bottom: 12),
      child: text,
    );
  }

  InputBorder _buildEnabledBorder(EasyTextFieldStyle style) {
    return style.isUnderlined
        ? UnderlineInputBorder(
            borderSide: BorderSide(
                color: style.borderColor ?? Colors.transparent,
                width: style.borderWidth))
        : OutlineInputBorder(
            borderSide: BorderSide(
                color: style.borderColor ?? Colors.transparent,
                width: style.borderWidth),
            borderRadius: style.borderRadius ?? BorderRadius.zero,
          );
  }

  InputBorder _buildFocusBorder(EasyTextFieldStyle style) {
    return style.isUnderlined
        ? UnderlineInputBorder(
            borderSide: BorderSide(
                color: style.focusBorderColor ?? Colors.transparent,
                width: style.borderWidth))
        : OutlineInputBorder(
            borderSide: BorderSide(
                color: style.focusBorderColor ?? Colors.transparent,
                width: style.borderWidth),
            borderRadius: style.borderRadius ?? BorderRadius.zero,
          );
  }

  InputBorder _buildFocusErrorBorder(EasyTextFieldStyle style) {
    return style.isUnderlined
        ? UnderlineInputBorder(
            borderSide: BorderSide(
                color: style.focusErrorBorderColor ?? Colors.transparent,
                width: style.borderWidth))
        : OutlineInputBorder(
            borderSide: BorderSide(
                color: style.focusErrorBorderColor ?? Colors.transparent,
                width: style.borderWidth),
            borderRadius: style.borderRadius ?? BorderRadius.zero,
          );
  }
}
