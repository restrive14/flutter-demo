import 'package:flutter/material.dart';

// 敲击木鱼增加功德数动画效果
class AnimateText extends StatefulWidget {
  final String text;
  const AnimateText({super.key, required this.text});

  @override
  State<AnimateText> createState() => _AnimateTextState();
}

class _AnimateTextState extends State<AnimateText>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<Offset> position;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    position = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(controller);
    scale = Tween<double>(begin: 1.0, end: 0.9).animate(controller);
    controller.forward();
  }

  @override
  void didUpdateWidget(covariant) {
    super.didUpdateWidget(covariant);
    controller.forward(from: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: SlideTransition(
        position: position,
        child: FadeTransition(
          opacity: opacity,
          child: Text(widget.text),
        ),
      ),
    );
  }
}
