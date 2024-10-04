import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  final bool isFaceUp;
  final String frontDesign;
  final VoidCallback onTap;

  FlipCard(
      {required this.isFaceUp, required this.frontDesign, required this.onTap});

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    _rotationAnimation = Tween<double>(begin: 0, end: 2).animate(_controller);
  }

  @override
  void didUpdateWidget(FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isFaceUp != oldWidget.isFaceUp) {
      if (widget.isFaceUp) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (_, child) {
        final value = _rotationAnimation.value;
        final angle = value * 3.14159;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: angle <= 1.5708 ? _buildFaceDown() : _buildFaceUp(),
        );
      },
    );
  }

  Widget _buildFaceUp() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/card_front.png', fit: BoxFit.cover),
        Text(
          widget.frontDesign,
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }

  Widget _buildFaceDown() {
    return Image.asset('assets/card_back.png', fit: BoxFit.cover);
  }
}
