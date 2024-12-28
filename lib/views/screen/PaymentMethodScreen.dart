import 'package:flutter/material.dart';
import 'package:project/views/widget/payment_option_tile.dart';
import 'package:project/views/screen/add_address_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedPayment = 'Amazon Pay';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Method',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose your payment method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  PaymentOptionTile(
                    iconPath: 'images/amazon_pay.png',
                    title: 'Amazon Pay',
                    value: 'Amazon Pay',
                    selectedPayment: selectedPayment,
                    onChanged: (String newValue) {
                      setState(() {
                        selectedPayment = newValue;
                      });
                    },
                  ),
                  PaymentOptionTile(
                    iconPath: 'images/visa_mastercard.png',
                    title: 'Credit Card',
                    value: 'Credit Card',
                    selectedPayment: selectedPayment,
                    onChanged: (String newValue) {
                      setState(() {
                        selectedPayment = newValue;
                      });
                    },
                  ),
                  PaymentOptionTile(
                    iconPath: 'images/paypal.png',
                    title: 'Paypal',
                    value: 'Paypal',
                    selectedPayment: selectedPayment,
                    onChanged: (String newValue) {
                      setState(() {
                        selectedPayment = newValue;
                      });
                    },
                  ),
                  PaymentOptionTile(
                    iconPath: 'images/google_pay.png',
                    title: 'Google Pay',
                    value: 'Google Pay',
                    selectedPayment: selectedPayment,
                    onChanged: (String newValue) {
                      setState(() {
                        selectedPayment = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAddressScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: const Text(
                  'Confirm Payment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
