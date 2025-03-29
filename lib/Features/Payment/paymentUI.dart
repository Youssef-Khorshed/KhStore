import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:store/Core/applocal.dart';
import 'package:store/Features/Payment/API_KEYS.dart';
import 'package:store/Features/cart/presentation/logic/bloc/cart_bloc.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.bloc});
  final CartBloc bloc;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          List<Map<String, dynamic>> items = [];
          for (int i = 0; i < widget.bloc.carts!.data!.cartItems!.length; i++) {
            items.add({
              "name": widget.bloc.carts!.data!.cartItems![i].product!.name,
              "quantity": widget.bloc.carts!.data!.cartItems![i].quantity,
              "price": widget.bloc.carts!.data!.cartItems![i].product!.price,
              "currency": "USD"
            });
          }

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => UsePaypal(
                  sandboxMode: true,
                  clientId: ApiKeys.clientID,
                  secretKey: ApiKeys.secretKey,
                  returnURL: "https://samplesite.com/return",
                  cancelURL: "https://samplesite.com/cancel",
                  transactions: ApiKeys.headers(
                      totalprice: widget.bloc.carts!.data!.total.toString(),
                      items: items),
                  note: "Contact us for any questions on your order.",
                  onSuccess: (Map params) async {
                    print("onSuccess: $params");
                  },
                  onError: (error) {
                    print("onError: $error");
                  },
                  onCancel: (params) {
                    print('cancelled: $params');
                  }),
            ),
          );
        },
        child: Text(
          getLang(context: context, key: "Confirm Order")!,
          style: const TextStyle(color: Colors.amber),
        ));
  }
}
