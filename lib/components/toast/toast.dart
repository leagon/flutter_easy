import 'package:flutter/material.dart';
import 'package:flutter_easy/flutter_easy.dart';

const defaultBoxConstrains = BoxConstraints(
  minWidth: 100,
  maxWidth: 200,
  minHeight: 100,
  maxHeight: 300,
);

const desenBoxConstrains = BoxConstraints(
  minWidth: 100,
  maxWidth: 300,
  minHeight: 50,
  maxHeight: 300,
);

class ToastBackground extends StatelessWidget {
  final BoxConstraints boxConstraints;
  final Widget child;

  const ToastBackground({
    super.key,
    required this.child,
    this.boxConstraints = defaultBoxConstrains,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF4C4C4C),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.all(10),
      constraints: boxConstraints,
      child: child,
    );
  }
}

/// Image Toast
class ImageToast extends StatelessWidget {
  final Widget image;
  final String? message;

  const ImageToast({
    super.key,
    required this.image,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ToastBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          image,
          const SizedBox(height: 20),
          if (message != null)
            Text(
              message!,
              style: const TextStyle().s15.white,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}

/// Loading Toast
class LoadingToast extends StatelessWidget {
  final String? message;

  const LoadingToast({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return ToastBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: Colors.white),
          if (message != null) ...[
            const SizedBox(height: 20),
            Text(
              message!,
              style: const TextStyle().s15.white,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ]
        ],
      ),
    );
  }
}

/// Text Toast
class TextToast extends StatelessWidget {
  final String message;

  const TextToast({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return ToastBackground(
      boxConstraints: desenBoxConstrains,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle().s15.white,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Full Toast
class FullToast extends StatelessWidget {
  final bool withCancel;
  final VoidCallback? onDismiss;

  const FullToast({super.key, this.withCancel = false, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      color: Colors.black54,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.white),
          if (withCancel) ...[
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: TextButton(
                onPressed: onDismiss,
                child: Text(
                  "Cancel",
                  style: const TextStyle().s15.white,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
