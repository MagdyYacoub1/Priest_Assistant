import 'package:flutter/material.dart';
import 'drawer_ list.dart';
import 'package:provider/provider.dart';
import '../localization/my_localization.dart';
import '../localization/localization_constants.dart';

class CustomDrawer extends StatefulWidget {
  final Widget child;

  const CustomDrawer({Key key, @required this.child}) : super(key: key);

  static _CustomDrawerState of(BuildContext context) =>
      context.findAncestorStateOfType<_CustomDrawerState>();

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  static const Duration toggleDuration = Duration(milliseconds: 250);
  static double maxSlide = 255;
  static const double minDragStartEdge = 60;
  static double maxDragStartEdge = maxSlide - 16;
  AnimationController _controller;
  bool _canBeDragged = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _CustomDrawerState.toggleDuration,
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
      double delta = details.primaryDelta / maxSlide;
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
    } else if (_controller.value < 0.5) {
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
    final _locale = Provider.of<MyLocalization>(context).locale;
    maxSlide = (_locale.languageCode == Arabic)? -110: 255;
    return WillPopScope(
      onWillPop: () async {
        if (_controller.isCompleted) {
          close();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        onTap: toggle,
        child: AnimatedBuilder(
          animation: _controller,
          child: widget.child,
          builder: (context, child) {
            final double slide = maxSlide * _controller.value;
            final double scale = 1 -(_controller.value * 0.3);
            return Stack(
              children: <Widget>[
                MyDrawer(),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale, scale),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: _controller.isCompleted ? close : null,
                    child: child,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
