import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';

class KeyboardAvoid extends StatefulWidget {
  /// The child to wrap.
  final Widget child;

  /// The space between the active input control and the top of the keyboard.
  /// Must be >= 0.
  final double? spacing;

  const KeyboardAvoid({
    Key? key,
    required this.child,
    this.spacing,
  }) : super(key: key);

  @override
  _KeyboardAvoidState createState() => _KeyboardAvoidState();
}

class _KeyboardAvoidState extends State<KeyboardAvoid>
    with AfterLayoutMixin<KeyboardAvoid>, WidgetsBindingObserver {
  final _focusNode = FocusNode();

  double _offset = 0;

  bool _hasFocus = false;

  double get _spacing => (widget.spacing ?? 0) < 0 ? 0 : widget.spacing ?? 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted &&
          MediaQuery.of(context).viewInsets.bottom == 0 &&
          _offset != 0) {
        setState(() {
          _offset = 0;
        });
      }
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _focusNode.addListener(() async {
      if (!_focusNode.hasFocus) {
        _handleLoseFocus();
      }
    });

    for (final node in _focusNode.traversalDescendants) {
      node.addListener(() {
        if (node.hasFocus) {
          _handleFocus();
        }
      });
    }
  }

  void _handleFocus() async {
    FocusNode primaryNode;

    try {
      primaryNode = _focusNode.traversalDescendants
          .firstWhere((element) => element.hasPrimaryFocus);
    } catch (_) {
      return;
    }

    try {
      // Wait for the bottom inset to update, unless another
      // child node has already been focused.
      if (!_hasFocus) {
        await waitForKeyboardFrameUpdate();
      } else {
        await Future.delayed(const Duration(milliseconds: 500))
            .catchError((_) {});
      }
    } catch (_) {
      // Catch possible timeout error
    }

    final viewPortBottom = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom -
        _spacing;
    final nodeBottom = primaryNode.rect.bottom;

    if (nodeBottom > viewPortBottom) {
      final overlap = nodeBottom - viewPortBottom;

      setState(() {
        _offset += overlap;
        _hasFocus = true;
      });
    }
  }

  // The keyboard frame will not update immediately upon focus, therefore
  // we need to see a change in the bottom inset, before scrolling the viewport.
  Future<void> waitForKeyboardFrameUpdate() {
    final completer = Completer();
    final currentBottomInset = MediaQuery.of(context).viewInsets.bottom;

    final timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      final newBottomInset = MediaQuery.of(context).viewInsets.bottom;

      if (currentBottomInset != newBottomInset) {
        completer.complete();
      }
    });

    return completer.future
        .timeout(const Duration(milliseconds: 1000))
        .whenComplete(() => timer.cancel());
  }

  void _handleLoseFocus() async {
    setState(() {
      _offset = 0;
      _hasFocus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: ClipRect(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(0, -_offset, 0),
          child: widget.child,
        ),
      ),
    );
  }
}
