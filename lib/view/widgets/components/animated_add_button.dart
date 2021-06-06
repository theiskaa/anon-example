import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../anon_widgets.dart';

class AnimatedAddButton extends AnonStatefulWidget {
  /// Custom Duration property of animationController.
  final Duration? animationDuration;

  /// Custom Color of the hover animation.
  final Color? hoverColor;

  /// Custom animated icon color.
  final Color? animatedIconColor;

  /// Custom animated border color.
  final Color? animatedBorderColor;

  /// onTap function for call custom body while animation is going.
  final VoidCallback onTap;

  /// Custom icon.
  final IconData? icon;

  AnimatedAddButton({
    Key? key,
    this.animationDuration,
    this.hoverColor,
    this.animatedIconColor,
    this.animatedBorderColor,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedAddButtonState createState() => _AnimatedAddButtonState();
}

class _AnimatedAddButtonState extends AnonState<AnimatedAddButton>
    with SingleTickerProviderStateMixin {
  // animation controller which were controlle all animations.
  // [_hoverAnimation], [_iconHoverAnimation] and [_borderHoverAnimation].
  late AnimationController _animationController;

  // Button background color animation.
  late Animation<Color?> _hoverAnimation;

  // Icon color animation.
  late Animation<Color?> _iconHoverAnimation;

  // Button's border color animation.
  late Animation<Color?> _borderHoverAnimation;

  @override
  void initState() {
    super.initState();

    // Initilaze animation controller.
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? Duration(milliseconds: 200),
    );

    // Initilaze hover animation.2
    _hoverAnimation = ColorTween(
      begin: Colors.transparent,
      end: widget.hoverColor ?? Colors.grey[900],
    ).animate(_animationController);

    // Initilaze icon color animation.
    _iconHoverAnimation = ColorTween(
      begin: Colors.blueGrey[900],
      end: widget.animatedIconColor ?? Colors.white,
    ).animate(_animationController);

    // Initilaze border color animation.
    _borderHoverAnimation = ColorTween(
      begin: Colors.black,
      end: widget.animatedBorderColor ?? Colors.blue[800],
    ).animate(_animationController);

    // For listen animation controller and rebuild state after calling [_animationController]
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => buildButton(),
    );
  }

  // Button body with gesture capability.
  GestureDetector buildButton() => GestureDetector(
        onTapDown: (details) {
          _animationController.forward();
        },
        onTapUp: (details) {
          _animationController.reverse();
          widget.onTap();
        },
        onTapCancel: () {
          _animationController.reverse();
        },
        child: buildButtonGrid(),
      );

  // The body of button.
  Container buildButtonGrid() => Container(
        height: 35,
        width: 35,
        decoration: buttonDecoration(),
        child: Center(
          child: Icon(
            widget.icon ?? CupertinoIcons.arrow_up_circle,
            color: _iconHoverAnimation.value,
            size: 28,
          ),
        ),
      );

  // Decoration of button.
  BoxDecoration buttonDecoration() => BoxDecoration(
        color: _hoverAnimation.value,
        border: Border.all(
          width: 2,
          color: _borderHoverAnimation.value!,
        ),
        shape: BoxShape.circle,
      );
}
