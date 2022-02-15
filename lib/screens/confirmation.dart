import 'package:flutter/material.dart';
import 'package:kioskflutter/component/button.dart';
import 'package:lottie/lottie.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  int state = 0;

  Future<String> waitForUserInput() {
    return Future.delayed(const Duration(seconds: 2), () {
      return "23";
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(""),
      content: Container(
        height: 360,
        width: 320,
        child: FutureBuilder(
          future: waitForUserInput(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _showOrderNumber();
            } else {
              return _showWaitingForSwipe();
            }
          },
        ),
      ),
    );
  }

  Widget _showOrderNumber() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LottieBuilder.asset(
          "assets/order-completion.json",
          width: 200,
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "ALL DONE",
            style:
                Theme.of(context).textTheme.headline6?.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Text(
                "Please take your receipt.",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Text(
                "Your order is on the way.",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        KioskButton(
          text: "COMPLETE",
          height: 48,
          onClicked: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Widget _showWaitingForSwipe() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          "assets/card-swiping.json",
          width: 200,
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "Swipe your card on the terminal to complete your payment.",
            style:
                Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
