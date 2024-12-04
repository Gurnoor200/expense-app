import 'package:flutter/material.dart';

class AddExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Title')),
            TextField(decoration: InputDecoration(labelText: 'Amount')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save expense
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
