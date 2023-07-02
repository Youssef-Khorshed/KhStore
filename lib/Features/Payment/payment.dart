import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentHelper {
  static String publishableKey =
      'pk_test_51NJJYAIrGzQo7HkgqWuFPYDyPYJ8ELEvdjLDlRXdQrE6Ddvk0yAHra9d56jzbN4a9Fq0bENucFTU8KWoqsj6ZrLv00nV87HKJK';
  static Uri paymentApiUri =
      Uri.parse('https://api.stripe.com/v1/payment_intents');
  static String secret =
      'sk_test_51NJJYAIrGzQo7HkgkhgqQxDRdF0pGkWh6dNplBrt0jEal54MP5KGT0qfyINQiCX6dNeGkKfPqFNNwUbqa22J6PTS00WwpqOl1d';

  static String march_identifier = 'merchant.flutter.stripe.test';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': '${amount}00',
        'currency': 'USD',
      };

      var response =
          await http.post(paymentApiUri, headers: headers, body: body);
      return jsonDecode(response.body);
    } catch (error) {
      print('error Happened');
      throw error;
    }
  }

  static void display_paymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Done');
    } catch (error) {
      print('FAil $error');
    }
  }

  static Future<void> makepayment({required String price}) async {
    try {
      final paymentIntent = await createPaymentIntent(price, 'USD');
      const gpay = PaymentSheetGooglePay(
          merchantCountryCode: 'US', currencyCode: 'US', testEnv: true);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent['client_secret'],
              merchantDisplayName: march_identifier,
              googlePay: gpay,
              style: ThemeMode.dark));
      display_paymentSheet();
    } catch (error) {}
  }
}
