import 'package:flutter/material.dart';

class ModalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final double? elevation;
  final Color? backgroundColor;
  final bool? centerTitle;
  final double? toolbarHeight;
  final double? leadingWidth;
  @override
  final Size preferredSize;

  ModalAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.elevation,
    this.backgroundColor,
    this.centerTitle,
    this.toolbarHeight,
    this.leadingWidth,
  })  : assert(elevation == null || elevation >= 0.0),
        preferredSize = Size.fromHeight(toolbarHeight ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: SafeArea(
        child: Container(
          color: Colors.black54,
          child: AppBar(
            leading: leading,
            title: title,
            actions: actions,
            elevation: elevation,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            backgroundColor: backgroundColor,
            centerTitle: centerTitle,
            toolbarHeight: toolbarHeight,
            leadingWidth: leadingWidth,
          ),
        ),
      ),
    );
  }
}
