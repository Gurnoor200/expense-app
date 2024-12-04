import 'package:expense_app/firebase/firebase_service.dart';
import 'package:expense_app/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Manager'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _firebaseService.getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final expenses = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Expenses',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: expenses?.length ?? 0,
                    itemBuilder: (context, index) {
                      final expense = expenses![index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(expense['title']),
                          subtitle: Text(
                              '${expense['category']} - \$${expense['amount']}'),
                          trailing: Text(expense['date']),
                          onLongPress: () {
                            // Use the 'id' field to delete the expense
                            _firebaseService.deleteExpense(expense['id']);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddExpenseScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
