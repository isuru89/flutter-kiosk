import 'package:flutter/material.dart';
import 'dart:math' as math;

class RibbonShape extends StatelessWidget {
  const RibbonShape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationY(math.pi)..rotateX(math.pi),
      origin: Offset(90, 31),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: ClipPath(
              clipper: BottomClipper(),
              child: Container(
                width: 200.0,
                height: 42.0,
                padding: EdgeInsets.all(8.0),
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                width: 20.0,
                height: 20.0,
                color: Colors.red[700],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(15.0, 0.0);

    var firstControlPoint = Offset(7.5, 2.0);
    var firstPoint = Offset(5.0, 5.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(2.0, 7.5);
    var secondPoint = Offset(0.0, 15.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 20, size.height / 2);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(15.0, 0.0);

    var firstControlPoint = Offset(7.5, 2.0);
    var firstPoint = Offset(5.0, 5.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(2.0, 7.5);
    var secondPoint = Offset(0.0, 15.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 20, size.height / 2);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
