import 'package:flutter/material.dart';

class CheckButton extends StatelessWidget {
  final ValueNotifier<bool> notifier;
  final Function() onTap;

  const CheckButton({super.key, required this.notifier, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 160.0,
      right: 0,
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, show, child) => show
            ? Center(
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10.0),
                      backgroundColor: Colors.green),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
