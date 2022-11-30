import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

enum LineType {
  first, // 1
  second, // 2, 4
  third, // 3, 5, 7
  fourth, // 6, 8
  fifth, // 9
}

class LineTile extends StatelessWidget {
  final LineType lineType;
  final double maxSide;
  final double minSide;

  final AnimationController animationController;

  const LineTile(
      {Key? key,
      required this.lineType,
      this.maxSide = 100,
      this.minSide = 10,
      required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
//    timeDilation = 1; // change it to slow down animations while debugging
    var seq = TweenSequence([
      TweenSequenceItem(
          tween: Tween<double>(begin: maxSide, end: minSide), weight: 0.5),
      TweenSequenceItem(
          tween: Tween<double>(begin: minSide, end: maxSide), weight: 0.5),
    ]);

    var squareSizeChangeTweenAnimation = seq.animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          _getBeginForSquareType(),
          _getEndForSquareType(),
          curve: Curves.linear,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: squareSizeChangeTweenAnimation,
      builder: (BuildContext context, Widget? child) {
        var side = squareSizeChangeTweenAnimation.value;
        return SizedBox(
          // height: maxside,
          height: maxSide,
          width: 10,
          child: Center(
            child: Container(
              width: 100,
              height: side,
              color: getColor(),
            ),
          ),
        );
      },
    );
  }

  Color getColor() {
    if (lineType == LineType.first) {
      return Colors.red;
    } else if (lineType == LineType.second) {
      return Colors.yellow;
    } else if (lineType == LineType.third) {
      return Colors.orange;
    } else if (lineType == LineType.fourth) {
      return Colors.green;
    } else if (lineType == LineType.fifth) {
      return Colors.blueGrey;
    }
    return Colors.black;
  }

  double _getBeginForSquareType() {
    if (lineType == LineType.first) {
      return 0;
    } else if (lineType == LineType.second) {
      return 0.1;
    } else if (lineType == LineType.third) {
      return 0.2;
    } else if (lineType == LineType.fourth) {
      return 0.3;
    } else if (lineType == LineType.fifth) {
      return 0.4;
    }
    return 0;
  }

  double _getEndForSquareType() {
    return _getBeginForSquareType() + 0.3;
  }
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, value: 0, duration: const Duration(milliseconds: 2000))
      ..repeat();
//    _playAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LineTile(
                  lineType: LineType.first,
                  animationController: animationController!,
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: LineTile(
                      lineType: LineType.third,
                      animationController: animationController!),
                ),
                const SizedBox(
                  width: 5,
                ),
                LineTile(
                    lineType: LineType.third,
                    animationController: animationController!),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LineTile(
                      lineType: LineType.second,
                      animationController: animationController!),
                  const SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: LineTile(
                        lineType: LineType.third,
                        animationController: animationController!),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  LineTile(
                      lineType: LineType.fourth,
                      animationController: animationController!),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LineTile(
                    lineType: LineType.third,
                    animationController: animationController!),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: LineTile(
                      lineType: LineType.third,
                      animationController: animationController!),
                ),
                const SizedBox(
                  width: 5,
                ),
                LineTile(
                    lineType: LineType.fifth,
                    animationController: animationController!),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
}
