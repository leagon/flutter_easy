import 'package:flutter/material.dart';

Future<T?> showModalRoute<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  double heightFactor = 0.9,

  // system parameters
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  BoxConstraints? constraints,
  Color? barrierColor,
  bool isScrollControlled = true, // default is false
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = false,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (context) => _ModalRoutePage(
      builder: builder,
      heightFactor: heightFactor,
    ),
    backgroundColor: backgroundColor ?? Colors.white,
    elevation: elevation,
    shape: shape ??
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
    clipBehavior: clipBehavior,
    constraints: constraints,
    barrierColor: barrierColor ?? Colors.black54,
    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    routeSettings: routeSettings,
    transitionAnimationController: transitionAnimationController,
  );
}

class _ModalRoutePage extends StatelessWidget {
  final WidgetBuilder builder;
  final double heightFactor;

  const _ModalRoutePage({
    Key? key,
    required this.builder,
    this.heightFactor = 0.9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: heightFactor,
      child: builder(context),
    );
  }
}
