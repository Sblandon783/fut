import 'package:flutter/material.dart';

class AnimatedBounce extends StatefulWidget {
  final Widget child;
  const AnimatedBounce({super.key, required this.child});

  @override
  AnimatedBounceState createState() => AnimatedBounceState();
}

class AnimatedBounceState extends State<AnimatedBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
    lowerBound: 0.95,
    upperBound: 1,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
    reverseCurve: Curves.easeInOut,
  );
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: _animation,
        child: widget.child,
      );
}
