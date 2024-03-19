library number_counting_animation;

import 'package:flutter/material.dart';

class CountingAnimation extends StatefulWidget {
  const CountingAnimation({
    super.key,
    required this.value,
    required this.textStyle,
    this.scrollCount = 40,
    this.singleScollDuration = const Duration(milliseconds: 50),
    this.lastDuration = const Duration(milliseconds: 50),
    this.bgColor = Colors.transparent,
    this.useChar = false,
    this.useRefresh = true,
  });

  ///Show number value
  final String value;

  ///Text style
  final TextStyle textStyle;

  ///total amount of play to scroll animation. defalut : 40
  final int scrollCount;

  ///duration for each scroll animation. default : 50ms
  final Duration singleScollDuration;

  ///duration for last animation. default : 50ms
  final Duration lastDuration;

  ///widget back ground color. default : transparent
  final Color bgColor;

  ///value have non-animation character. default: false
  final bool useChar;

  ///restart animation when value changed. default : true
  final bool useRefresh;

  @override
  State<CountingAnimation> createState() => _CountingAnimationState();
}

class _CountingAnimationState extends State<CountingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late String strValue = widget.value;

  int tempCnt = 0;
  bool isLast = false;
  List<String> fixedString = [];

  @override
  void initState() {
    super.initState();
    if (widget.useChar) {
      for (var char in strValue.characters) {
        bool a = int.tryParse(char) != null;
        if (!a) {
          fixedString.add(char);
        }
      }
    }

    controller = AnimationController(
      duration: widget.singleScollDuration,
      vsync: this,
    );
    controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          if (tempCnt < widget.scrollCount) {
            tempCnt++;
            setState(() {});
            controller.reset();
            controller.forward();
          } else if (tempCnt == widget.scrollCount && !isLast) {
            // tempCnt++;
            setState(() {
              isLast = true;
            });
            controller.reset();
            controller.duration = widget.lastDuration;
            controller.forward();
          } else {
            // isLast = false;
          }
        }
      },
    );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initData() {
    if (widget.useChar) {
      for (var char in strValue.characters) {
        bool isInt = int.tryParse(char) != null;
        if (!isInt) {
          fixedString.add(char);
        }
      }
    } else {
      fixedString.clear();
    }
    isLast = false;
    strValue = widget.value;
    tempCnt = 0;
    controller.duration = widget.singleScollDuration;
  }

  @override
  void didUpdateWidget(covariant CountingAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.useRefresh && oldWidget.value != widget.value) {
      initData();
      controller.reset();
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(strValue.length, (idx) {
          if (fixedString.contains(strValue[idx])) {
            return Text(
              strValue[idx],
              style: widget.textStyle,
            );
          }
          return Container(
            color: widget.bgColor,
            child: Stack(
              children: [
                SlideTransition(
                  position: controller.drive(
                    Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0, -1), // Out of view above the top.
                    ),
                  ),
                  child: Text(
                    '${(tempCnt % 10 + (int.parse(strValue[idx]) - 1).abs()) % 10}',
                    style: widget.textStyle,
                  ),
                ),
                SlideTransition(
                  position: controller.drive(
                    Tween<Offset>(
                      begin:
                          const Offset(0, 1), // Out of view below the bottom.
                      end: Offset.zero,
                    ),
                  ),
                  child: Text(
                    '${isLast ? strValue[idx] : (tempCnt % 10 + int.parse(strValue[idx])) % 10}',
                    style: widget.textStyle,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
