import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '../../ViewModels/constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _paymentItems = <PaymentItem>[
    // const PaymentItem(
    //   label: 'Total',
    //   amount: '99.99',
    //   status: PaymentItemStatus.final_price,
    // )
  ];
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Payment'),
        backgroundColor: defaultColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GooglePayButton(
              width: MediaQuery.of(context).size.width / 2,
              paymentConfigurationAsset: 'gpay.json',
              paymentItems: _paymentItems,
              style: GooglePayButtonStyle.white,
              type: GooglePayButtonType.pay,
              //margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
