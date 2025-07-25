// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class PayPalService {
//   final String clientId =
//       'AXDyDrmWIZG2WBXdXw__ccVuYUxL7fahGUa-bdf1D5NW5Mb7WljRa7fcLup5CmBila3078Zts5xMdgHz'; // Sandbox
//   final String secret =
//       'EJYieMwovw_8y_Q2E3zaI9RgW-Tg5VyHnU7PMEqX--_1bd7weo6zzHzdZDn8GNxoxJ4h9J8rtWiXY91x'; // Sandbox

//   Future<String?> createPayment(double amount) async {
//     final String basicAuth =
//         'Basic ' + base64Encode(utf8.encode('$clientId:$secret'));

//     final response = await http.post(
//       Uri.parse('https://api.sandbox.paypal.com/v1/payments/payment'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': basicAuth,
//       },
//       body: json.encode({
//         "intent": "sale",
//         "payer": {
//           "payment_method": "paypal",
//         },
//         "transactions": [
//           {
//             "amount": {
//               "total": amount.toString(),
//               "currency": "USD",
//             },
//             "description": "Payment description.",
//           }
//         ],
//         "redirect_urls": {
//           "return_url": "http://return.url",
//           "cancel_url": "http://cancel.url",
//         },
//       }),
//     );

//     if (response.statusCode == 201) {
//       return json.decode(response.body)['id'];
//     } else {
//       throw Exception('Failed to create payment: ${response.body}');
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paypal_payment/paypal_payment.dart';

class PaypalPaymentExample extends StatefulWidget {
  const PaypalPaymentExample({super.key});

  @override
  State<PaypalPaymentExample> createState() => _PaypalPaymentExampleState();
}

class _PaypalPaymentExampleState extends State<PaypalPaymentExample> {
  // Web URL for callbacks
  final String url =
      "http://localhost:63329/app/example"; // Change this to your server URL
  final String clientId =
      "AXDyDrmWIZG2WBXdXw__ccVuYUxL7fahGUa-bdf1D5NW5Mb7WljRa7fcLup5CmBila3078Zts5xMdgHz"; // Sandbox Client ID
  final String secretKey =
      "EJYieMwovw_8y_Q2E3zaI9RgW-Tg5VyHnU7PMEqX--_1bd7weo6zzHzdZDn8GNxoxJ4h9J8rtWiXY91x"; // Sandbox Secret Key
  final String currencyCode = "USD";
  final String? amount = "100"; // Amount to be charged

  @override
  void initState() {
    super.initState();
    // For PayPal orders only in web, capture payment after successful callback to web route
    if (kIsWeb && Uri.base.queryParameters['PayerID'] != null) {
      checkForCallback();
    }
  }

  // Only for web
  checkForCallback() async {
    await PaypalOrderService.captureOrder(
      "v2/checkout/orders/${Uri.base.queryParameters['PayerID']}/capture",
      clientId: clientId,
      sandboxMode: true,
      secretKey: secretKey,
    );

    // Call your backend endpoint to proceed as needed
    // print(response);
  }

  // Callback functions
  onSuccessCallback(value) {
    print("PayPal success callback: $value");
  }

  onErrorCallback(error) {
    print("PayPal error callback: $error");
  }

  onCancelCallback() {
    print("PayPal payment canceled");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PayPal Payment Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PaypalOrderPayment(
                    sandboxMode: true,
                    returnURL: url, // Mandatory for web
                    cancelURL: url, // Mandatory for web
                    clientId: clientId,
                    secretKey: secretKey,
                    currencyCode: currencyCode,
                    amount: amount,
                    onSuccess: onSuccessCallback,
                    onError: onErrorCallback,
                    onCancel: onCancelCallback,
                  ),
                ));
              },
              child: const Text("PayPal Payment (Order)"),
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PaypalSubscriptionPayment(
                    sandboxMode: true,
                    clientId: clientId,
                    secretKey: secretKey,
                    productName: 'T-Shirt',
                    type: "PHYSICAL",
                    planName: 'T-shirt plan',
                    billingCycles: [
                      {
                        'tenure_type': 'REGULAR',
                        'sequence': 1,
                        "total_cycles": 12,
                        'pricing_scheme': {
                          'fixed_price': {
                            'currency_code': currencyCode,
                            'value': amount
                          }
                        },
                        'frequency': const {
                          "interval_unit": "MONTH",
                          "interval_count": 1
                        }
                      }
                    ],
                    paymentPreferences: const {"auto_bill_outstanding": true},
                    returnURL: url,
                    cancelURL: url,
                    onSuccess: onSuccessCallback,
                    onError: onErrorCallback,
                    onCancel: onCancelCallback,
                  ),
                ));
              },
              child: const Text("PayPal Payment (Subscription)"),
            ),
          ],
        ),
      ),
    );
  }
}
