import 'package:flutter/material.dart';
import 'package:priest_assistant/translations/localization_constants.dart';
import 'drawer_ list.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomDrawer extends StatefulWidget {
  final Widget child;

  const CustomDrawer({Key? key, required this.child}) : super(key: key);

  static _CustomDrawerState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CustomDrawerState>();

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  static const Duration toggleDuration = Duration(milliseconds: 350);
  static double maxSlide = 255;
  static const double minDragStartEdge = 60;
  static double maxDragStartEdge = maxSlide - 16;
  late AnimationController _controller;
  late Animation<double> animation;
  bool _canBeDragged = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _CustomDrawerState.toggleDuration,
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft =
        _controller.isDismissed && details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight =
        _controller.isCompleted && details.globalPosition.dx > maxDragStartEdge;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      _controller.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (_controller.isDismissed || _controller.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _controller.fling(velocity: visualVelocity);
    } else if (animation.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  void close() => _controller.reverse();

  void open() => _controller.forward();

  void toggle() => _controller.isCompleted ? close() : open();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    maxSlide = (context.locale.languageCode == languageList[1].languageCode)
        ? -110
        : 255;
    return WillPopScope(
      onWillPop: () async {
        if (animation.isCompleted) {
          close();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        //onTap: toggle,
        child: AnimatedBuilder(
          animation: animation,
          child: widget.child,
          builder: (context, child) {
            final double slide = maxSlide * animation.value;
            final double scale = 1 - (animation.value * 0.3);
            return Stack(
              children: <Widget>[
                MyDrawer(),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale, scale),
                  alignment: Alignment.centerLeft,
                  child: child,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
