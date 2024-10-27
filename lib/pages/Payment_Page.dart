import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final dynamic data; // Accept data dynamically

  PaymentPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('ID: ${data['id']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Title: ${data['title']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Amount: \$${data['amount']}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Payment Method', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            ListTile(
              title: Text('Credit Card'),
              leading: Radio(
                value: 'Credit Card',
                groupValue: data['paymentMethod'],
                onChanged: (value) {
                  // Handle payment method change
                },
              ),
            ),
            ListTile(
              title: Text('PayPal'),
              leading: Radio(
                value: 'PayPal',
                groupValue: data['paymentMethod'],
                onChanged: (value) {
                  // Handle payment method change
                },
              ),
            ),
            // Add more payment methods as needed
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle payment logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment Successful!')),
                );
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
