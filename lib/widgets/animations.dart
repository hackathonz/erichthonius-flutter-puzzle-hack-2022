import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/widgets.dart';

class ConfettiAnimation extends StatefulWidget {
  final Widget child;

  final void Function(ConfettiController) onControllerCreate;

  final Duration duration;

  final BlastDirectionality blastDirectionality;

  final double blastDirection;

  final bool loop;

  final double gravity;

  final int particles;

  const ConfettiAnimation({
    Key? key,
    required final this.onControllerCreate,
    required final this.child,
    final this.blastDirectionality = BlastDirectionality.explosive,
    final this.duration = const Duration(milliseconds: 3000),
    final this.gravity = 0.3,
    final this.blastDirection = pi / 2,
    final this.loop = false,
    final this.particles = 20,
  }) : super(key: key);

  @override
  _ConfettiAnimationState createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends State<ConfettiAnimation> {
  late ConfettiController controller;

  @override
  void initState() {
    super.initState();

    controller = ConfettiController(
      duration: widget.duration,
    );

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        widget.onControllerCreate(controller);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      child: widget.child,
      confettiController: controller,
      blastDirectionality: widget.blastDirectionality,
      shouldLoop: widget.loop,
      blastDirection: widget.blastDirection,
      gravity: widget.gravity,
      numberOfParticles: widget.particles,
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}
