import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Manager App')),
      body: const Center(child: Text('List of Expenses')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Expense Screen
          Navigator.of(context).pushNamed("");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
