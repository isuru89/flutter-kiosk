import 'dart:ui';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Image.asset(
              "assets/food-bg.jpg",
              width: mq.size.width,
              height: mq.size.height,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.2),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 64),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: 64,
              runSpacing: 32,
              children: [
                OrderTypeText(
                  text: "TAKE OUT",
                  onClicked: () {
                    Navigator.pushNamed(context, '/menu');
                  },
                ),
                OrderTypeText(
                  text: "DINE IN",
                  onClicked: () {
                    Navigator.pushNamed(context, '/menu');
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OrderTypeText extends StatelessWidget {
  final String text;
  final Function() onClicked;

  OrderTypeText({Key? key, required this.text, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white,
        onTap: onClicked,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 8),
            borderRadius: BorderRadius.circular(5),
            color: Colors.black.withOpacity(0.2),
          ),
          constraints: const BoxConstraints(minWidth: 400, maxWidth: 400),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 48,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(.0, .0),
                  blurRadius: 10.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
