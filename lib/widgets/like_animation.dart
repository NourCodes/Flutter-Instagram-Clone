import 'package:flutter/cupertino.dart';
// This widget displays a heart-shaped animation when triggered, typically used for liking content

class LikeAnimation extends StatefulWidget {
  final Widget child; // child widget on which the animation is applied
  final bool
      isAnimating; // Indicates whether the animation is currently playing
  final Duration duration; // duration of the animation
  final VoidCallback?
      onEnd; // callback function invoked when the animation completes
  final bool like;
  const LikeAnimation(
      {Key? key,
      required this.child,
      required this.isAnimating,
      this.duration = const Duration(milliseconds: 150),
      this.onEnd,
      this.like = false})
      : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  Future startAnimation() async {
    if (widget.isAnimating || widget.like) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(
        const Duration(
          milliseconds: 70,
        ),
      );
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
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
      child: widget.child,
    );
  }
}
