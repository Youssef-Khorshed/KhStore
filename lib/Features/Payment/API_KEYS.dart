abstract class ApiKeys {
  static String secretKey =
      "EG4C4G79wo0hjRPqss2A3XIJWrQJVd4DZUldcy1v2seuQvsufhHAikoZnHyG7Ma7YCo5l7QjhZV8VBUN";
  static String clientID =
      "Acs_-G7YEKKNs4k6tw6y4VpnZzj2_B9CYGRpIfTfnLZ5HxUc1b8qRj3iqows7zfVj8rdxOrp5P4K722V";

  static headers(
          {required String totalprice,
          required List<Map<String, dynamic>> items}) =>
      [
        {
          "amount": {
            "total": totalprice,
            "currency": "USD",
            "details": {
              "subtotal": totalprice,
              "shipping": '0',
              "shipping_discount": 0
            }
          },
          "description": "The payment transaction description.",
          // "payment_options": {
          //   "allowed_payment_method":
          //       "INSTANT_FUNDING_SOURCE"
          // },
          "item_list": {
            "items": items
            //  [
            //   {
            //     "name": "A demo product",
            //     "quantity": 1,
            //     "price": '10.12',
            //     "currency": "USD"
            //   }
            // ],

            // shipping address is not required though
            ,
            "shipping_address": {
              "recipient_name": "Jane Foster",
              "line1": "Travis County",
              "line2": "",
              "city": "Austin",
              "country_code": "US",
              "postal_code": "73301",
              "phone": "+00000000",
              "state": "Texas"
            },
          }
        }
      ];
}
