// Widget for minimalistic button to be used in the app.
//

import 'package:flutter/material.dart';

class MinimalisticButton extends StatefulWidget {
  const MinimalisticButton({
    Key? key,
    required this.onPressed,
    required this.height,
    required this.child,
    this.color,
    this.padding,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final double height;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  @override
  State<MinimalisticButton> createState() => _MinimalisticButtonState();
}

class _MinimalisticButtonState extends State<MinimalisticButton>
    with SingleTickerProviderStateMixin {
  double bezierHeight = 0.0;
  double bezierWidthFactor = 0.5;

  bool _isPressed = false;

  // ignore: non_constant_identifier_names
  Animation<double>? _SmoothReturnAnimation;
  // ignore: non_constant_identifier_names
  AnimationController? _SmoothReturnController;

  @override
  void initState() {
    super.initState();
    _SmoothReturnController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _SmoothReturnAnimation = Tween<double>(
      begin: bezierWidthFactor,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _SmoothReturnController!,
      curve: Curves.bounceOut,
    ));
    _SmoothReturnController!.addListener(() {
      setState(() {
        bezierWidthFactor = _SmoothReturnAnimation!.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // It shall look like a parabola completely filled with color.
    return GestureDetector(
      onPanUpdate: (details) => {
        setState(() {
          _isPressed = true;
          bezierHeight = details.localPosition.dy;
          bezierWidthFactor = 0.5 *
              details.localPosition.dx /
              MediaQuery.of(context).size.width *
              8;
          if (bezierWidthFactor > 0.5) bezierWidthFactor = 0.5;
          if (bezierWidthFactor < 0.0) bezierWidthFactor = 0.0;
        }),
      },
      onPanEnd: (details) => {
        // Animate smoothly back to the original position.
        setState(() {
          _isPressed = false;
          bezierHeight = 0.5;
          _SmoothReturnAnimation = Tween<double>(
            begin: bezierWidthFactor,
            end: 0.5,
          ).animate(CurvedAnimation(
            parent: _SmoothReturnController!,
            curve: Curves.bounceOut,
          ));
          _SmoothReturnController!.reset();
          _SmoothReturnController!.forward();
        }),
      },
      child: ClipPath(
        clipper: Clipper(bezierWidthFactor: bezierWidthFactor),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 56, 165, 255),
              Colors.white,
            ],
          )),
          padding: widget.padding,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              // transparent background color
              backgroundColor: const Color.fromARGB(0, 255, 255, 255),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
            ),
            child: SizedBox(
              // width according to the window width
              width: MediaQuery.of(context).size.width / 40,
              height: widget.height,
              // hides the icon when button is not pressed
              child: _isPressed
                  ? widget.child
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  Clipper({this.bezierWidthFactor = 0.5});
  double bezierWidthFactor;
  @override
  Path getClip(Size size) {
    var path = Path();
    // Slope calculated to find corresponding points with x = size.width
    var slope = (size.height * 0.5 - size.height * 0.3) /
        (size.width * bezierWidthFactor - size.width * 0.7);
    path.moveTo(size.width, size.height * 0.3 + size.width * 0.3 * slope);
    path.lineTo(size.width * 0.7, size.height * 0.3);
    path.quadraticBezierTo(size.width * bezierWidthFactor, size.height * 0.5,
        size.width * 0.7, size.height * 0.7);
    path.lineTo(size.width, size.height * 0.7 - size.width * 0.3 * slope);
    path.lineTo(size.width, size.height * 0.3 + size.width * 0.3 * slope);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
