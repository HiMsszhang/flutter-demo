import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final String activeText;
  final String inactiveText;
  final Color activeTextColor;
  final Color inactiveTextColor;

  const CustomSwitch({
    Key key,
    this.value,
    this.onChanged,
    this.activeColor = const Color(0xFFFFA06B),
    this.inactiveColor = const Color(0xFFE5E5E5),
    this.activeText = '',
    this.inactiveText = '',
    this.activeTextColor = Colors.white70,
    this.inactiveTextColor = Colors.white70,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> with SingleTickerProviderStateMixin {
  Animation _circleAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(begin: widget.value ? Alignment.centerRight : Alignment.centerLeft, end: widget.value ? Alignment.centerLeft : Alignment.centerRight).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false ? widget.onChanged(true) : widget.onChanged(false);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 60),
            width: 69.w,
            height: 42.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(42.w), color: _circleAnimation.value == Alignment.centerLeft ? widget.inactiveColor : widget.activeColor),
            child: Padding(
              padding: EdgeInsets.all(2.w),
              child: Stack(
                children: <Widget>[
                  AnimatedAlign(
                    duration: Duration(milliseconds: 60),
                    curve: Curves.bounceInOut,
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
