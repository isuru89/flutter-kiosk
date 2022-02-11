import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_state.dart';

import '../constants.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: BlocBuilder<CartBloc, CartState>(
            bloc: cartBloc,
            builder: (context, state) => Column(
                  children: [
                    _summaryList(context, "SUB TOTAL",
                        "\$${state.subTotal.toStringAsFixed(2)}"),
                    _summaryList(
                        context, "TAX", "\$${state.tax.toStringAsFixed(2)}"),
                    _summaryList(context, "SERVICE CHARGE",
                        "\$${state.serviceCharge.toStringAsFixed(2)}")
                  ],
                )),
      ),
    );
  }

  Widget _summaryList(BuildContext context, String line, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            line,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                fontWeight: FontWeight.normal, color: kSecondaryTextColor),
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
