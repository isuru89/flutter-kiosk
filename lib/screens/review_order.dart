import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_state.dart';
import 'package:kioskflutter/component/button.dart';
import 'package:kioskflutter/component/image_entity.dart';
import 'package:kioskflutter/component/review_item.dart';
import 'package:kioskflutter/constants.dart';
import 'package:kioskflutter/model/cart.dart';
import 'package:kioskflutter/screens/confirmation.dart';
import 'package:kioskflutter/views/cart_summary.dart';

class ReviewOrderContainer extends StatelessWidget {
  const ReviewOrderContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartBloc bloc = BlocProvider.of<CartBloc>(context);

    return BlocBuilder<CartBloc, CartState>(
      bloc: bloc,
      builder: (ctx, state) => ReviewOrder(
        items: state.items,
      ),
    );
  }
}

class ReviewOrder extends StatelessWidget {
  final List<CartItem> items;

  const ReviewOrder({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    List<Widget> itemsMapped = items
        .map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ReviewItem(
              cartItem: e,
            ),
          ),
        )
        .toList();
    itemsMapped.insert(0, _header(context));

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 11,
            child: Container(
              height: double.infinity,
              color: theme.backgroundColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: itemsMapped,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: theme.canvasColor,
                // border: Border(left: BorderSide(color: theme.shadowColor)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    offset: Offset(-2, 0),
                    color: theme.dividerColor,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [_backToMenu(context), const CartSummary()],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: BlocBuilder<CartBloc, CartState>(
                            buildWhen: (previous, current) =>
                                previous.total != current.total,
                            builder: (context, state) => KioskButton(
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "PAY",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 4,
                                      fontSize: 24,
                                    ),
                                  ),
                                  PriceLabel(
                                    price: state.total,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontSize: 24,
                                    ),
                                    priceTextStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              text: "PAY (\$${state.total.toStringAsFixed(2)})",
                              onClicked: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (_) => Container(
                                    child: const Confirmation(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Row(
        children: [
          Text(
            "REVIEW ORDER",
            style: Theme.of(context)
                .textTheme
                .headline2
                ?.copyWith(letterSpacing: 3),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Divider(),
            ),
          )
        ],
      ),
    );
  }

  Widget _backToMenu(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Icon(
                CupertinoIcons.chevron_back,
                color: kSecondaryTextColor,
                size: 24,
              ),
              Text(
                "BACK TO MENU",
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: kSecondaryTextColor,
                      letterSpacing: 3,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
